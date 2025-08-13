import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/domain/produtos/usecases/produto_usecase.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_event.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_state.dart';

class ProdutosBloc extends Bloc<ProdutosEvent, ProdutosState> {
  final ProdutoUsecase produtoUsecase;

  ProdutosBloc(this.produtoUsecase) : super(ProdutosState.initial()) {
    on<CriarProduto>(_criarProduto);
    on<BuscarProdutos>(_buscarProdutos);
    on<AtualizarProduto>(_atualizarProduto);
    on<DeletarProduto>(_deletarProduto);
  }

  Future<void> _criarProduto(
    CriarProduto event,
    Emitter<ProdutosState> emit,
  ) async {
    final ProdutoEntity produtoCriado = await produtoUsecase.criarProduto(
      event.produto,
    );

    final List<ProdutoEntity> listaProdutos = await produtoUsecase
        .buscarProdutos();

    final List<ProdutoEntity> listaProdutosAtualizada = [
      ...listaProdutos,
      produtoCriado,
    ];

    emit(state.copyWith(listaProdutos: listaProdutosAtualizada, sucesso: true));
  }

  Future<void> _buscarProdutos(
    BuscarProdutos event,
    Emitter<ProdutosState> emit,
  ) async {
    final produtos = await produtoUsecase.buscarProdutos();
    emit(state.copyWith(listaProdutos: produtos, sucesso: true));
  }

  Future<void> _atualizarProduto(
    AtualizarProduto event,
    Emitter<ProdutosState> emit,
  ) async {
    final List<ProdutoEntity> listaAtualizada = await produtoUsecase
        .atualizarProduto(event.id, event.novaMarca, event.novaCategoria);
    emit(state.copyWith(listaProdutos: listaAtualizada, sucesso: true));
  }

  Future<void> _deletarProduto(
    DeletarProduto event,
    Emitter<ProdutosState> emit,
  ) async {
    await produtoUsecase.deletarProduto(event.id);
    final produtos = await produtoUsecase.buscarProdutos();
    emit(state.copyWith(listaProdutos: produtos, sucesso: true));
  }
}
