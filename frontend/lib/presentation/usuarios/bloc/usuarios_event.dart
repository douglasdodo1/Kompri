import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';

abstract class UsuariosEvent {}

class CriarUsuario extends UsuariosEvent {
  final UsuarioEntity usuario;
  final String confirmarSenha;

  CriarUsuario({required this.usuario, required this.confirmarSenha});
}

class Logar extends UsuariosEvent {
  final String email;
  final String senha;
  Logar({required this.email, required this.senha});
}
