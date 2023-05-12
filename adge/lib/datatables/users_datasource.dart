import 'package:adge/models/usuario.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:flutter/material.dart';

class UsersDataSource extends DataTableSource {
  final List<Usuario> users;

  UsersDataSource(this.users);

  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(user.nombre)),
      DataCell(Text(user.correo)),
      DataCell(Text(user.uid)),
      DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo('/dashboard/users/${user.uid}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.users.length;

  @override
  int get selectedRowCount => 0;
}
