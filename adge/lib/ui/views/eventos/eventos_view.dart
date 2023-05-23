import 'package:adge/datatables/eventos_datasource.dart';
import 'package:adge/providers/eventos/eventos_provider.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/empresas/empresa_view.dart';
import 'package:adge/ui/views/eventos/evento_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventosView extends StatelessWidget {
  const EventosView({super.key});

  @override
  Widget build(BuildContext context) {
    final eventosProvider = Provider.of<EventosProvider>(context);

    final empresasDataSource = EventosDataSource(eventosProvider.eventos);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Eventos', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            sortAscending: eventosProvider.ascending,
            sortColumnIndex: eventosProvider.sortColumnIndex,
            columns: [
              DataColumn(
                  label: const Text('Id'),
                  onSort: (colIndex, _) {
                    eventosProvider.sortColumnIndex = colIndex;
                    eventosProvider
                        .sort<String>((evento) => evento.idEvento.toString());
                  }),
              DataColumn(
                  label: const Text('Empresa'),
                  onSort: (colIndex, _) {
                    eventosProvider.sortColumnIndex = colIndex;
                    eventosProvider.sort<String>(
                        (evento) => evento.empresa.nombreEmpresa.toString());
                  }),
              DataColumn(
                  label: const Text('Evento'),
                  onSort: (colIndex, _) {
                    eventosProvider.sortColumnIndex = colIndex;
                    eventosProvider
                        .sort<String>((evento) => evento.nombreEvento);
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
                var evento = const EventoView(
                  id: '',
                  isCreate: true,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => evento),
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
