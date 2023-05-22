import 'package:adge/models/empresa.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:flutter/material.dart';

class EmpresasDataSource extends DataTableSource {
  final List<Empresa> empresas;

  EmpresasDataSource(this.empresas);

  @override
  DataRow getRow(int index) {
    final Empresa empresa = empresas[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(empresa.idEmpresa.toString())),
      DataCell(Text(empresa.nombreEmpresa)),
      DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo(
                '/dashboard/empresas/${empresa.idEmpresa}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.empresas.length;

  @override
  int get selectedRowCount => 0;
}
