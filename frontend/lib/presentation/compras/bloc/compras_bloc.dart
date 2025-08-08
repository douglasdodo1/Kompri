import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/compras/usecases/compra_usecase.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';

class ComprasBloc extends Bloc<ComprasEvent, ComprasState> {
  final CompraUsecase usecase;

  ComprasBloc(this.usecase) : super(ComprasState.inicial()) {
    on<CriarCompra>(_criarCompra);
    on<BuscarComprasRecentes>(_buscarRecentes);
    on<BuscarCompraRecente>(_buscarCompraRecente);
    on<AtualizarCompra>(_atualizarCompra);

    on<CarregarCompra>((event, emit) async {
      emit(state.copyWith(carregando: true));
      try {
        final compra = await usecase.buscarCompraRecente();
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
    //final recentes = await usecase.buscarComprasRecentes();
  }

  Future<void> _criarCompra(
    CriarCompra event,
    Emitter<ComprasState> emit,
  ) async {
    await usecase.criarCompra(event.compra);

    emit(state.copyWith(compra: event.compra, sucesso: true));
  }

  Future<void> _atualizarCompra(
    AtualizarCompra event,
    Emitter<ComprasState> emit,
  ) async {
    final compraAtual = state.compra;
    if (compraAtual == null) return;

    print("ANALISANDO O BLOC");
    print(event.item);
    print(event.valorEstimado);

    final compraSalva = await usecase.atualizarCompra(
      event.status,
      event.valorTotal,
      event.valorEstimado,
      event.qtdItens,
      event.item,
      event.instituicao,
    );

    emit(state.copyWith(compra: compraSalva, sucesso: true));
  }

  Future<void> _buscarCompraRecente(
    BuscarCompraRecente event,
    Emitter<ComprasState> emit,
  ) async {
    final compra = await usecase.buscarCompraRecente();

    emit(state.copyWith(compra: compra));
  }
}
