import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';
import 'package:frontend/domain/usuarios/repositorys/usuarios_repository.dart';

class UsuariosRepositoryImpl extends UsuariosRepository {
  @override
  Future<void> criarUsuario(UsuarioEntity usuario) {
    print('criando usuario: $usuario');
    return Future.delayed(const Duration(seconds: 1));
  }
}
