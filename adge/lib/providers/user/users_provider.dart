import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/http/users_response.dart';
import 'package:adge/models/usuario.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  UsersProvider(context) {
    this.getPaginatedUsers(context);
  }

  getPaginatedUsers(contex) async {
    Map<String, dynamic> data = {};
    final resp = await AdgeApi.Get('/user/Usuario', data, contex);
    final usersResp = UsersResponse.fromMap(resp);
    this.users = [...usersResp.usuarios];
    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserById(String uid, context) async {
    try {
      Map<String, dynamic> data = {'uid': uid};
      final resp = await AdgeApi.Get('/user/Usuario/user', data, context);
      final user = Usuario.fromMap(resp);
      return user;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshUser(Usuario newUser) {
    this.users = this.users.map((user) {
      if (user.uid == newUser.uid) {
        user = newUser;
      }

      return user;
    }).toList();

    notifyListeners();
  }
}
