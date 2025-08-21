import 'package:frontend/data/usuarios/models/usuario_model.dart';

class UsuarioEntity {
  final String nome;
  final String email;
  final String senha;
  final String confirmarSenha;

  const UsuarioEntity({
    required this.nome,
    required this.email,
    required this.senha,
    required this.confirmarSenha,
  });

  UsuarioModel toModel() =>
      UsuarioModel(nome: nome, email: email, password: senha);

  UsuarioEntity copyWith({
    String? cpf,
    String? nome,
    String? email,
    String? senha,
    String? confirmarSenha,
  }) {
    return UsuarioEntity(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      confirmarSenha: confirmarSenha ?? this.confirmarSenha,
    );
  }
}
