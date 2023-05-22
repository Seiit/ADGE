// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);
import 'dart:convert';

import 'package:adge/models/empresa.dart';

class EmpresasResponse {
  EmpresasResponse({
    required this.total,
    required this.empresas,
  });

  int total;
  List<Empresa> empresas;

  factory EmpresasResponse.fromJson(String str) =>
      EmpresasResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmpresasResponse.fromMap(Map<String, dynamic> json) =>
      EmpresasResponse(
        total: json["total"],
        empresas:
            List<Empresa>.from(json["empresas"].map((x) => Empresa.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "empresas": List<dynamic>.from(empresas.map((x) => x.toMap())),
      };
}
