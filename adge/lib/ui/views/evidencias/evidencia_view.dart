import 'package:adge/models/evidencia.dart';
import 'package:adge/models/usuario.dart';
import 'package:adge/providers/evidencias/evidencia_form_provider.dart';
import 'package:adge/providers/user/user_form_provider.dart';
import 'package:adge/providers/user/users_provider.dart';
import 'package:adge/router/router.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/ui/cards/white_card.dart';
import 'package:adge/ui/labels/custom_labels.dart';
import 'package:adge/ui/views/asignaciones/asignaciones_view.dart';
import 'package:adge/ui/views/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class EvidenciaView extends StatefulWidget {
  final String uid;

  const EvidenciaView({Key? key, required this.uid}) : super(key: key);

  @override
  _EvidenciaViewState createState() => _EvidenciaViewState();
}

class _EvidenciaViewState extends State<EvidenciaView> {
  Evidencia? evidencia;

  @override
  void initState() {
    super.initState();
    final evidenciaFormProvider =
        Provider.of<EvidenciaFormProvider>(context, listen: false);

    evidenciaFormProvider.getEvidenciaById(widget.uid, context).then((userDB) {
      if (userDB != null) {
        evidenciaFormProvider.exist = true;
        evidenciaFormProvider.evidencia = userDB;
        evidenciaFormProvider.formKey = new GlobalKey<FormState>();

        setState(() {
          this.evidencia = userDB;
        });
      } else {
        evidenciaFormProvider.evidencia = Evidencia(
            idEvidencia: 0,
            idCalendario: int.parse(widget.uid),
            evidencia1: '',
            evidencia2: '',
            evidencia3: '',
            evidencia4: '');
        evidenciaFormProvider.formKey = new GlobalKey<FormState>();
        evidenciaFormProvider.exist = false;
        setState(() {
          this.evidencia = evidenciaFormProvider.evidencia;
        });
        //NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  @override
  void dispose() {
    Provider.of<EvidenciaFormProvider>(context, listen: false).evidencia = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Evidencia', style: CustomLabels.h1),
          SizedBox(height: 10),
          if (evidencia == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: _EvidenciaViewBody(),
            )),
          if (evidencia != null) _EvidenciaViewBody(),
        ],
      ),
    );
  }
}

class _EvidenciaViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {0: FixedColumnWidth(250)},
        children: [
          TableRow(children: [
            // AVATAR
            _Evidencia1Container(),
            _Evidencia2Container(),
            _Evidencia3Container(),
            _Evidencia4Container(),
          ]),
        ],
      ),
    );
  }
}

class _Evidencia1Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final evidenciaFormProvider = Provider.of<EvidenciaFormProvider>(context);
    final evidencia = evidenciaFormProvider.evidencia!;

    final image = (evidencia.evidencia1 == null || evidencia.evidencia1 == '')
        ? Image(image: AssetImage('Sin_datos.jpg'))
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: evidencia.evidencia1!);

    return !evidenciaFormProvider.exist!
        ? Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                evidenciaFormProvider.createEvidencia(context);
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            ),
          )
        : WhiteCard(
            width: 250,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Evidencia 1', style: CustomLabels.h2),
                  SizedBox(height: 20),
                  Container(
                      width: 150,
                      height: 160,
                      child: Stack(
                        children: [
                          ClipOval(child: image),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.white, width: 5)),
                              child: FloatingActionButton(
                                backgroundColor: Colors.indigo,
                                elevation: 0,
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  await evidenciaFormProvider.uploadImage1(
                                      '/empresa/Evidencia/evidencia1/1/',
                                      context);
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ));
  }
}

class _Evidencia2Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final evidenciaFormProvider = Provider.of<EvidenciaFormProvider>(context);
    final evidencia = evidenciaFormProvider.evidencia!;

    final image = (evidencia.evidencia2 == null || evidencia.evidencia2 == '')
        ? Image(image: AssetImage('Sin_datos.jpg'))
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: evidencia.evidencia2!);

    return !evidenciaFormProvider.exist!
        ? Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                evidenciaFormProvider.createEvidencia(context);
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            ),
          )
        : WhiteCard(
            width: 250,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Evidencia 2', style: CustomLabels.h2),
                  SizedBox(height: 20),
                  Container(
                      width: 150,
                      height: 160,
                      child: Stack(
                        children: [
                          ClipOval(child: image),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.white, width: 5)),
                              child: FloatingActionButton(
                                backgroundColor: Colors.indigo,
                                elevation: 0,
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  await evidenciaFormProvider.uploadImage2(
                                      '/empresa/Evidencia/evidencia2/2/',
                                      context);
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ));
  }
}

class _Evidencia3Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final evidenciaFormProvider = Provider.of<EvidenciaFormProvider>(context);
    final evidencia = evidenciaFormProvider.evidencia!;

    final image = (evidencia.evidencia3 == null || evidencia.evidencia3 == '')
        ? Image(image: AssetImage('Sin_datos.jpg'))
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: evidencia.evidencia3!);

    return !evidenciaFormProvider.exist!
        ? Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                evidenciaFormProvider.createEvidencia(context);
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            ),
          )
        : WhiteCard(
            width: 250,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Evidencia 3', style: CustomLabels.h2),
                  SizedBox(height: 20),
                  Container(
                      width: 150,
                      height: 160,
                      child: Stack(
                        children: [
                          ClipOval(child: image),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.white, width: 5)),
                              child: FloatingActionButton(
                                backgroundColor: Colors.indigo,
                                elevation: 0,
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  await evidenciaFormProvider.uploadImage3(
                                      '/empresa/Evidencia/evidencia3/3/',
                                      context);
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ));
  }
}

class _Evidencia4Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final evidenciaFormProvider = Provider.of<EvidenciaFormProvider>(context);
    final evidencia = evidenciaFormProvider.evidencia!;

    final image = (evidencia.evidencia4 == null || evidencia.evidencia4 == '')
        ? Image(image: AssetImage('Sin_datos.jpg'))
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: evidencia.evidencia4!);

    return !evidenciaFormProvider.exist!
        ? Container(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () {
                evidenciaFormProvider.createEvidencia(context);
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            ),
          )
        : WhiteCard(
            width: 250,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Evidencia 4', style: CustomLabels.h2),
                  SizedBox(height: 20),
                  Container(
                      width: 150,
                      height: 160,
                      child: Stack(
                        children: [
                          ClipOval(child: image),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.white, width: 5)),
                              child: FloatingActionButton(
                                backgroundColor: Colors.indigo,
                                elevation: 0,
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  await evidenciaFormProvider.uploadImage4(
                                      '/empresa/Evidencia/evidencia4/4/',
                                      context);
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ));
  }
}
