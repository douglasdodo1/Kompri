import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/usuarios/usecases/usuarios_usecase.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_event.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_state.dart';

class UsuariosBloc extends Bloc<UsuariosEvent, UsuariosState> {
  final UsuariosUseCase _usuariosUseCase;

  UsuariosBloc(this._usuariosUseCase) : super(UsuariosState.initial()) {
    on<CriarUsuario>(_criarUsuario);
    on<Logar>(_logar);
  }

  Future<void> _criarUsuario(
    CriarUsuario event,
    Emitter<UsuariosState> emit,
  ) async {
    await _usuariosUseCase.criarUsuario(event.usuario, event.confirmarSenha);
  }

  Future<void> _logar(Logar event, Emitter<UsuariosState> emit) async {
    await _usuariosUseCase.logar(event.email, event.senha);
  }
}
