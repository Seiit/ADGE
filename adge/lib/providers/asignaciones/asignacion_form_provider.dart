import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/asignacion.dart';
import 'package:adge/models/empresa.dart';
import 'package:adge/models/rol.dart';
import 'package:adge/models/usuario.dart';
import 'package:adge/providers/empresas/empresas_provider.dart';
import 'package:adge/providers/roles/roles_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsignacionFormProvider extends ChangeNotifier {
  Asignacion? asignacion;
  late GlobalKey<FormState> formKey;

  copyEmpresaWith({
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

  Future updateAsignacion(context) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = asignacion!.toMap();

    try {
      var resp = await AdgeApi.Put('/user/Asignacion', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateEmpresa: $e');
      return false;
    }
  }

  Future createAsignacion(context) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = asignacion!.toMap();

    try {
      var resp = await AdgeApi.Post('/user/Asignacion', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }
}
