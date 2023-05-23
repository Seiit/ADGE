import 'package:adge/models/evento.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:flutter/material.dart';

class EventosDataSource extends DataTableSource {
  final List<Evento> eventos;

  EventosDataSource(this.eventos);

  @override
  DataRow getRow(int index) {
    final Evento evento = eventos[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(evento.idEvento.toString())),
      DataCell(Text(evento.empresa.nombreEmpresa.toString())),
      DataCell(Text(evento.nombreEvento)),
      DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo(
                '/dashboard/eventos/${evento.idEvento}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.eventos.length;

  @override
  int get selectedRowCount => 0;
}
