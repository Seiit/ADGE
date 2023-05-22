import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/empresa.dart';
import 'package:adge/models/http/empresas_response.dart';
import 'package:flutter/material.dart';

class EmpresasProvider extends ChangeNotifier {
  List<Empresa> empresas = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  EmpresasProvider(context) {
    getPaginatedEmpresas(context);
  }

  getPaginatedEmpresas(contex) async {
    Map<String, dynamic> data = {};
    final resp = await AdgeApi.Get('/empresa/Empresa', data, contex);
    final empresasResp = EmpresasResponse.fromMap(resp);
    empresas = [...empresasResp.empresas];
    isLoading = false;
    notifyListeners();
  }

  Future<Empresa?> getEmpresaById(String idEmpresa, context) async {
    try {
      Map<String, dynamic> data = {'idEmpresa': idEmpresa};
      final resp = await AdgeApi.Get('/empresa/Empresa/empresa', data, context);
      final empresa = Empresa.fromMap(resp);
      return empresa;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Empresa empresa) getField) {
    empresas.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshEmpresa(Empresa newEmpresa) {
    empresas = empresas.map((empresa) {
      if (empresa.idEmpresa == newEmpresa.idEmpresa) {
        empresa = newEmpresa;
      }

      return empresa;
    }).toList();

    notifyListeners();
  }
}
