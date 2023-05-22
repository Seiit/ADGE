import 'package:adge/models/asignacion.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:flutter/material.dart';

class AsignacionesDataSource extends DataTableSource {
  final List<Asignacion> asignaciones;

  AsignacionesDataSource(this.asignaciones);

  @override
  DataRow getRow(int index) {
    final Asignacion asignacion = asignaciones[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(asignacion.idAsignacion.toString())),
      DataCell(Text(asignacion.usuario.nombre)),
      DataCell(Text(asignacion.empresa.nombreEmpresa)),
      DataCell(Text(asignacion.rol.rol)),
      DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo(
                '/dashboard/asignaciones/${asignacion.idAsignacion}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.asignaciones.length;

  @override
  int get selectedRowCount => 0;
}
