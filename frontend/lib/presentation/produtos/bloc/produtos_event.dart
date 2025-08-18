import 'package:frontend/domain/produtos/entities/produto_entity.dart';

abstract class ProdutosEvent {}

class PesquisarProdutoString extends ProdutosEvent {
  final String pesquisa;
  PesquisarProdutoString(this.pesquisa);
}

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

class AdicinarEmCompra extends ProdutosEvent {
  final ProdutoEntity produto;
  AdicinarEmCompra(this.produto);
}

class DeletarProduto extends ProdutosEvent {
  final String id;
  DeletarProduto(this.id);
}
