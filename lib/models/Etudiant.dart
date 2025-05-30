import 'Classe.dart';
import 'EtudiantCours.dart';
import 'Inscription.dart';
import 'User.dart';

class Etudiant extends User {
  final String dateNaissance;
  final String niveau;
  final String filiere;
  final String matricule;
  final Classe? classe;
  final List<Inscription>? inscriptionList;
  final List<EtudiantCours>? etudiantCoursList;

  Etudiant({
    required super.id,
    required super.login,
    required super.password,
    required super.nom,
    required super.prenom,
    required super.telephone,
    required super.role,
    required this.dateNaissance,
    required this.niveau,
    required this.filiere,
    required this.matricule,
    this.classe,
    this.inscriptionList,
    this.etudiantCoursList,
  });
  factory Etudiant.fromJson(Map<String, dynamic> json) {
  return Etudiant(
    id: json['id'],
    login: json['login'],
    password: json['password'],
    nom: json['nom'],
    prenom: json['prenom'],
    telephone: json['telephone'],
    role: json['role'],
    dateNaissance: json['dateNaissance'],
    niveau: json['niveau'],
    filiere: json['filiere'],
    matricule: json['matricule'],
    classe: json['classe'] != null ? Classe.fromJson(json['classe']) : null,
    inscriptionList: json['inscriptionList'] != null
        ? List<Inscription>.from(
            json['inscriptionList'].map((e) => Inscription.fromJson(e)))
        : null,
    etudiantCoursList: json['etudiantCoursList'] != null
        ? List<EtudiantCours>.from(
            json['etudiantCoursList'].map((e) => EtudiantCours.fromJson(e)))
        : null,
  );
}

}