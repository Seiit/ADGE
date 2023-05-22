import 'package:adge/api/list2/list2_service.dart';
import 'package:adge/models/sistema/drop_down_data.dart';
import 'package:adge/utils/controller_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class List2 extends StatefulWidget {
  String? dropKey = "";
  double? size = 200;

  TextEditingController controlador;
  String apiReference;
  String label;
  String llave;
  String value;

  List2(
      {super.key,
      required this.llave,
      required this.value,
      required this.label,
      required this.controlador,
      required this.apiReference});

  @override
  State<StatefulWidget> createState() => _List2();
}

class _List2 extends State<List2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25),
        child: SizedBox(
            width: widget.size,
            child: Column(
              children: [
                SizedBox(width: widget.size, child: Text(widget.label)),
                FutureBuilder(
                    future: List2Service.getDropData(widget.apiReference,
                        context, widget.llave, widget.value),
                    builder: (context, snapshop) {
                      if (snapshop.hasData) {
                        return SizedBox(
                            child: DropdownButton(
                                value: widget.dropKey,
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    widget.dropKey = value.toString();
                                    widget.controlador.value =
                                        ControllerUtils.setValue(
                                                value.toString())
                                            .value;
                                  });
                                },
                                items: snapshop.data
                                    ?.map<DropdownMenuItem<String>>(
                                        (DropDownData value) {
                                  return DropdownMenuItem<String>(
                                    value: value.codigo,
                                    child: Text(value.etiqueta),
                                  );
                                }).toList()));
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            )));
  }
}
