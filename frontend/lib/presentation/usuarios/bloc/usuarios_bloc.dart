import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';
import 'package:frontend/domain/usuarios/usecases/usuarios_usecase.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_event.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_state.dart';

class UsuariosBloc extends Bloc<UsuariosEvent, UsuariosState> {
  final UsuariosUseCase _usuariosUseCase;

  UsuariosBloc(this._usuariosUseCase) : super(UsuariosState.initial()) {
    on<CriarUsuario>(_criarUsuario);
    on<AtualizarNome>(_atualizarNome);
    on<AtualizarEmail>(_atualizarEmail);
    on<AtualizarSenha>(_atualizarSenha);
    on<AtualizarConfirmarSenha>(_atualizarConfirmarSenha);
  }

  Future<void> _criarUsuario(
    CriarUsuario event,
    Emitter<UsuariosState> emit,
  ) async {
    if (state.state != Status.carregando) {
      emit(state.copyWith(state: Status.carregando));
      await Future.delayed(const Duration(seconds: 2));

      final UsuarioEntity usuario = UsuarioEntity(
        nome: state.nome,
        email: state.email,
        senha: state.senha,
        confirmarSenha: state.confirmarSenha,
      );
      final bool result = await _usuariosUseCase.criarUsuario(usuario);
      if (result) {
        emit(state.copyWith(state: Status.sucesso));
      } else {
        emit(state.copyWith(state: Status.erro));
      }
    }
  }

  Future<void> _atualizarNome(
    AtualizarNome event,
    Emitter<UsuariosState> emit,
  ) async {
    final resultado = _usuariosUseCase.atualizarNome(event.nome);

    resultado.fold(
      (erro) => emit(state.copyWith(nome: event.nome, errorNome: erro)),
      (nome) => emit(state.copyWith(nome: nome.value, errorNome: '')),
    );
  }

  Future<void> _atualizarEmail(
    AtualizarEmail event,
    Emitter<UsuariosState> emit,
  ) async {
    final resultado = _usuariosUseCase.atualizarEmail(event.email);

    resultado.fold(
      (erro) => emit(state.copyWith(email: event.email, errorEmail: erro)),
      (email) => emit(state.copyWith(email: email.value, errorEmail: '')),
    );
  }

  Future<void> _atualizarSenha(
    AtualizarSenha event,
    Emitter<UsuariosState> emit,
  ) async {
    final resultado = _usuariosUseCase.atualizarSenha(event.senha);

    resultado.fold(
      (erro) => emit(state.copyWith(senha: event.senha, errorSenha: erro)),
      (senha) => emit(state.copyWith(senha: senha.value, errorSenha: '')),
    );
  }

  Future<void> _atualizarConfirmarSenha(
    AtualizarConfirmarSenha event,
    Emitter<UsuariosState> emit,
  ) async {
    final resultado = _usuariosUseCase.atualizarConfirmarSenha(
      event.confirmarSenha,
      state.senha,
    );

    resultado.fold(
      (erro) => emit(
        state.copyWith(
          confirmarSenha: event.confirmarSenha,
          errorConfirmarSenha: erro,
        ),
      ),
      (confirmarSenha) => emit(
        state.copyWith(
          confirmarSenha: confirmarSenha.value,
          errorConfirmarSenha: '',
        ),
      ),
    );
  }
}
