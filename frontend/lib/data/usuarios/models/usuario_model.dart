import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';

class UsuarioModel {
  final String nome;
  final String email;
  final String password;

  const UsuarioModel({
    required this.nome,
    required this.email,
    required this.password,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      nome: json['nome'],
      email: json['email'],
      password: json['password'],
    );
  }

  UsuarioEntity toEntity() => UsuarioEntity(
    nome: nome,
    email: email,
    senha: password,
    confirmarSenha: '',
  );

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'email': email,
    'password': password,
  };

  UsuarioModel copyWith({String? nome, String? email, String? password}) {
    return UsuarioModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
