import 'dart:convert';

class Empresa {
  Empresa({
    required this.idEmpresa,
    required this.nombreEmpresa,
  });

  int idEmpresa;
  String nombreEmpresa;

  factory Empresa.fromJson(String str) => Empresa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Empresa.fromMap(Map<String, dynamic> json) => Empresa(
        idEmpresa: json["idEmpresa"],
        nombreEmpresa: json["nombreEmpresa"],
      );

  Map<String, dynamic> toMap() =>
      {"idEmpresa": idEmpresa, "nombreEmpresa": nombreEmpresa};
}
