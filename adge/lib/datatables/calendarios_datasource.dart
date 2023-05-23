import 'package:adge/models/calendario.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:flutter/material.dart';

class CalendariosDataSource extends DataTableSource {
  final List<Calendario> calendarios;

  CalendariosDataSource(this.calendarios);

  @override
  DataRow getRow(int index) {
    final Calendario calendario = calendarios[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(calendario.idCalendario.toString())),
      DataCell(Text(calendario.evento.nombreEvento.toString())),
      DataCell(Text(calendario.fechaInicio.toString())),
      DataCell(Text(calendario.fechaFin.toString())),
      DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo(
                '/dashboard/calendarios/${calendario.idCalendario}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.calendarios.length;

  @override
  int get selectedRowCount => 0;
}
