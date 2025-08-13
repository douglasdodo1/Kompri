import 'package:frontend/data/produtos/models/produto_model.dart';

class ProdutoEntity {
  final String id;
  final String nome;
  final String? marca;
  final String? categoria;

  ProdutoEntity({
    required this.id,
    required this.nome,
    required this.marca,
    required this.categoria,
  });

  ProdutoModel toModel() => ProdutoModel(id, nome, marca, categoria);

  ProdutoEntity copyWith({
    String? id,
    String? nome,
    String? marca,
    String? categoria,
  }) {
    return ProdutoEntity(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      marca: marca ?? this.marca,
      categoria: categoria ?? this.categoria,
    );
  }

  @override
  String toString() {
    return 'ProdutoEntity(id: $id, nome: $nome, marca: $marca, categoria: $categoria)';
  }
}
