import 'package:dartz/dartz.dart';
import 'package:frontend/data/usuarios/value_objects/confirmar_senha.dart';
import 'package:frontend/data/usuarios/value_objects/cpf.dart';
import 'package:frontend/data/usuarios/value_objects/email.dart';
import 'package:frontend/data/usuarios/value_objects/nome.dart';
import 'package:frontend/data/usuarios/value_objects/senha.dart';
import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';
import 'package:frontend/domain/usuarios/repositorys/usuarios_repository.dart';

class UsuariosUseCase {
  final UsuariosRepository repository;
  UsuariosUseCase(this.repository);

  Future<void> criarUsuario(UsuarioEntity usuario) =>
      repository.criarUsuario(usuario);

  Either<String, Cpf> atualizarCpf(String cpf) {
    return Cpf.create(cpf);
  }

  Either<String, Nome> atualizarNome(String nome) {
    return Nome.create(nome);
  }

  Either<String, Email> atualizarEmail(String email) {
    return Email.create(email);
  }

  Either<String, Senha> atualizarSenha(String senha) {
    return Senha.create(senha);
  }

  Either<String, ConfirmarSenha> atualizarConfirmarSenha(
    String confirmarSenha,
    String senha,
  ) {
    return ConfirmarSenha.create(confirmarSenha, senha);
  }
}
