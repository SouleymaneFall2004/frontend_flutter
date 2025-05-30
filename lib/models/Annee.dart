import 'AbstractEntity.dart';
import 'Inscription.dart';

class Annee extends AbstractEntity {
  final String libelle;
  final DateTime dateDebut;
  final String heureDebut;
  final List<Inscription>? inscriptionList;

  Annee({
    required super.id,
    required this.libelle,
    required this.dateDebut,
    required this.heureDebut,
    this.inscriptionList,
  });
  factory Annee.fromJson(Map<String, dynamic> json) {
  return Annee(
    id: json['id'],
    libelle: json['libelle'],
    dateDebut: DateTime.parse(json['dateDebut']),
    heureDebut: json['heureDebut'],
    inscriptionList: json['inscriptionList'] != null
        ? List<Inscription>.from(
            json['inscriptionList'].map((e) => Inscription.fromJson(e)))
        : null,
  );
}

}
