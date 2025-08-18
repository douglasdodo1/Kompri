import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';

class UsuarioModel {
  final String email;
  final String senha;

  const UsuarioModel({required this.email, required this.senha});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(email: json['email'], senha: json['senha']);
  }

  UsuarioEntity toEntity() => UsuarioEntity(email: email, senha: senha);

  Map<String, dynamic> toJson() => {'email': email, 'senha': senha};

  UsuarioModel copyWith({String? email, String? senha}) {
    return UsuarioModel(email: email ?? this.email, senha: senha ?? this.senha);
  }
}
