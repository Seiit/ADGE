import 'package:adge/models/rol.dart';
import 'package:adge/providers/roles/rol_form_provider.dart';
import 'package:adge/providers/roles/roles_provider.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/ui/cards/white_card.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RolView extends StatefulWidget {
  final String id;
  final bool isCreate;

  const RolView({Key? key, required this.id, required this.isCreate})
      : super(key: key);

  @override
  _RolViewState createState() => _RolViewState();
}

class _RolViewState extends State<RolView> {
  Rol? rol;

  @override
  void initState() {
    super.initState();
    final rolesProvider = Provider.of<RolesProvider>(context, listen: false);
    final rolFormProvider =
        Provider.of<RolFormProvider>(context, listen: false);
    if (!widget.isCreate) {
      rolesProvider.getRolById(widget.id, context).then((rolDB) {
        if (rolDB != null) {
          rolFormProvider.rolObj = rolDB;
          rolFormProvider.formKey = GlobalKey<FormState>();

          setState(() {
            rol = rolDB;
          });
        } else {
          NavigationService.replaceTo('/dashboard/roles');
        }
      });
    } else {
      rolFormProvider.rolObj = Rol(id: 0, rol: '');
      rolFormProvider.formKey = GlobalKey<FormState>();
      setState(() {
        rol = Rol(id: 0, rol: '');
      });
    }
  }

  @override
  void dispose() {
    Provider.of<RolFormProvider>(context, listen: false).rolObj = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Rol', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (rol == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )),
          if (rol != null || widget.isCreate)
            _RolViewBody(
              isCreate: widget.isCreate,
            )
        ],
      ),
    );
  }
}

class _RolViewBody extends StatelessWidget {
  bool isCreate;

  _RolViewBody({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(250)},
      children: [
        TableRow(children: [
          _RolViewForm(isCreate: isCreate),
        ])
      ],
    );
  }
}

class _RolViewForm extends StatelessWidget {
  var isCreate;

  _RolViewForm({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rolFormProvider = Provider.of<RolFormProvider>(context);
    final rol = rolFormProvider.rolObj!;

    return WhiteCard(
        title: 'Información general',
        child: Form(
          key: rolFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Visibility(
                  visible: !isCreate,
                  child: TextFormField(
                    enabled: false,
                    initialValue: rol.id.toString(),
                    decoration: CustomInputs.formInputDecoration(
                        hint: 'ID',
                        label: 'Id',
                        icon: Icons.supervised_user_circle_outlined),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: rol.rol,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Rol',
                    label: 'Rol',
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) => rolFormProvider.copyRolWith(rol: value),
                validator: (value) {
                  if (value!.isEmpty) return 'Rol no válido';

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      if (isCreate) {
                        final saved = await rolFormProvider.createRol(context);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Rol creado', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<RolesProvider>(context, listen: false)
                              .getPaginatedRoles(context);
                          NavigationService.replaceTo('/dashboard/roles');
                        } else {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarError(
                              'Advertencia:', 'No se pudo guardar', context);
                        }
                      } else {
                        final saved = await rolFormProvider.updateRol(context);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Rol actualizado', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<RolesProvider>(context, listen: false)
                              .refreshRol(rol);
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
