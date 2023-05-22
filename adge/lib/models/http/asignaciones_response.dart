// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);
import 'dart:convert';

import 'package:adge/models/asignacion.dart';

class AsignacionResponse {
  AsignacionResponse({
    required this.total,
    required this.asignaciones,
  });

  int total;
  List<Asignacion> asignaciones;

  factory AsignacionResponse.fromJson(String str) =>
      AsignacionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AsignacionResponse.fromMap(Map<String, dynamic> json) =>
      AsignacionResponse(
        total: json["total"],
        asignaciones: List<Asignacion>.from(
            json["asignaciones"].map((x) => Asignacion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "asignaciones": List<dynamic>.from(asignaciones.map((x) => x.toMap())),
      };
}
