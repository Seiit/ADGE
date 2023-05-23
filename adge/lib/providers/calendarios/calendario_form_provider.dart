import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/calendario.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/models/empresa.dart';
import 'package:flutter/material.dart';

class CalendarioFormProvider extends ChangeNotifier {
  Calendario? calendario;
  late GlobalKey<FormState> formKey;

  copyCalendarioWith(
      {int? idCalendario,
      Evento? evento,
      DateTime? fechaInicio,
      DateTime? fechaFin}) {
    calendario = Calendario(
      idCalendario: idCalendario ?? this.calendario!.idCalendario,
      evento: evento ?? this.calendario!.evento,
      fechaInicio: fechaInicio ?? this.calendario!.fechaInicio,
      fechaFin: fechaFin ?? this.calendario!.fechaFin,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateCalendario(context, idEvento, fechaInicio, fechaFin) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = {
      'idCalendario': calendario!.idCalendario.toString(),
      'IdEvento': idEvento,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin
    };

    try {
      var resp = await AdgeApi.Put('/empresa/Calendario', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateEmpresa: $e');
      return false;
    }
  }

  Future createCalendario(context, idEvento, fechaInicio, fechaFin) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = {
      'idCalendario': "",
      'IdEvento': idEvento,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin
    };

    try {
      var resp = await AdgeApi.Post('/empresa/Calendario', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }
}
