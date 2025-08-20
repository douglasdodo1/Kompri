import 'package:dartz/dartz.dart';

class Nome {
  final String value;
  const Nome._(this.value);

  static Either<String, Nome> create(String nome) {
    if (nome.length < 3) {
      return left('O nome é muito curto (mínimo: 3 caracteres)');
    }

    if (nome.length > 50) {
      return left('O nome é muito longo (máximo: 50 caracteres)');
    }

    if (RegExp(r'[0-9]').hasMatch(nome)) {
      return left('O nome contém números!');
    }

    return right(Nome._(nome));
  }
}
