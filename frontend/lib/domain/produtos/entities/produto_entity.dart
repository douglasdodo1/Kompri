class ProdutoEntity {
  final int id;
  final String nome;
  final String? marca;
  final String? categoria;

  ProdutoEntity({
    required this.id,
    required this.nome,
    required this.marca,
    required this.categoria,
  });

  @override
  String toString() {
    return 'ProdutoEntity(id: $id, nome: $nome, marca: $marca, categoria: $categoria)';
  }
}
