import 'AbstractEntity.dart';
import 'etudiant.dart';

class Evenement extends AbstractEntity {
  final DateTime dateDebut;
  final String heureDebut;
  final String heureFin;
  final String justification;
  final String etat;
  final String type;
  final Etudiant? etudiant;

  Evenement({
    required super.id,
    required this.dateDebut,
    required this.heureDebut,
    required this.heureFin,
    required this.justification,
    required this.etat,
    required this.type,
    this.etudiant,
  });

   factory Evenement.fromJson(Map<String, dynamic> json) {
    return Evenement(
      id: json['id'],
      dateDebut: DateTime.parse(json['dateDebut']),
      heureDebut: json['heureDebut'] ?? '',
      heureFin: json['heureFin'] ?? '',
      justification: json['justification'] ?? '',
      etat: json['etat'] ?? '',
      type: json['type'] ?? '',
      etudiant: json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null,
    );
  }

}