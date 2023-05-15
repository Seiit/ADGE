import 'package:adge/datatables/roles_datasource.dart';
import 'package:adge/providers/roles/roles_provider.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/roles/rol_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RolesView extends StatelessWidget {
  const RolesView({super.key});

  @override
  Widget build(BuildContext context) {
    final rolesProvider = Provider.of<RolesProvider>(context);

    final rolesDataSource = RolesDataSource(rolesProvider.roles);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Roles', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            sortAscending: rolesProvider.ascending,
            sortColumnIndex: rolesProvider.sortColumnIndex,
            columns: [
              DataColumn(
                  label: const Text('Id'),
                  onSort: (colIndex, _) {
                    rolesProvider.sortColumnIndex = colIndex;
                    rolesProvider.sort<String>((rol) => rol.id.toString());
                  }),
              DataColumn(
                  label: const Text('Rol'),
                  onSort: (colIndex, _) {
                    rolesProvider.sortColumnIndex = colIndex;
                    rolesProvider.sort<String>((rol) => rol.rol);
                  }),
              const DataColumn(label: Text('Acciones')),
            ],
            source: rolesDataSource,
            onPageChanged: (page) {
              print('page: $page');
            },
          ),
          Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                var rol = const RolView(
                  id: '',
                  isCreate: true,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => rol),
                );
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
