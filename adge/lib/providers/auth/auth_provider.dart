import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/usuario.dart';
import 'package:adge/router/router.dart';
import 'package:adge/services/local_storage.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password, context) async {
    final data = {'correo': email, 'password': password};

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      authStatus = AuthStatus.authenticated;
      String tokenResult =
          await FirebaseAuth.instance.currentUser!.getIdToken(true);

      this.user = Usuario(
          rol: "rol",
          estado: true,
          google: true,
          nombre: 'nombre',
          correo: 'correo',
          uid: 'uid');
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      LocalStorage.prefs.setString('token', tokenResult);
      NavigationService.replaceTo('/');

      AdgeApi.configureDio();

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        NotificationsService.showSnackbarError(
            "Advertencia", 'Usuario no encontrado', context);
      } else if (e.code == 'wrong-password') {
        NotificationsService.showSnackbarError(
            "Advertencia", 'UContraseña incorrecta', context);
      }
    }
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      LocalStorage.prefs.remove('token');
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    } on FirebaseAuthException catch (e) {}
  }

  register(String email, String password, String name, context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = userCredential.user;
      String token = await user!.getIdToken(true);

      final data = {'nombre': name, 'correo': email, 'id': user.uid};

      AdgeApi.Post('/user/Usuario', data, context).then((json) {
        print(json);

        if (json != null) {
          authStatus = AuthStatus.authenticated;
          NavigationService.replaceTo(Flurorouter.dashboardRoute);

          authStatus = AuthStatus.authenticated;
          LocalStorage.prefs.setString('token', token);
          NavigationService.replaceTo(Flurorouter.dashboardRoute);

          AdgeApi.configureDio();
          notifyListeners();
        } else {
          user.delete();
        }
      }).catchError((e) {
        print('error en: $e');
        NotificationsService.showSnackbarError(
            'Advertencia', 'Usuario / Password no válidos', context);
      });

      // El usuario se registró correctamente
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        NotificationsService.showSnackbarAlert(
            'Advertencia:', 'La contraseña es debil', context);
      } else if (e.code == 'email-already-in-use') {
        NotificationsService.showSnackbarAlert('Advertencia:',
            'El email ya está en uso por otro usuario', context);
      }
    } catch (e) {}
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    try {
      if (FirebaseAuth.instance.currentUser != null) {
        String tokenResult =
            await FirebaseAuth.instance.currentUser!.getIdToken(true);

        this.user = Usuario(
            rol: "rol",
            estado: true,
            google: true,
            nombre: 'nombre',
            correo: 'correo',
            uid: 'uid');

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', tokenResult);
        notifyListeners();
        return true;
      } else {
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }
}
