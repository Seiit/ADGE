import 'package:adge/datatables/empresas_datasource.dart';
import 'package:adge/providers/empresas/empresas_provider.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/empresas/empresa_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmpresasView extends StatelessWidget {
  const EmpresasView({super.key});

  @override
  Widget build(BuildContext context) {
    final empresasProvider = Provider.of<EmpresasProvider>(context);

    final empresasDataSource = EmpresasDataSource(empresasProvider.empresas);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Empresas', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            sortAscending: empresasProvider.ascending,
            sortColumnIndex: empresasProvider.sortColumnIndex,
            columns: [
              DataColumn(
                  label: const Text('Id'),
                  onSort: (colIndex, _) {
                    empresasProvider.sortColumnIndex = colIndex;
                    empresasProvider.sort<String>(
                        (empresa) => empresa.idEmpresa.toString());
                  }),
              DataColumn(
                  label: const Text('Empresa'),
                  onSort: (colIndex, _) {
                    empresasProvider.sortColumnIndex = colIndex;
                    empresasProvider
                        .sort<String>((empresa) => empresa.nombreEmpresa);
                  }),
              const DataColumn(label: Text('Acciones')),
            ],
            source: empresasDataSource,
            onPageChanged: (page) {
              print('page: $page');
            },
          ),
          Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                var empresa = const EmpresaView(
                  id: '',
                  isCreate: true,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => empresa),
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
