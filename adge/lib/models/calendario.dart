import 'dart:convert';

import 'package:adge/models/evento.dart';

class Calendario {
  Calendario({
    required this.idCalendario,
    required this.evento,
    required this.fechaInicio,
    required this.fechaFin,
  });

  int idCalendario;
  Evento evento;
  DateTime? fechaInicio;
  DateTime? fechaFin;

  factory Calendario.fromJson(String str) =>
      Calendario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Calendario.fromMap(Map<String, dynamic> json) => Calendario(
        idCalendario: json["idCalendario"],
        evento: Evento.fromMap(json['evento']),
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
      );

  Map<String, dynamic> toMap() => {
        "idCalendario": idCalendario,
        "evento": evento.toMap(),
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin
      };
}
