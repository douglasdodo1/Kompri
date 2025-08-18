class UsuariosState {
  final String email;
  final String senha;
  final String confirmarSenha;

  const UsuariosState({
    required this.email,
    required this.senha,
    required this.confirmarSenha,
  });

  factory UsuariosState.initial() {
    return const UsuariosState(email: '', senha: '', confirmarSenha: '');
  }

  UsuariosState copyWith({
    String? email,
    String? senha,
    String? confirmarSenha,
  }) {
    return UsuariosState(
      email: email ?? this.email,
      senha: senha ?? this.senha,
      confirmarSenha: confirmarSenha ?? this.confirmarSenha,
    );
  }
}
