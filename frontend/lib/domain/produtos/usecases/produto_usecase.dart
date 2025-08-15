import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/domain/produtos/repositories/produto_repository.dart';

class ProdutoUsecase {
  final ProdutoRepository repository;
  ProdutoUsecase(this.repository);

  Future<ProdutoEntity> criarProduto(ProdutoEntity produto) {
    final ProdutoEntity produtoTratado = produto.copyWith(
      marca: produto.marca ?? "marca não informada",
      categoria: produto.categoria ?? "categoria não informada",
    );

    return repository.criarProduto(produtoTratado);
  }

  Future<List<ProdutoEntity>> buscarProdutos() async =>
      repository.getProdutos();

  Future<ProdutoEntity> buscarProduto(int id) async =>
      repository.getProduto(id);

  Future<List<ProdutoEntity>> atualizarProduto(
    String id,
    String? novaMarca,
    String? novaCategoria,
  ) => repository.atualizarProduto(id, novaMarca, novaCategoria);

  Future<void> deletarProduto(int id) => repository.deletarProduto(id);
}
