import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';

class ComprasBloc extends Bloc<ComprasEvent, ComprasState> {
  final ComprasRepository repository;

  ComprasBloc(this.repository) : super(ComprasState.inicial()) {
    on<CriarCompra>(_criarCompra);
    on<BuscarComprasRecentes>(_buscarRecentes);
    on<BuscarCompraRecente>(_buscarCompraRecente);
    on<AtualizarCompra>(_atualizarCompra);

    on<CarregarCompra>((event, emit) async {
      emit(state.copyWith(carregando: true));
      try {
        final compra = await repository.buscarCompraRecente();
        emit(state.copyWith(compra: compra, carregando: false));
      } catch (_) {
        emit(state.copyWith(carregando: false));
      }
    });
  }

  Future<void> _buscarRecentes(
    BuscarComprasRecentes event,
    Emitter<ComprasState> emit,
  ) async {
    //final recentes = await repository.buscarComprasRecentes();
  }

  Future<void> _criarCompra(
    CriarCompra event,
    Emitter<ComprasState> emit,
  ) async {
    await repository.criarCompra(event.compra);

    emit(state.copyWith(compra: event.compra, sucesso: true));
  }


  Future<void> _atualizarCompra(
    AtualizarCompra event,
    Emitter<ComprasState> emit,
  ) async {
    ComprasEntity compra = await repository.atualizarCompra(event.compra);
    emit(state.copyWith(compra: compra, sucesso: true));
  }

  Future<void> _buscarCompraRecente(
    BuscarCompraRecente event,
    Emitter<ComprasState> emit,
  ) async {
    final compra = await repository.buscarCompraRecente();

    emit(state.copyWith(compra: compra));
  }
}
