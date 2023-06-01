import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/calendario.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/models/empresa.dart';
import 'package:adge/models/evidencia.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/upload_image.dart';
import 'package:flutter/material.dart';

class EvidenciaFormProvider extends ChangeNotifier {
  Evidencia? evidencia;
  bool? exist;
  late GlobalKey<FormState> formKey;

  copyCalendarioWith({
    int? idEvidencia,
    int? idCalendario,
    String? evidencia1,
    String? evidencia2,
    String? evidencia3,
    String? evidencia4,
  }) {
    evidencia = Evidencia(
      idEvidencia: idEvidencia ?? this.evidencia!.idEvidencia,
      idCalendario: idCalendario ?? this.evidencia!.idCalendario,
      evidencia1: evidencia1 ?? this.evidencia!.evidencia1,
      evidencia2: evidencia2 ?? this.evidencia!.evidencia2,
      evidencia3: evidencia3 ?? this.evidencia!.evidencia3,
      evidencia4: evidencia4 ?? this.evidencia!.evidencia4,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future<Evidencia?> getEvidenciaById(String idEvidencia, context) async {
    try {
      Map<String, dynamic> data = {'idEvidencia': idEvidencia};
      final resp =
          await AdgeApi.Get('/empresa/Evidencia/evidencia', data, context);
      final evidencia = Evidencia.fromMap(resp);
      return evidencia;
    } catch (e) {
      return null;
    }
  }

  Future uploadImage1(String path, context) async {
    try {
      uploadEvidenciaImages(path, evidencia!, context, 1);
    } catch (e) {
      print(e);
      throw 'Error en user from provider provider';
    }
  }

  Future uploadImage2(String path, context) async {
    try {
      uploadEvidenciaImages(path, evidencia!, context, 2);
    } catch (e) {
      print(e);
      throw 'Error en user from provider provider';
    }
  }

  Future uploadImage3(String path, context) async {
    try {
      uploadEvidenciaImages(path, evidencia!, context, 3);
    } catch (e) {
      print(e);
      throw 'Error en user from provider provider';
    }
  }

  Future uploadImage4(String path, context) async {
    try {
      uploadEvidenciaImages(path, evidencia!, context, 4);
    } catch (e) {
      print(e);
      throw 'Error en user from provider provider';
    }
  }

  Future updateCalendario(context, idEvento, fechaInicio, fechaFin) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = {
      'idEvidencia': evidencia!.idEvidencia.toString(),
      'idCalendario': evidencia!.idCalendario.toString(),
      'evidencia1': evidencia!.evidencia1,
      'evidencia2': evidencia!.evidencia2,
      'evidencia3': evidencia!.evidencia3,
      'evidencia4': evidencia!.evidencia4
    };

    try {
      var resp = await AdgeApi.Put('/empresa/Calendario', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateEmpresa: $e');
      return false;
    }
  }

  Future createEvidencia(context) async {
    Map<String, dynamic> data = {
      'id_evidencia': "",
      'id_calendario': evidencia!.idCalendario.toString(),
      'evidencia1': evidencia!.evidencia1,
      'evidencia2': evidencia!.evidencia2,
      'evidencia3': evidencia!.evidencia3,
      'evidencia4': evidencia!.evidencia4
    };

    try {
      var resp = await AdgeApi.Post('/empresa/Evidencia', data, context);
      NavigationService.replaceTo(
          '/dashboard/evidencia/${evidencia!.idCalendario}');
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }
}
