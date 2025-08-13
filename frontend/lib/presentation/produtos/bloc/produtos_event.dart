import 'package:frontend/domain/produtos/entities/produto_entity.dart';

abstract class ProdutosEvent {}

class CriarProduto extends ProdutosEvent {
  final ProdutoEntity produto;
  CriarProduto(this.produto);
}

class BuscarProdutos extends ProdutosEvent {
  BuscarProdutos();
}

class DeletarProduto extends ProdutosEvent {
  final int id;
  DeletarProduto(this.id);
}
