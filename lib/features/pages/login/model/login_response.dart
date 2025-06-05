class LoginResponse {
  final String? token;
  final String? message;
  final User? user;
  final int? role;

  LoginResponse({this.token, this.message, this.user, this.role});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      role: json['role'],
    );
  }
}

class User {
  final int id;
  final String type;
  final String code;
  final String name;
  final String image;
  final String gend;
  final String user;
  final String phone;
  final String email;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.type,
    required this.code,
    required this.name,
    required this.image,
    required this.gend,
    required this.user,
    required this.phone,
    required this.email,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      type: json['type'],
      code: json['code'],
      name: json['name'],
      image: json['image'],
      gend: json['gend'],
      user: json['user'],
      phone: json['phone'],
      email: json['email'],
      status: json['status'],
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
    );
  }
}