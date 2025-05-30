class User {
  final String id;
  final String login;
  final String password;
  final String nom;
  final String prenom;
  final String telephone;
  final String role;

  User({
    required this.id,
    required this.login,
    required this.password,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        login: json['login'],
        password: json['password'],
        nom: json['nom'],
        prenom: json['prenom'],
        telephone: json['telephone'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'login': login,
        'password': password,
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'role': role,
      };
}
