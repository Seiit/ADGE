import 'dart:convert';

import 'package:adge/models/empresa.dart';
import 'package:adge/models/rol.dart';
import 'package:adge/models/usuario.dart';

class Asignacion {
  Asignacion(
      {required this.idAsignacion,
      required this.usuario,
      required this.empresa,
      required this.rol});

  int idAsignacion;
  Usuario usuario;
  Empresa empresa;
  Rol rol;

  factory Asignacion.fromJson(String str) =>
      Asignacion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Asignacion.fromMap(Map<String, dynamic> json) => Asignacion(
      idAsignacion: json["idAsignacion"],
      usuario: Usuario.fromJson(json["usuario"]),
      empresa: Empresa.fromJson(json['empresa']),
      rol: Rol.fromJson(json['rol']));

  Map<String, dynamic> toMap() => {
        "idAsignacion": idAsignacion,
        "usuario": usuario,
        "empresa": empresa,
        "rol": rol
      };
}
