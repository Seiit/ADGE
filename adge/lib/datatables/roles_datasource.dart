import 'package:adge/models/rol.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:flutter/material.dart';

class RolesDataSource extends DataTableSource {
  final List<Rol> roles;

  RolesDataSource(this.roles);

  @override
  DataRow getRow(int index) {
    final Rol rol = roles[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(rol.id.toString())),
      DataCell(Text(rol.rol)),
      DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo('/dashboard/roles/${rol.id}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.roles.length;

  @override
  int get selectedRowCount => 0;
}
