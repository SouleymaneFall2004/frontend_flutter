import 'AbstractEntity.dart';
import 'cours.dart';
import 'etudiant.dart';

class EtudiantCours extends AbstractEntity {
  final Etudiant? etudiant;
  final Cours? cours;

  EtudiantCours({
    required super.id,
    this.etudiant,
    this.cours,
  });
  factory EtudiantCours.fromJson(Map<String, dynamic> json) {
  return EtudiantCours(
    id: json['id'],
    etudiant: json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null,
    cours: json['cours'] != null ? Cours.fromJson(json['cours']) : null,
  );
}

}