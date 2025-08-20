import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';

class UsuarioModel {
  final String cpf;
  final String nome;
  final String email;
  final String senha;

  const UsuarioModel({
    required this.cpf,
    required this.nome,
    required this.email,
    required this.senha,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      cpf: json['cpf'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }

  UsuarioEntity toEntity() =>
      UsuarioEntity(cpf: cpf, nome: nome, email: email, senha: senha);

  Map<String, dynamic> toJson() => {
    'cpf': cpf,
    'nome': nome,
    'email': email,
    'senha': senha,
  };

  UsuarioModel copyWith({
    String? cpf,
    String? nome,
    String? email,
    String? senha,
  }) {
    return UsuarioModel(
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }
}
