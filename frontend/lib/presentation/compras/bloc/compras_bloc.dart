import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/utils/calcular_economia_percentual.dart';
import 'package:frontend/core/utils/diferenca.dart';
import 'package:frontend/core/utils/proximo_elemento.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/compras/usecases/compra_usecase.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';

class ComprasBloc extends Bloc<ComprasEvent, ComprasState> {
  final CompraUsecase usecase;

  ComprasBloc(this.usecase) : super(ComprasState.inicial()) {
    on<CriarCompra>(_criarCompra);
    on<BuscarCompras>(_buscarCompras);
    on<BuscarCompraRecente>(_buscarCompraRecente);
    on<AtualizarCompra>(_atualizarCompra);
    on<SalvarCompra>(_salvarCompra);

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

  Future<void> _criarCompra(
    CriarCompra event,
    Emitter<ComprasState> emit,
  ) async {
    final ComprasEntity compra = await usecase.criarCompra(event.compra);

    emit(state.copyWith(compra: compra, sucesso: true));
  }

  Future<void> _buscarRecentes(
    BuscarComprasRecentes event,
    Emitter<ComprasState> emit,
  ) async {
    //final recentes = await usecase.buscarComprasRecentes();
  }

  Future<void> _buscarCompraRecente(
    BuscarCompraRecente event,
    Emitter<ComprasState> emit,
  ) async {
    final compra = await usecase.buscarCompraRecente();

    emit(state.copyWith(compra: compra));
  }

  Future<void> _buscarCompras(
    BuscarCompras event,
    Emitter<ComprasState> emit,
  ) async {
    final List<ComprasEntity> listaCompras = await usecase.buscarCompras();
    final Map<String, String> economiaPorMes = {};
    final Map<String, String> porcentagemPorMesLucro = {};

    for (var compra in listaCompras) {
      final ComprasEntity proximaCompra =
          listaCompras[proximoElemento(
            listaCompras.indexOf(compra),
            listaCompras.length,
          )];
      economiaPorMes.putIfAbsent(
        compra.id.toString(),
        () => calcularDiferenca(compra.valorTotal, proximaCompra.valorTotal),
      );

      print(
        "CALCULAR DIFERENCA: ${calcularDiferenca(compra.valorTotal, proximaCompra.valorTotal)}",
      );

      porcentagemPorMesLucro.putIfAbsent(
        compra.id.toString(),
        () => double.parse(
          calcularEconomiaPercentual(
            compra.valorTotal,
            proximaCompra.valorTotal,
          ),
        ).abs().toString(),
      );
    }

    print("ECONOMIA POR MES: $economiaPorMes");

    emit(
      state.copyWith(
        listaCompras: listaCompras,
        economiaPorMes: economiaPorMes,
        porcentagemPorMesLucro: porcentagemPorMesLucro,
      ),
    );

    emit(state.copyWith(sucesso: false));
  }

  Future<void> _atualizarCompra(
    AtualizarCompra event,
    Emitter<ComprasState> emit,
  ) async {
    final compraAtual = state.compraAtual;
    if (compraAtual == null) return;

    final compraSalva = await usecase.atualizarCompra(
      event.status,
      event.valorTotal,
      event.valorEstimado,
      event.qtdItens,
      event.item,
      event.instituicao,
      event.deletarItemId,
    );

    emit(state.copyWith(compra: compraSalva, sucesso: true));
  }

  Future<void> _salvarCompra(
    SalvarCompra event,
    Emitter<ComprasState> emit,
  ) async {
    if (state.compraAtual == null) {
      return;
    }
    final comprasSalvas = await usecase.salvarCompra(state.compraAtual);
    emit(state.copyWith(sucesso: true));
    emit(state.copyWith(sucesso: false));
  }
}
