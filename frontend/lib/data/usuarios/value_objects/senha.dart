import 'package:dartz/dartz.dart';

class Senha {
  final String value;
  Senha._(this.value);

  static Either<String, Senha> create(String value) {
    if (value.length < 6) {
      return left('Senha é muito curta (mínimo: 6 caracteres)');
    }

    return right(Senha._(value));
  }
}
