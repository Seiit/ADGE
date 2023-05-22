import 'package:adge/models/empresa.dart';
import 'package:adge/providers/empresas/empresa_form_provider.dart';
import 'package:adge/providers/empresas/empresas_provider.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/ui/cards/white_card.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmpresaView extends StatefulWidget {
  final String id;
  final bool isCreate;

  const EmpresaView({Key? key, required this.id, required this.isCreate})
      : super(key: key);

  @override
  _EmpresaViewState createState() => _EmpresaViewState();
}

class _EmpresaViewState extends State<EmpresaView> {
  Empresa? empresa;

  @override
  void initState() {
    super.initState();
    final empresasProvider =
        Provider.of<EmpresasProvider>(context, listen: false);
    final empresaFormProvider =
        Provider.of<EmpresaFormProvider>(context, listen: false);
    if (!widget.isCreate) {
      empresasProvider.getEmpresaById(widget.id, context).then((empresaDB) {
        if (empresaDB != null) {
          empresaFormProvider.empresa = empresaDB;
          empresaFormProvider.formKey = GlobalKey<FormState>();

          setState(() {
            empresa = empresaDB;
          });
        } else {
          NavigationService.replaceTo('/dashboard/empresas');
        }
      });
    } else {
      empresaFormProvider.empresa = Empresa(idEmpresa: 0, nombreEmpresa: '');
      empresaFormProvider.formKey = GlobalKey<FormState>();
      setState(() {
        empresa = Empresa(idEmpresa: 0, nombreEmpresa: '');
      });
    }
  }

  @override
  void dispose() {
    Provider.of<EmpresaFormProvider>(context, listen: false).empresa = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Empresa', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (empresa == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )),
          if (empresa != null || widget.isCreate)
            _EmpresaViewBody(
              isCreate: widget.isCreate,
            )
        ],
      ),
    );
  }
}

class _EmpresaViewBody extends StatelessWidget {
  bool isCreate;

  _EmpresaViewBody({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(250)},
      children: [
        TableRow(children: [
          _EmpresaViewForm(isCreate: isCreate),
        ])
      ],
    );
  }
}

class _EmpresaViewForm extends StatelessWidget {
  var isCreate;

  _EmpresaViewForm({Key? key, required this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final empresaFormProvider = Provider.of<EmpresaFormProvider>(context);
    final empresa = empresaFormProvider.empresa!;

    return WhiteCard(
        title: 'Información general',
        child: Form(
          key: empresaFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Visibility(
                  visible: !isCreate,
                  child: TextFormField(
                    enabled: false,
                    initialValue: empresa.idEmpresa.toString(),
                    decoration: CustomInputs.formInputDecoration(
                        hint: 'ID',
                        label: 'Id',
                        icon: Icons.supervised_user_circle_outlined),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: empresa.nombreEmpresa,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Nombre',
                    label: 'Nombre',
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) =>
                    empresaFormProvider.copyEmpresaWith(nombreEmpresa: value),
                validator: (value) {
                  if (value!.isEmpty) return 'Nombre no válido';

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      if (isCreate) {
                        final saved =
                            await empresaFormProvider.createEmpresa(context);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Empresa creada', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<EmpresasProvider>(context, listen: false)
                              .getPaginatedEmpresas(context);
                          NavigationService.replaceTo('/dashboard/empresas');
                        } else {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarError(
                              'Advertencia:', 'No se pudo guardar', context);
                        }
                      } else {
                        final saved =
                            await empresaFormProvider.updateEmpresa(context);
                        if (saved) {
                          // ignore: use_build_context_synchronously
                          NotificationsService.showSnackbarSucces(
                              'Mensaje:', 'Empresa actualizada', context);
                          // ignore: use_build_context_synchronously
                          Provider.of<EmpresasProvider>(context, listen: false)
                              .refreshEmpresa(empresa);
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
