enum Status { inicial, carregando, sucesso, erro }

class UsuariosState {
  final String nome;
  final String errorNome;
  final String email;
  final String errorEmail;
  final String senha;
  final String errorSenha;
  final String confirmarSenha;
  final String errorConfirmarSenha;
  final Status state;

  const UsuariosState({
    required this.nome,
    required this.errorNome,
    required this.email,
    required this.errorEmail,
    required this.senha,
    required this.errorSenha,
    required this.confirmarSenha,
    required this.errorConfirmarSenha,
    required this.state,
  });

  factory UsuariosState.initial() {
    return const UsuariosState(
      nome: '',
      errorNome: '',
      email: '',
      errorEmail: '',
      senha: '',
      errorSenha: '',
      confirmarSenha: '',
      errorConfirmarSenha: '',
      state: Status.inicial,
    );
  }

  UsuariosState copyWith({
    String? nome,
    String? errorNome,
    String? email,
    String? errorEmail,
    String? senha,
    String? errorSenha,
    String? confirmarSenha,
    String? errorConfirmarSenha,
    Status? state,
  }) {
    return UsuariosState(
      nome: nome ?? this.nome,
      errorNome: errorNome ?? this.errorNome,
      email: email ?? this.email,
      errorEmail: errorEmail ?? this.errorEmail,
      senha: senha ?? this.senha,
      errorSenha: errorSenha ?? this.errorSenha,
      confirmarSenha: confirmarSenha ?? this.confirmarSenha,
      errorConfirmarSenha: errorConfirmarSenha ?? this.errorConfirmarSenha,
      state: state ?? this.state,
    );
  }
}
