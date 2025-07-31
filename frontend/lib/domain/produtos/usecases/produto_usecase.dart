import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/domain/produtos/repositories/produto_repository.dart';

class ProdutoUsecase {
  final ProdutoRepository repository;
  ProdutoUsecase(this.repository);

  Future<void> criarProduto(ProdutoEntity produto) =>
      repository.criarProduto(produto);
  Future<List<ProdutoEntity>> buscarProdutos() async =>
      repository.getProdutos();

  Future<ProdutoEntity> buscarProduto(int id) async =>
      repository.getProduto(id);

  Future<void> atualizarProduto(ProdutoEntity produto) =>
      repository.atualizarProduto(produto);

  Future<void> deletarProduto(int id) => repository.deletarProduto(id);
}
