import 'package:frontend/domain/produtos/entities/produto_entity.dart';

abstract class ProdutosEvent {}

class CriarProduto extends ProdutosEvent {
  final ProdutoEntity produto;
  CriarProduto(this.produto);
}

class BuscarProdutos extends ProdutosEvent {
  BuscarProdutos();
}

class AtualizarProduto extends ProdutosEvent {
  final String id;
  final String? novaMarca;
  final String? novaCategoria;
  AtualizarProduto({required this.id, this.novaMarca, this.novaCategoria});
}

class DeletarProduto extends ProdutosEvent {
  final int id;
  DeletarProduto(this.id);
}
