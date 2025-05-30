import 'AbstractEntity.dart';
import 'Annee.dart';
import 'Classe.dart';
import 'etudiant.dart';

class Inscription extends AbstractEntity {
  final DateTime date;
  final Etudiant? etudiant;
  final Annee? annee;
  final Classe? classe;

  Inscription({
    required super.id,
    required this.date,
    this.etudiant,
    this.annee,
    this.classe,
  });
  factory Inscription.fromJson(Map<String, dynamic> json) {
  return Inscription(
    id: json['id'],
    date: DateTime.parse(json['date']),
    etudiant: json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null,
    annee: json['annee'] != null ? Annee.fromJson(json['annee']) : null,
    classe: json['classe'] != null ? Classe.fromJson(json['classe']) : null,
  );
}

}
