import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/models/http/eventos_response.dart';
import 'package:flutter/material.dart';

class EventosProvider extends ChangeNotifier {
  List<Evento> eventos = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  EventosProvider(context) {
    getPaginatedEventos(context);
  }

  getPaginatedEventos(contex) async {
    Map<String, dynamic> data = {};
    final resp = await AdgeApi.Get('/empresa/Evento', data, contex);
    final eventosResp = EventosResponse.fromMap(resp);
    eventos = [...eventosResp.eventos];
    isLoading = false;
    notifyListeners();
  }

  Future<Evento?> getEventoById(String idEvento, context) async {
    try {
      Map<String, dynamic> data = {'idEvento': idEvento};
      final resp = await AdgeApi.Get('/empresa/Evento/evento', data, context);
      final evento = Evento.fromMap(resp);
      return evento;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Evento evento) getField) {
    eventos.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshEvento(Evento newEvento) {
    eventos = eventos.map((empresa) {
      if (empresa.idEvento == newEvento.idEvento) {
        empresa = newEvento;
      }

      return empresa;
    }).toList();

    notifyListeners();
  }
}
