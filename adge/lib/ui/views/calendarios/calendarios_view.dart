import 'package:adge/datatables/calendarios_datasource.dart';
import 'package:adge/datatables/eventos_datasource.dart';
import 'package:adge/providers/calendarios/calendarios_provider.dart';
import 'package:adge/providers/eventos/eventos_provider.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/calendarios/calendario_view.dart';
import 'package:adge/ui/views/empresas/empresa_view.dart';
import 'package:adge/ui/views/eventos/evento_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendariosView extends StatelessWidget {
  const CalendariosView({super.key});

  @override
  Widget build(BuildContext context) {
    final calendariosProvider = Provider.of<CalendariosProvider>(context);

    final calendariosDataSource =
        CalendariosDataSource(calendariosProvider.calendarios);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Calendarios', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            sortAscending: calendariosProvider.ascending,
            sortColumnIndex: calendariosProvider.sortColumnIndex,
            columns: [
              DataColumn(
                  label: const Text('Id'),
                  onSort: (colIndex, _) {
                    calendariosProvider.sortColumnIndex = colIndex;
                    calendariosProvider.sort<String>(
                        (calendario) => calendario.idCalendario.toString());
                  }),
              DataColumn(
                  label: const Text('Evento'),
                  onSort: (colIndex, _) {
                    calendariosProvider.sortColumnIndex = colIndex;
                    calendariosProvider.sort<String>((calendario) =>
                        calendario.evento.nombreEvento.toString());
                  }),
              DataColumn(
                  label: const Text('Fecha inicio'),
                  onSort: (colIndex, _) {
                    calendariosProvider.sortColumnIndex = colIndex;
                    calendariosProvider.sort<String>(
                        (calendario) => calendario.fechaInicio.toString());
                  }),
              DataColumn(
                  label: const Text('Fecha fin'),
                  onSort: (colIndex, _) {
                    calendariosProvider.sortColumnIndex = colIndex;
                    calendariosProvider.sort<String>(
                        (calendario) => calendario.fechaFin.toString());
                  }),
              const DataColumn(label: Text('Acciones')),
            ],
            source: calendariosDataSource,
            onPageChanged: (page) {
              print('page: $page');
            },
          ),
          Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                var calendario = const CalendarioView(
                  id: '',
                  isCreate: true,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => calendario),
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
