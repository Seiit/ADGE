import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/asignacion.dart';
import 'package:adge/models/empresa.dart';
import 'package:adge/models/rol.dart';
import 'package:adge/models/usuario.dart';
import 'package:flutter/material.dart';

class AsignacionFormProvider extends ChangeNotifier {
  Asignacion? asignacion;
  late GlobalKey<FormState> formKey;

  copyAsignacionWith({
    int? idAsignacion,
    Usuario? usuario,
    Empresa? empresa,
    Rol? rol,
  }) {
    asignacion = Asignacion(
        idAsignacion: idAsignacion ?? this.asignacion!.idAsignacion,
        usuario: usuario ?? this.asignacion!.usuario,
        empresa: empresa ?? this.asignacion!.empresa,
        rol: rol ?? this.asignacion!.rol);
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateAsignacion(context, idUser, idRol, idEmpresa) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = {
      'id_Asignacion': asignacion!.idAsignacion.toString(),
      'id_usuario': idUser,
      'id_empresa': idEmpresa,
      'id_rol': idRol
    };

    try {
      var resp = await AdgeApi.Put('/user/Asignacion', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateEmpresa: $e');
      return false;
    }
  }

  Future createAsignacion(context, idUser, idRol, idEmpresa) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = {
      'id_Asignacion': '',
      'id_usuario': idUser,
      'id_empresa': idEmpresa,
      'id_rol': idRol
    };

    try {
      var resp = await AdgeApi.Post('/user/Asignacion', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }
}
