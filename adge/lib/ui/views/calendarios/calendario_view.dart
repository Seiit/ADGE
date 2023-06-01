import 'package:adge/models/calendario.dart';
import 'package:adge/models/empresa.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/providers/calendarios/calendario_form_provider.dart';
import 'package:adge/providers/calendarios/calendarios_provider.dart';
import 'package:adge/providers/eventos/evento_form_provider.dart';
import 'package:adge/providers/eventos/eventos_provider.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/ui/cards/white_card.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/inputs/custom_inputs.dart';
import 'package:adge/ui/views/shared/widgets/list2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarioView extends StatefulWidget {
  final String id;
  final bool isCreate;

  const CalendarioView({Key? key, required this.id, required this.isCreate})
      : super(key: key);

  @override
  _CalendarioViewState createState() => _CalendarioViewState();
}

class _CalendarioViewState extends State<CalendarioView> {
  Calendario? calendario;

  @override
  void initState() {
    super.initState();
    final calendariosProvider =
        Provider.of<CalendariosProvider>(context, listen: false);
    final calendarioFormProvider =
        Provider.of<CalendarioFormProvider>(context, listen: false);
    if (!widget.isCreate) {
      calendariosProvider
          .getCalendarioById(widget.id, context)
          .then((calendarioDB) {
        if (calendarioDB != null) {
          calendarioFormProvider.calendario = calendarioDB;
          calendarioFormProvider.formKey = GlobalKey<FormState>();

          setState(() {
            calendario = calendarioDB;
          });
        } else {
          NavigationService.replaceTo('/dashboard/eventos');
        }
      });
    } else {
      calendarioFormProvider.calendario = Calendario(
          idCalendario: 0,
          evento: Evento(
              idEvento: 0,
              empresa: Empresa(idEmpresa: 0, nombreEmpresa: ''),
              nombreEvento: ''),
          fechaInicio: null,
          fechaFin: null);
      calendarioFormProvider.formKey = GlobalKey<FormState>();
      setState(() {
        calendario = Calendario(
            idCalendario: 0,
            evento: Evento(
                idEvento: 0,
                empresa: Empresa(idEmpresa: 0, nombreEmpresa: ''),
                nombreEvento: ''),
            fechaInicio: null,
            fechaFin: null);
      });
    }
  }

  @override
  void dispose() {
    Provider.of<CalendarioFormProvider>(context, listen: false).calendario =
        null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Calendario', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (calendario == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )),
          if (calendario != null || widget.isCreate)
            _CalendarioViewBody(
              isCreate: widget.isCreate,
            )
        ],
      ),
    );
  }
}

class _CalendarioViewBody extends StatelessWidget {
  bool isCreate;

  _CalendarioViewBody({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(250)},
      children: [
        TableRow(children: [
          _CalendarioViewForm(isCreate: isCreate),
        ])
      ],
    );
  }
}

class _CalendarioViewForm extends StatelessWidget {
  var isCreate;
  TextEditingController evento = TextEditingController();
  TextEditingController fechaIncio = TextEditingController();
  TextEditingController fechaFin = TextEditingController();

  _CalendarioViewForm({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarioFormProvider = Provider.of<CalendarioFormProvider>(context);
    final calendario = calendarioFormProvider.calendario!;

    fechaIncio.text = calendario.fechaInicio.toString();
    fechaFin.text = calendario.fechaFin.toString();

    return WhiteCard(
        title: 'Información general',
        child: Form(
          key: calendarioFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Visibility(
                  visible: !isCreate,
                  child: TextFormField(
                    enabled: false,
                    initialValue: calendario.idCalendario.toString(),
                    decoration: CustomInputs.formInputDecoration(
                        hint: 'ID',
                        label: 'Id',
                        icon: Icons.supervised_user_circle_outlined),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                controller: fechaIncio,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Fecha inicio',
                    label: 'Fecha inicio',
                    icon: Icons.mark_email_read_outlined),
                onTap: () {
                  showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                      .then((value) {
                    if (value != null) {
                      fechaIncio.text = DateFormat().format(value!);
                    }
                  });
                },
                onChanged: (value) => calendarioFormProvider.copyCalendarioWith(
                    fechaInicio: DateTime.tryParse(value)),
                validator: (value) {
                  if (value!.isEmpty) return 'Fecha no válida';
                  return null;
                },
              ),
              TextFormField(
                controller: fechaFin,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Fecha fin',
                    label: 'Fecha fin',
                    icon: Icons.mark_email_read_outlined),
                onTap: () {
                  showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                      .then((value) {
                    if (value != null) {
                      fechaFin.text = DateFormat().format(value!);
                    }
                  });
                },
                onChanged: (value) => calendarioFormProvider.copyCalendarioWith(
                    fechaFin: DateTime.tryParse(value)),
                validator: (value) {
                  if (value!.isEmpty) return 'Fecha no válida';
                  return null;
                },
              ),
              List2(
                llave: 'idEvento',
                value: 'nombreEvento',
                lista: 'eventos',
                label: 'Evento',
                controlador: evento,
                apiReference: '/empresa/Evento',
                dropKey: isCreate ? "" : calendario.evento.idEvento.toString(),
              ),
              Visibility(
                  visible: !isCreate,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: ElevatedButton(
                        onPressed: () async {
                          NavigationService.replaceTo(
                              '/dashboard/evidencia/${calendario.idCalendario}');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.save_outlined, size: 20),
                            Text('  Evidencias')
                          ],
                        )),
                  )),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      if (isCreate) {
                        final saved =
                            await calendarioFormProvider.createCalendario(
                                context,
                                evento.value.text,
                                fechaIncio.value.text,
                                fechaFin.value.text);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Evento creado', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<EventosProvider>(context, listen: false)
                              .getPaginatedEventos(context);
                          NavigationService.replaceTo('/dashboard/eventos');
                        } else {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarError(
                              'Advertencia:', 'No se pudo guardar', context);
                        }
                      } else {
                        final saved =
                            await calendarioFormProvider.updateCalendario(
                                context,
                                evento.value.text,
                                fechaIncio.value.text,
                                fechaFin.value.text);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Evento actualizado', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<CalendariosProvider>(context,
                                  listen: false)
                              .refreshCalendario(calendario);
                        } else {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarError(
                              'Advertencia:', 'No se pudo guardar', context);
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.save_outlined, size: 20),
                        Text('  Guardar')
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
