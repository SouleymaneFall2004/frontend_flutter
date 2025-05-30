import 'dart:convert';
import 'package:frontend_flutter/models/Evenement.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  ApiService({this.baseUrl = "https://dev-back-end-sd0s.onrender.com/api/Evenements"});
  Future<List<Evenement>> getAllEvenements({int page = 0, int size = 5}) async {
    final url = Uri.parse("$baseUrl?page=$page&size=$size");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> content = jsonData['content'] ?? [];
      return content.map((e) => Evenement.fromJson(e)).toList();
    } else {
      throw Exception("Erreur : impossible de charger les Evenements.");
    }
  }

  Future<Evenement> getEvenementById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Evenement.fromJson(jsonData);
    } else {
      throw Exception("Erreur : impossible de charger l'Evenement $id.");
    }
  }
  Future<List<Evenement>> getEvenementsByEtat(String etat) async {
    final url = Uri.parse("$baseUrl/etat/$etat");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> content = jsonData['content'] ?? [];
      return content.map((e) => Evenement.fromJson(e)).toList();
    } else {
      throw Exception("Erreur : impossible de charger les Evenements par état.");
    }
  }
  Future<List<Evenement>> getEvenementsByType(String type) async {
    final url = Uri.parse("$baseUrl/type/$type");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> content = jsonData['content'] ?? [];
      return content.map((e) => Evenement.fromJson(e)).toList();
    } else {
      throw Exception("Erreur : impossible de charger les Evenements par type.");
    }
  }
  Future<List<Evenement>> getEvenementsByEtudiant(String etudiantId) async {
    final url = Uri.parse("$baseUrl/etudiant/$etudiantId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> content = jsonData['content'] ?? [];
      return content.map((e) => Evenement.fromJson(e)).toList();
    } else {
      throw Exception("Erreur : impossible de charger les Evenements de l'étudiant.");
    }
  }
  Future<List<Evenement>> getEvenementsByEtudiantAndEtat({
    required String etat,
    required String etudiantId,
    int page = 0,
    int size = 10,
  }) async {
    final url = Uri.parse("$baseUrl/etudiant/etat/$etat?etudiantId=$etudiantId&page=$page&size=$size");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> content = jsonData['content'] ?? [];
      return content.map((e) => Evenement.fromJson(e)).toList();
    } else {
      throw Exception("Erreur : impossible de filtrer les Evenements de l'étudiant.");
    }
  }
  Future<List<Evenement>> getEvenementsByEtudiantAndPeriod({
    required String etudiantId,
    required String dateDebut,
    required String dateFin,
    int page = 0,
    int taille = 10,
  }) async {
    final url = Uri.parse(
        "$baseUrl/filtre?etudiantId=$etudiantId&dateDebut=$dateDebut&dateFin=$dateFin&page=$page&taille=$taille");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> content = jsonData['content'] ?? [];
      return content.map((e) => Evenement.fromJson(e)).toList();
    } else {
      throw Exception("Erreur : impossible de filtrer les Evenements par période.");
    }
  }
}
