class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String password) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: password,
      photoUrl: json['photoUrl'],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
