import 'package:frontend/data/usuarios/models/usuario_model.dart';

class UsuarioEntity {
  final String email;
  final String senha;

  UsuarioEntity({required this.email, required this.senha});

  UsuarioModel toModel() => UsuarioModel(email: email, senha: senha);

  UsuarioEntity copyWith({String? cpf, String? email, String? senha}) {
    return UsuarioEntity(
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }
}
