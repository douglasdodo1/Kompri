import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';

abstract class UsuariosRepository {
  Future<bool> criarUsuario(UsuarioEntity usuario);
}
