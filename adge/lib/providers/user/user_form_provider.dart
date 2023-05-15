import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/usuario.dart';
import 'package:adge/services/upload_image.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;
  late GlobalKey<FormState> formKey;

  // void updateListener() {
  //   notifyListeners();
  // }
  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }) {
    user = new Usuario(
      rol: rol ?? this.user!.rol,
      estado: estado ?? this.user!.estado,
      google: google ?? this.user!.google,
      nombre: nombre ?? this.user!.nombre,
      correo: correo ?? this.user!.correo,
      uid: uid ?? this.user!.uid,
      img: img ?? this.user!.img,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser(context) async {
    if (!this._validForm()) return false;

    Map<String, dynamic> data = user!.toMap();

    try {
      final resp = await AdgeApi.Put('/user/Usuario', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }

  Future uploadImage(String path, context) async {
    try {
      uploadUserImages(path, user!, context);
    } catch (e) {
      print(e);
      throw 'Error en user from provider provider';
    }
  }
}
