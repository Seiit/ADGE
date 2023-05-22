import 'package:adge/models/asignacion.dart';
import 'package:adge/models/empresa.dart';
import 'package:adge/models/rol.dart';
import 'package:adge/providers/asignaciones/asignaciones_provider.dart';
import 'package:adge/providers/asignaciones/asignacion_form_provider.dart';
import 'package:adge/providers/user/user_form_provider.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/ui/cards/white_card.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsignacionView extends StatefulWidget {
  final String id;
  final bool isCreate;

  const AsignacionView({Key? key, required this.id, required this.isCreate})
      : super(key: key);

  @override
  _AsignacionViewState createState() => _AsignacionViewState();
}

class _AsignacionViewState extends State<AsignacionView> {
  Asignacion? asignacion;

  @override
  void initState() {
    super.initState();
    final asignacionProvider =
        Provider.of<AsignacionesProvider>(context, listen: false);
    final asignacionFormProvider =
        Provider.of<AsignacionFormProvider>(context, listen: false);
    if (!widget.isCreate) {
      asignacionProvider
          .getAsignacionById(widget.id, context)
          .then((asiganacionDB) {
        if (asiganacionDB != null) {
          asignacionFormProvider.asignacion = asiganacionDB;
          asignacionFormProvider.formKey = GlobalKey<FormState>();

          setState(() {
            asignacion = asiganacionDB;
          });
        } else {
          NavigationService.replaceTo('/dashboard/usuarios');
        }
      });
    } else {
      asignacionFormProvider.asignacion = Asignacion(
          idAsignacion: 0,
          usuario: Provider.of<UserFormProvider>(context, listen: false).user!,
          empresa: Empresa(idEmpresa: 0, nombreEmpresa: ''),
          rol: Rol(id: 0, rol: ''));
      asignacionFormProvider.formKey = GlobalKey<FormState>();
      setState(() {
        asignacion = Asignacion(
            idAsignacion: 0,
            usuario:
                Provider.of<UserFormProvider>(context, listen: false).user!,
            empresa: Empresa(idEmpresa: 0, nombreEmpresa: ''),
            rol: Rol(id: 0, rol: ''));
      });
    }
  }

  @override
  void dispose() {
    Provider.of<AsignacionFormProvider>(context, listen: false).asignacion =
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
          Text('Asignacion', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (asignacion == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )),
          if (asignacion != null || widget.isCreate)
            _AsignacionViewBody(
              isCreate: widget.isCreate,
            )
        ],
      ),
    );
  }
}

class _AsignacionViewBody extends StatelessWidget {
  bool isCreate;

  _AsignacionViewBody({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(250)},
      children: [
        TableRow(children: [
          _AsignacionViewForm(isCreate: isCreate),
        ])
      ],
    );
  }
}

class _AsignacionViewForm extends StatelessWidget {
  var isCreate;

  _AsignacionViewForm({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final asignacionFormProvider = Provider.of<AsignacionFormProvider>(context);
    final asignacion = asignacionFormProvider.asignacion!;

    return WhiteCard(
        title: 'Información general',
        child: Form(
          key: asignacionFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Visibility(
                  visible: !isCreate,
                  child: TextFormField(
                    enabled: false,
                    initialValue: asignacion.idAsignacion.toString(),
                    decoration: CustomInputs.formInputDecoration(
                        hint: 'ID',
                        label: 'Id',
                        icon: Icons.supervised_user_circle_outlined),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                enabled: false,
                initialValue: asignacion.usuario.nombre,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Usuario',
                    label: 'Usuario',
                    icon: Icons.mark_email_read_outlined),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      if (isCreate) {
                        final saved = await asignacionFormProvider
                            .createAsignacion(context);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Asignacion creada', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<AsignacionesProvider>(context,
                                  listen: false)
                              .getPaginatedAsignaciones(
                                  context, asignacion.usuario.uid);
                          NavigationService.replaceTo(
                              '/dashboard/asignaciones');
                        } else {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarError(
                              'Advertencia:', 'No se pudo guardar', context);
                        }
                      } else {
                        final saved = await asignacionFormProvider
                            .updateAsignacion(context);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Asignacion actualizada', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<AsignacionesProvider>(context,
                                  listen: false)
                              .refreshAsignacion(asignacion);
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
