import 'package:frontend_flutter/models/User.dart';
import 'Cours.dart';

class Professeur extends User {
  final List<Cours>? cours;

  Professeur({
    required super.id,
    required super.login,
    required super.password,
    required super.nom,
    required super.prenom,
    required super.telephone,
    required super.role,
    this.cours,
  });

  factory Professeur.fromJson(Map<String, dynamic> json) {
    return Professeur(
      id: json['id'],
      login: json['login'],
      password: json['password'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      role: json['role'],
      cours: json['cours'] != null
          ? List<Cours>.from(json['cours'].map((e) => Cours.fromJson(e)))
          : [],
    );
  }
}


