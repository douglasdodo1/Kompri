import 'package:frontend/domain/produtos/entities/produto_entity.dart';

class ProdutosState {
  final List<ProdutoEntity> listaProdutos;
  final String? pesquisa;
  final bool? carregando;
  final bool? sucesso;
  final String? erro;

  ProdutosState({
    this.pesquisa,
    required this.listaProdutos,
    required this.carregando,
    required this.sucesso,
    required this.erro,
  });

  factory ProdutosState.initial() => ProdutosState(
    pesquisa: "",
    listaProdutos: [],
    carregando: true,
    sucesso: false,
    erro: null,
  );

  ProdutosState copyWith({
    String? pesquisa,
    List<ProdutoEntity>? listaProdutos,
    bool? carregando,
    bool? sucesso,
    String? erro,
  }) {
    return ProdutosState(
      pesquisa: pesquisa ?? this.pesquisa,
      listaProdutos: listaProdutos ?? this.listaProdutos,
      carregando: carregando ?? this.carregando,
      sucesso: sucesso ?? this.sucesso,
      erro: erro ?? this.erro,
    );
  }
}
