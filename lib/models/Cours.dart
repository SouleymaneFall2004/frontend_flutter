import 'AbstractEntity.dart';
import 'Classe.dart';
import 'EtudiantCours.dart';
import 'Session.dart';

class Cours extends AbstractEntity {
  final String libelle;
  final String professeur;
  final Classe? classe;
  final List<Session>? sessions;
  final List<EtudiantCours>? etudiantCoursList;

  Cours({
    required super.id,
    required this.libelle,
    required this.professeur,
    this.classe,
    this.sessions,
    this.etudiantCoursList,
  });
  factory Cours.fromJson(Map<String, dynamic> json) {
  return Cours(
    id: json['id'],
    libelle: json['libelle'],
    professeur: json['professeur'],
    classe: json['classe'] != null ? Classe.fromJson(json['classe']) : null,
    sessions: json['sessions'] != null
        ? List<Session>.from(json['sessions'].map((e) => Session.fromJson(e)))
        : null,
    etudiantCoursList: json['etudiantCoursList'] != null
        ? List<EtudiantCours>.from(
            json['etudiantCoursList'].map((e) => EtudiantCours.fromJson(e)))
        : null,
  );
}

}
