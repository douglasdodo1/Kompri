abstract class AuthRepository {
  Future<void> logar(String cpf, String senha);
  Future<void> logout();
}
