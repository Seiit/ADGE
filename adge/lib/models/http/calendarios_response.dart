// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);
import 'dart:convert';

import 'package:adge/models/calendario.dart';
import 'package:adge/models/evento.dart';

class CalendariosResponse {
  CalendariosResponse({
    required this.total,
    required this.calendarios,
  });

  int total;
  List<Calendario> calendarios;

  factory CalendariosResponse.fromJson(String str) =>
      CalendariosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CalendariosResponse.fromMap(Map<String, dynamic> json) =>
      CalendariosResponse(
        total: json["total"],
        calendarios: List<Calendario>.from(
            json["calendarios"].map((x) => Calendario.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "calendarios": List<dynamic>.from(calendarios.map((x) => x.toMap())),
      };
}
