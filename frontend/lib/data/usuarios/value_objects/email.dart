import 'package:dartz/dartz.dart';

class Email {
  final String value;
  const Email._(this.value);

  static Either<String, Email> create(String value) {
    if (!value.contains('@')) {
      return left("Email deve conter '@'");
    }

    if (!value.contains('.com')) {
      return left("Email deve conter '.com'");
    }

    return right(Email._(value));
  }
}
