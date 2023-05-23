import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/models/empresa.dart';
import 'package:flutter/material.dart';

class EventoFormProvider extends ChangeNotifier {
  Evento? evento;
  late GlobalKey<FormState> formKey;

  copyEventoWith({
    int? idEvento,
    Empresa? empresa,
    String? nombreEvento,
  }) {
    evento = Evento(
      idEvento: idEvento ?? this.evento!.idEvento,
      empresa: empresa ?? this.evento!.empresa,
      nombreEvento: nombreEvento ?? this.evento!.nombreEvento,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateEvento(context, idEmpresa) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = {
      'idEvento': evento!.idEvento.toString(),
      'IdEmpresa': idEmpresa,
      'nombreEvento': evento!.nombreEvento
    };

    try {
      var resp = await AdgeApi.Put('/empresa/Evento', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateEmpresa: $e');
      return false;
    }
  }

  Future createEvento(context, idEmpresa) async {
    if (!_validForm()) return false;

    Map<String, dynamic> data = {
      'idEvento': '',
      'IdEmpresa': idEmpresa,
      'nombreEvento': evento!.nombreEvento
    };

    try {
      var resp = await AdgeApi.Post('/empresa/Evento', data, context);
      return resp == null ? false : true;
    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }
  }
}
