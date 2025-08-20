import 'package:frontend/data/usuarios/models/usuario_model.dart';

class UsuarioEntity {
  final String cpf;
  final String nome;
  final String email;
  final String senha;

  const UsuarioEntity({
    required this.cpf,
    required this.email,
    required this.senha,
    required this.nome,
  });

  UsuarioModel toModel() =>
      UsuarioModel(cpf: cpf, nome: nome, email: email, senha: senha);

  UsuarioEntity copyWith({
    String? cpf,
    String? nome,
    String? email,
    String? senha,
  }) {
    return UsuarioEntity(
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      nome: nome ?? this.nome,
    );
  }
}
