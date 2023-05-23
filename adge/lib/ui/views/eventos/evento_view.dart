import 'package:adge/models/empresa.dart';
import 'package:adge/models/evento.dart';
import 'package:adge/providers/eventos/evento_form_provider.dart';
import 'package:adge/providers/eventos/eventos_provider.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/ui/cards/white_card.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/inputs/custom_inputs.dart';
import 'package:adge/ui/views/shared/widgets/list2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventoView extends StatefulWidget {
  final String id;
  final bool isCreate;

  const EventoView({Key? key, required this.id, required this.isCreate})
      : super(key: key);

  @override
  _EventoViewState createState() => _EventoViewState();
}

class _EventoViewState extends State<EventoView> {
  Evento? evento;

  @override
  void initState() {
    super.initState();
    final eventosProvider =
        Provider.of<EventosProvider>(context, listen: false);
    final eventoFormProvider =
        Provider.of<EventoFormProvider>(context, listen: false);
    if (!widget.isCreate) {
      eventosProvider.getEventoById(widget.id, context).then((eventoDB) {
        if (eventoDB != null) {
          eventoFormProvider.evento = eventoDB;
          eventoFormProvider.formKey = GlobalKey<FormState>();

          setState(() {
            evento = eventoDB;
          });
        } else {
          NavigationService.replaceTo('/dashboard/eventos');
        }
      });
    } else {
      eventoFormProvider.evento = Evento(
          idEvento: 0,
          empresa: Empresa(idEmpresa: 0, nombreEmpresa: ''),
          nombreEvento: '');
      eventoFormProvider.formKey = GlobalKey<FormState>();
      setState(() {
        evento = Evento(
            idEvento: 0,
            empresa: Empresa(idEmpresa: 0, nombreEmpresa: ''),
            nombreEvento: '');
      });
    }
  }

  @override
  void dispose() {
    Provider.of<EventoFormProvider>(context, listen: false).evento = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Evento', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (evento == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )),
          if (evento != null || widget.isCreate)
            _EventoViewBody(
              isCreate: widget.isCreate,
            )
        ],
      ),
    );
  }
}

class _EventoViewBody extends StatelessWidget {
  bool isCreate;

  _EventoViewBody({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(250)},
      children: [
        TableRow(children: [
          _EventoViewForm(isCreate: isCreate),
        ])
      ],
    );
  }
}

class _EventoViewForm extends StatelessWidget {
  var isCreate;
  TextEditingController empresa = TextEditingController();

  _EventoViewForm({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventoFormProvider = Provider.of<EventoFormProvider>(context);
    final evento = eventoFormProvider.evento!;

    return WhiteCard(
        title: 'Información general',
        child: Form(
          key: eventoFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Visibility(
                  visible: !isCreate,
                  child: TextFormField(
                    enabled: false,
                    initialValue: evento.idEvento.toString(),
                    decoration: CustomInputs.formInputDecoration(
                        hint: 'ID',
                        label: 'Id',
                        icon: Icons.supervised_user_circle_outlined),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: evento.nombreEvento,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Nombre',
                    label: 'Nombre',
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) =>
                    eventoFormProvider.copyEventoWith(nombreEvento: value),
                validator: (value) {
                  if (value!.isEmpty) return 'Nombre no válido';
                  return null;
                },
              ),
              List2(
                llave: 'idEmpresa',
                value: 'nombreEmpresa',
                lista: 'empresas',
                label: 'Empresa',
                controlador: empresa,
                apiReference: '/empresa/Empresa',
                dropKey: isCreate ? "" : evento.empresa.idEmpresa.toString(),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      if (isCreate) {
                        final saved = await eventoFormProvider.createEvento(
                            context, empresa.value.text);
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
                        final saved = await eventoFormProvider.updateEvento(
                            context, empresa.value.text);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Evento actualizado', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<EventosProvider>(context, listen: false)
                              .refreshEvento(evento);
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
