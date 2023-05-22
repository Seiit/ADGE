import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/empresa.dart';
import 'package:flutter/material.dart';

class EmpresaFormProvider extends ChangeNotifier {
  Empresa? empresa;
  late GlobalKey<FormState> formKey;

  copyEmpresaWith({
    int? idEmpresa,
    String? nombreEmpresa,
  }) {
    empresa = Empresa(
      idEmpresa: idEmpresa ?? this.empresa!.idEmpresa,
      nombreEmpresa: nombreEmpresa ?? this.empresa!.nombreEmpresa,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateEmpresa(context) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = empresa!.toMap();

    try {
      var resp = await AdgeApi.Put('/empresa/Empresa', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateEmpresa: $e');
      return false;
    }
  }

  Future createEmpresa(context) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = empresa!.toMap();

    try {
      var resp = await AdgeApi.Post('/empresa/Empresa', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }
}
