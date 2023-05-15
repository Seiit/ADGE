import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/http/roles_response.dart';
import 'package:adge/models/rol.dart';
import 'package:flutter/material.dart';

class RolesProvider extends ChangeNotifier {
  List<Rol> roles = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  RolesProvider(context) {
    getPaginatedRoles(context);
  }

  getPaginatedRoles(contex) async {
    Map<String, dynamic> data = {};
    final resp = await AdgeApi.Get('/user/Rol', data, contex);
    final rolesResp = RolesResponse.fromMap(resp);
    roles = [...rolesResp.roles];
    isLoading = false;
    notifyListeners();
  }

  Future<Rol?> getRolById(String uid, context) async {
    try {
      Map<String, dynamic> data = {'id': uid};
      final resp = await AdgeApi.Get('/user/Rol/rol', data, context);
      final rol = Rol.fromMap(resp);
      return rol;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Rol rol) getField) {
    roles.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshRol(Rol newRol) {
    roles = roles.map((rol) {
      if (rol.id == newRol.id) {
        rol = newRol;
      }

      return rol;
    }).toList();

    notifyListeners();
  }
}
