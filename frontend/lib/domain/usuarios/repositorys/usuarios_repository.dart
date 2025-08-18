import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';

abstract class UsuariosRepository {
  Future<void> criarUsuario(UsuarioEntity usuario, String confirmarSenha);
  Future<void> logar(String email, String senha);
}
