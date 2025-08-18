import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String cpf;
  final String senha;

  AuthLoginRequested(this.cpf, this.senha);

  @override
  List<Object?> get props => [cpf, senha];
}

class AuthLogoutRequested extends AuthEvent {}
