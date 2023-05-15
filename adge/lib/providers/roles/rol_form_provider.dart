import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/rol.dart';
import 'package:flutter/material.dart';

class RolFormProvider extends ChangeNotifier {
  Rol? rolObj;
  late GlobalKey<FormState> formKey;

  copyRolWith({
    int? id,
    String? rol,
  }) {
    rolObj = Rol(
      id: id ?? this.rolObj!.id,
      rol: rol ?? this.rolObj!.rol,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateRol(context) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = rolObj!.toMap();

    try {
      var resp = await AdgeApi.Put('/user/Rol', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }

  Future createRol(context) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = rolObj!.toMap();

    try {
      var resp = await AdgeApi.Post('/user/Rol', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }
}
