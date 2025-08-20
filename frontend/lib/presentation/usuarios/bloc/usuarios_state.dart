class UsuariosState {
  final String cpf;
  final String errorCpf;
  final String nome;
  final String errorNome;
  final String email;
  final String errorEmail;
  final String senha;
  final String errorSenha;
  final String confirmarSenha;
  final String errorConfirmarSenha;

  const UsuariosState({
    required this.cpf,
    required this.errorCpf,
    required this.nome,
    required this.errorNome,
    required this.email,
    required this.errorEmail,
    required this.senha,
    required this.errorSenha,
    required this.confirmarSenha,
    required this.errorConfirmarSenha,
  });

  factory UsuariosState.initial() {
    return const UsuariosState(
      cpf: '',
      errorCpf: '',
      nome: '',
      errorNome: '',
      email: '',
      errorEmail: '',
      senha: '',
      errorSenha: '',
      confirmarSenha: '',
      errorConfirmarSenha: '',
    );
  }

  UsuariosState copyWith({
    String? cpf,
    String? errorCpf,
    String? nome,
    String? errorNome,
    String? email,
    String? errorEmail,
    String? senha,
    String? errorSenha,
    String? confirmarSenha,
    String? errorConfirmarSenha,
  }) {
    return UsuariosState(
      cpf: cpf ?? this.cpf,
      errorCpf: errorCpf ?? this.errorCpf,
      nome: nome ?? this.nome,
      errorNome: errorNome ?? this.errorNome,
      email: email ?? this.email,
      errorEmail: errorEmail ?? this.errorEmail,
      senha: senha ?? this.senha,
      errorSenha: errorSenha ?? this.errorSenha,
      confirmarSenha: confirmarSenha ?? this.confirmarSenha,
      errorConfirmarSenha: errorConfirmarSenha ?? this.errorConfirmarSenha,
    );
  }
}
