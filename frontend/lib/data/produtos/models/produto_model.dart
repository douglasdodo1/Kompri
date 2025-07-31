import 'package:frontend/domain/produtos/entities/produto_entity.dart';

class ProdutoModel {
  final int id;
  final String nome;
  final String? marca;
  final String? categoria;

  ProdutoModel(this.id, this.nome, this.marca, this.categoria);

  Map toJson() => <String, dynamic>{
    'id': id,
    'nome': nome,
    'marca': marca,
    'categoria': categoria,
  };

  ProdutoEntity toEntity() {
    return ProdutoEntity(
      id: id,
      nome: nome,
      marca: marca,
      categoria: categoria,
    );
  }
}
