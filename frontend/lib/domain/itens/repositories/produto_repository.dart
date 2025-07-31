import 'package:frontend/domain/produtos/entities/produto_entity.dart';

abstract class ProdutoRepository {
  Future<void> criarProduto(ProdutoEntity produto);
  Future<ProdutoEntity> getProduto(int id);
  Future<List<ProdutoEntity>> getProdutos();
  Future<void> atualizarProduto(ProdutoEntity produto);
  Future<void> deletarProduto(int id);
}
