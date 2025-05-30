import 'AbstractEntity.dart';
import 'Evenement.dart';
import 'cours.dart';
import 'pointage.dart';

class Session extends AbstractEntity {
  final DateTime date;
  final String heureDebut;
  final String heureFin;
  final Cours? cours;
  final List<Pointage>? pointages;
  final List<Evenement>? evenements;

  Session({
    required super.id,
    required this.date,
    required this.heureDebut,
    required this.heureFin,
    this.cours,
    this.pointages,
    this.evenements,
  });
  factory Session.fromJson(Map<String, dynamic> json) {
  return Session(
    id: json['id'],
    date: DateTime.parse(json['date']),
    heureDebut: json['heureDebut'],
    heureFin: json['heureFin'],
    cours: json['cours'] != null ? Cours.fromJson(json['cours']) : null,
    pointages: json['pointages'] != null
        ? List<Pointage>.from(json['pointages'].map((e) => Pointage.fromJson(e)))
        : null,
    evenements: json['evenements'] != null
        ? List<Evenement>.from(json['evenements'].map((e) => Evenement.fromJson(e)))
        : null,
  );
}

}
