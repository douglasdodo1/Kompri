import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/domain/produtos/repositories/produto_repository.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  @override
  Future<void> criarProduto(ProdutoEntity produto) {
    // TODO: implement criarProduto
    throw UnimplementedError();
  }

  @override
  Future<List<ProdutoEntity>> getProdutos() {
    // TODO: implement getProdutos
    throw UnimplementedError();
  }

  @override
  Future<ProdutoEntity> getProduto(int id) {
    // TODO: implement getProduto
    throw UnimplementedError();
  }

  @override
  Future<void> atualizarProduto(ProdutoEntity produto) {
    // TODO: implement atualizarProduto
    throw UnimplementedError();
  }

  @override
  Future<void> deletarProduto(int id) {
    // TODO: implement deletarProduto
    throw UnimplementedError();
  }
}
