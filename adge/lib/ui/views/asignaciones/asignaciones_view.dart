import 'package:adge/datatables/asignaciones_datasource.dart';
import 'package:adge/providers/asignaciones/asignaciones_provider.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/asignaciones/asignacion_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsignacionesView extends StatelessWidget {
  final String uid;

  AsignacionesView({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final asignacionesProvider = Provider.of<AsignacionesProvider>(context);

    final asignacionesDataSource =
        AsignacionesDataSource(asignacionesProvider.asignaciones);

    asignacionesProvider.getPaginatedAsignaciones(context, uid);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Asignaciones', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            sortAscending: asignacionesProvider.ascending,
            sortColumnIndex: asignacionesProvider.sortColumnIndex,
            columns: [
              DataColumn(
                  label: const Text('Id'),
                  onSort: (colIndex, _) {
                    asignacionesProvider.sortColumnIndex = colIndex;
                    asignacionesProvider.sort<String>(
                        (asignacoin) => asignacoin.idAsignacion.toString());
                  }),
              DataColumn(
                  label: const Text('Usuario'),
                  onSort: (colIndex, _) {
                    asignacionesProvider.sortColumnIndex = colIndex;
                    asignacionesProvider.sort<String>(
                        (asignacion) => asignacion.usuario.nombre);
                  }),
              DataColumn(
                  label: const Text('Empresa'),
                  onSort: (colIndex, _) {
                    asignacionesProvider.sortColumnIndex = colIndex;
                    asignacionesProvider.sort<String>(
                        (asignacion) => asignacion.empresa.nombreEmpresa);
                  }),
              DataColumn(
                  label: const Text('Rol'),
                  onSort: (colIndex, _) {
                    asignacionesProvider.sortColumnIndex = colIndex;
                    asignacionesProvider
                        .sort<String>((asignacion) => asignacion.rol.rol);
                  }),
              const DataColumn(label: Text('Acciones')),
            ],
            source: asignacionesDataSource,
            onPageChanged: (page) {
              print('page: $page');
            },
          ),
          Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                var asignacion = const AsignacionView(
                  id: '',
                  isCreate: true,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => asignacion),
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
