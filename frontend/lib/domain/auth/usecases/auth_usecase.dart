import 'package:frontend/domain/auth/repositorys/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repository;
  AuthUsecase(this.repository);

  Future<void> logar(String cpf, String senha) => repository.logar(cpf, senha);
}
