import 'package:frontend/domain/produtos/entities/produto_entity.dart';

abstract class ProdutoRepository {
  Future<ProdutoEntity?> criarProduto(ProdutoEntity produto);
  Future<ProdutoEntity> getProduto(int id);
  Future<List<ProdutoEntity>> getProdutos();
  Future<List<ProdutoEntity>> atualizarProduto(
    String id,
    String? novaMarca,
    String? novaCategoria,
  );

  Future<void> adicionarEmCompra(ProdutoEntity produto);
  Future<void> deletarProduto(String id);
}
