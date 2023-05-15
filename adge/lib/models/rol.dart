import 'dart:convert';

class Rol {
  Rol({
    required this.id,
    required this.rol,
  });

  int id;
  String rol;

  factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        id: json["id"],
        rol: json["rol"],
      );

  Map<String, dynamic> toMap() => {"id": id, "rol": rol};
}
