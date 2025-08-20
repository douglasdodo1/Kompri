import 'package:dartz/dartz.dart';

class Cpf {
  final String value;

  Cpf(this.value);

  static Either<String, Cpf> create(String cpf) {
    if (cpf.isEmpty) {
      return left('CPF vazio');
    }
    if (cpf.contains(' ')) {
      return left('CPF contém espaço');
    }
    if (cpf.contains('-')) {
      return left('CPF contém hífen');
    }
    if (cpf.contains('.')) {
      return left('CPF contém ponto');
    }
    if (cpf.length != 11) {
      return left('CPF inválido');
    }

    return right(Cpf(cpf));
  }
}
