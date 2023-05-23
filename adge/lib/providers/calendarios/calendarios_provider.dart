import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/calendario.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/models/http/calendarios_response.dart';
import 'package:adge/models/http/eventos_response.dart';
import 'package:flutter/material.dart';

class CalendariosProvider extends ChangeNotifier {
  List<Calendario> calendarios = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  CalendariosProvider(context) {
    getPaginatedCalendarios(context);
  }

  getPaginatedCalendarios(contex) async {
    Map<String, dynamic> data = {};
    final resp = await AdgeApi.Get('/empresa/Calendario', data, contex);
    final calendariosResp = CalendariosResponse.fromMap(resp);
    calendarios = [...calendariosResp.calendarios];
    isLoading = false;
    notifyListeners();
  }

  Future<Calendario?> getCalendarioById(String idCalendario, context) async {
    try {
      Map<String, dynamic> data = {'idCalendario': idCalendario};
      final resp =
          await AdgeApi.Get('/empresa/Calendario/calendario', data, context);
      final calendario = Calendario.fromMap(resp);
      return calendario;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Calendario calendario) getField) {
    calendarios.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshCalendario(Calendario newCalendario) {
    calendarios = calendarios.map((calendario) {
      if (calendario.idCalendario == newCalendario.idCalendario) {
        calendario = newCalendario;
      }

      return calendario;
    }).toList();

    notifyListeners();
  }
}
