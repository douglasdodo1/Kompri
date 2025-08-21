import 'package:frontend/data/usuarios/models/usuario_model.dart';

class UsuarioEntity {
  final String cpf;
  final String nome;
  final String email;
  final String senha;
  final String confirmarSenha;

  const UsuarioEntity({
    required this.cpf,
    required this.nome,
    required this.email,
    required this.senha,
    required this.confirmarSenha,
  });

  UsuarioModel toModel() =>
      UsuarioModel(cpf: cpf, nome: nome, email: email, senha: senha);

  UsuarioEntity copyWith({
    String? cpf,
    String? nome,
    String? email,
    String? senha,
    String? confirmarSenha,
  }) {
    return UsuarioEntity(
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      confirmarSenha: confirmarSenha ?? this.confirmarSenha,
    );
  }
}
