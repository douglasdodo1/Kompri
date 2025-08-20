import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';
import 'package:frontend/domain/usuarios/repositorys/usuarios_repository.dart';

class UsuariosRepositoryImpl extends UsuariosRepository {
  @override
  Future<void> criarUsuario(UsuarioEntity usuario, String confirmarSenha) {
    throw UnimplementedError();
  }

  @override
  Future<String> logar(String email, String senha) {
    throw UnimplementedError();
  }
}
