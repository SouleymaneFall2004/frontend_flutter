import 'package:frontend_flutter/models/User.dart';
import 'Pointage.dart';

class Vigile extends User {
  final List<Pointage>? pointageList;

  Vigile({
    required super.id,
    required super.login,
    required super.password,
    required super.nom,
    required super.prenom,
    required super.telephone,
    required super.role,
    this.pointageList,
  });

  factory Vigile.fromJson(Map<String, dynamic> json) {
    return Vigile(
      id: json['id'],
      login: json['login'],
      password: json['password'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      role: json['role'],
      pointageList: json['pointageList'] != null
          ? List<Pointage>.from(json['pointageList'].map((e) => Pointage.fromJson(e)))
          : [],
    );
  }


}
