import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';

abstract class UsuariosRepository {
  Future<void> criarUsuario(UsuarioEntity usuario);
}
