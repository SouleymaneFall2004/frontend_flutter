import 'AbstractEntity.dart';
import 'Session.dart';
import 'User.dart';
import 'etudiant.dart';

class Pointage extends AbstractEntity {
  final DateTime date;
  final String heure;
  final User? vigile;
  final Etudiant? etudiant;
  final Session? session;

  Pointage({
    required super.id,
    required this.date,
    required this.heure,
    this.vigile,
    this.etudiant,
    this.session,
  });
  factory Pointage.fromJson(Map<String, dynamic> json) {
  return Pointage(
    id: json['id'],
    date: DateTime.parse(json['date']),
    heure: json['heure'],
    vigile: json['vigile'] != null ? User.fromJson(json['vigile']) : null,
    etudiant: json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null,
    session: json['session'] != null ? Session.fromJson(json['session']) : null,
  );
}

}