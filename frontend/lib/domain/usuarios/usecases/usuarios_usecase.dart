import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';
import 'package:frontend/domain/usuarios/repositorys/usuarios_repository.dart';

class UsuariosUseCase {
  final UsuariosRepository repository;
  UsuariosUseCase(this.repository);

  Future<void> criarUsuario(UsuarioEntity usuario, String confirmarSenha) =>
      repository.criarUsuario(usuario, confirmarSenha);

  Future<void> logar(String email, String senha) =>
      repository.logar(email, senha);
}
