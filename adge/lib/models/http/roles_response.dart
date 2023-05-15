// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);
import 'dart:convert';

import 'package:adge/models/rol.dart';

class RolesResponse {
  RolesResponse({
    required this.total,
    required this.roles,
  });

  int total;
  List<Rol> roles;

  factory RolesResponse.fromJson(String str) =>
      RolesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RolesResponse.fromMap(Map<String, dynamic> json) => RolesResponse(
        total: json["total"],
        roles: List<Rol>.from(json["roles"].map((x) => Rol.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "roles": List<dynamic>.from(roles.map((x) => x.toMap())),
      };
}
