import 'package:frontend/domain/produtos/entities/produto_entity.dart';

class ProdutosState {
  final List<ProdutoEntity> listaProdutos;
  final bool? carregando;
  final bool? sucesso;
  final String? erro;

  ProdutosState({
    required this.listaProdutos,
    required this.carregando,
    required this.sucesso,
    required this.erro,
  });

  factory ProdutosState.initial() => ProdutosState(
    listaProdutos: [],
    carregando: true,
    sucesso: false,
    erro: null,
  );

  ProdutosState copyWith({
    List<ProdutoEntity>? listaProdutos,
    bool? carregando,
    bool? sucesso,
    String? erro,
  }) {
    return ProdutosState(
      listaProdutos: listaProdutos ?? this.listaProdutos,
      carregando: carregando ?? this.carregando,
      sucesso: sucesso ?? this.sucesso,
      erro: erro ?? this.erro,
    );
  }
}
