import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/asignacion.dart';
import 'package:adge/models/empresa.dart';
import 'package:adge/models/http/asignaciones_response.dart';
import 'package:adge/models/rol.dart';
import 'package:flutter/material.dart';

class AsignacionesProvider extends ChangeNotifier {
  List<Asignacion> asignaciones = [];
  List<Empresa> empresas = [];
  List<Rol> roles = [];

  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  AsignacionesProvider(context) {}

  getPaginatedAsignaciones(contex, uid) async {
    Map<String, dynamic> data = {'uid': uid};
    final resp = await AdgeApi.Get('/user/Asignacion', data, contex);
    final asignacionesResp = AsignacionResponse.fromMap(resp);
    asignaciones = [...asignacionesResp.asignaciones];

    if (isLoading) {
      notifyListeners();
    }

    isLoading = false;
  }

  Future<Asignacion?> getAsignacionById(String idAsignacion, context) async {
    try {
      Map<String, dynamic> data = {'idAsignacion': idAsignacion};
      final resp =
          await AdgeApi.Get('/user/Asignacion/asignacion', data, context);
      final asignacion = Asignacion.fromMap(resp);
      return asignacion;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Asignacion asignacion) getField) {
    asignaciones.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshAsignacion(Asignacion newAsignacion) {
    asignaciones = asignaciones.map((asignacion) {
      if (asignacion.idAsignacion == newAsignacion.idAsignacion) {
        asignacion = newAsignacion;
      }

      return asignacion;
    }).toList();

    notifyListeners();
  }
}
