import 'package:flutter/material.dart';

class ControllerUtils{
  static TextEditingController setValue(String valor) {
    valor = valor == 'null' ? "" : valor;

    return TextEditingController.fromValue(TextEditingValue(text: valor));
  }
}