import 'AbstractEntity.dart';
import 'Inscription.dart';
import 'cours.dart';

class Classe extends AbstractEntity {
  final String niveau;
  final String filiere;
  final List<Inscription>? inscription;
  final List<Cours>? cours;

  Classe({
    required super.id,
    required this.niveau,
    required this.filiere,
    this.inscription,
    this.cours,
  });
  factory Classe.fromJson(Map<String, dynamic> json) {
  return Classe(
    id: json['id'],
    niveau: json['niveau'],
    filiere: json['filiere'],
    inscription: json['inscription'] != null
        ? List<Inscription>.from(
            json['inscription'].map((e) => Inscription.fromJson(e)))
        : null,
    cours: json['cours'] != null
        ? List<Cours>.from(json['cours'].map((e) => Cours.fromJson(e)))
        : null,
  );
}

}