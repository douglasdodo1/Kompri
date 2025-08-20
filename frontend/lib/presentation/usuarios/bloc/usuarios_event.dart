abstract class UsuariosEvent {}

class CriarUsuario extends UsuariosEvent {
  CriarUsuario();
}

class AtualizarCpf extends UsuariosEvent {
  final String cpf;
  AtualizarCpf({required this.cpf});
}

class AtualizarNome extends UsuariosEvent {
  final String nome;
  AtualizarNome({required this.nome});
}

class AtualizarEmail extends UsuariosEvent {
  final String email;
  AtualizarEmail({required this.email});
}

class AtualizarSenha extends UsuariosEvent {
  final String senha;
  AtualizarSenha({required this.senha});
}

class AtualizarConfirmarSenha extends UsuariosEvent {
  final String confirmarSenha;
  AtualizarConfirmarSenha({required this.confirmarSenha});
}

class Logar extends UsuariosEvent {
  final String email;
  final String senha;
  Logar({required this.email, required this.senha});
}
