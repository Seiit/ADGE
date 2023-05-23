// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);
import 'dart:convert';

import 'package:adge/models/evento.dart';
import 'package:adge/models/empresa.dart';

class EventosResponse {
  EventosResponse({
    required this.total,
    required this.eventos,
  });

  int total;
  List<Evento> eventos;

  factory EventosResponse.fromJson(String str) =>
      EventosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventosResponse.fromMap(Map<String, dynamic> json) => EventosResponse(
        total: json["total"],
        eventos:
            List<Evento>.from(json["eventos"].map((x) => Evento.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "empresas": List<dynamic>.from(eventos.map((x) => x.toMap())),
      };
}
