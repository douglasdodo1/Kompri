import 'package:equatable/equatable.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading }

class AuthUser {
  final String? cpf;
  final String? senha;

  AuthUser({this.cpf, this.senha});

  AuthUser copyWith({String? cpf, String? senha}) {
    return AuthUser(cpf: cpf ?? this.cpf, senha: senha ?? this.senha);
  }

  Map<String, dynamic> toJson() => {'cpf': cpf, 'senha': senha};

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      AuthUser(cpf: json['cpf'], senha: json['senha']);
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthUser? user;

  const AuthState({required this.status, this.user});

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({AuthStatus? status, AuthUser? user}) {
    return AuthState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, user];
}
