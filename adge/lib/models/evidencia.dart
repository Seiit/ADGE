import 'dart:convert';

import 'package:adge/models/evento.dart';

class Evidencia {
  Evidencia({
    required this.idEvidencia,
    required this.idCalendario,
    required this.evidencia1,
    required this.evidencia2,
    required this.evidencia3,
    required this.evidencia4,
  });

  int idEvidencia;
  int idCalendario;
  String evidencia1;
  String evidencia2;
  String evidencia3;
  String evidencia4;

  factory Evidencia.fromJson(String str) => Evidencia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Evidencia.fromMap(Map<String, dynamic> json) => Evidencia(
        idEvidencia: json["id_evidencia"],
        idCalendario: json["idCalendario"],
        evidencia1: json['evidencia1'],
        evidencia2: json['evidencia2'],
        evidencia3: json['evidencia3'],
        evidencia4: json['evidencia4'],
      );

  Map<String, dynamic> toMap() => {
        "idEvidencia": idEvidencia,
        "idCalendario": idCalendario,
        "evidencia1": evidencia1,
        "evidencia2": evidencia2,
        "evidencia3": evidencia3,
        "evidencia4": evidencia4,
      };
}
