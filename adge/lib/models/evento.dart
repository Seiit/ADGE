import 'dart:convert';

import 'package:adge/models/empresa.dart';

class Evento {
  Evento({
    required this.idEvento,
    required this.empresa,
    required this.nombreEvento,
  });

  int idEvento;
  Empresa empresa;
  String nombreEvento;

  factory Evento.fromJson(String str) => Evento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Evento.fromMap(Map<String, dynamic> json) => Evento(
        idEvento: json["idEvento"],
        empresa: Empresa.fromMap(json['empresa']),
        nombreEvento: json["nombreEvento"],
      );

  Map<String, dynamic> toMap() => {
        "idEvento": idEvento,
        "empresa": empresa.toMap(),
        "nombreEvento": nombreEvento
      };
}
