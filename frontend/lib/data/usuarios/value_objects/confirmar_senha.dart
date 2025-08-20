import 'package:dartz/dartz.dart';

class ConfirmarSenha {
  final String value;
  final String valueSenha;
  ConfirmarSenha._(this.value, this.valueSenha);

  static Either<String, ConfirmarSenha> create(
    String confirmarSenha,
    String senha,
  ) {
    if (confirmarSenha != senha) {
      return left('Senhas diferentes');
    }

    return right(ConfirmarSenha._(confirmarSenha, senha));
  }
}
