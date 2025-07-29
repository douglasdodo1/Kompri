import 'package:frontend/data/products/dtos/produto_dto.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';

class ProdutoModel {
  final int id;
  final String nome;
  final String? marca;
  final String? categoria;

  ProdutoModel(this.id, this.nome, this.marca, this.categoria);

  factory ProdutoModel.fromJDto(ProdutoDTO dto) {
    final String? marca = dto.marca == null
        ? 'Não informada'
        : dto.marca?.trim();
    final String? categoria = dto.categoria == null
        ? 'Não informada'
        : dto.categoria?.trim();

    return ProdutoModel(dto.id, dto.nome.trim(), marca, categoria);
  }

  ProdutoEntity toEntity() {
    return ProdutoEntity(
      id: id,
      nome: nome,
      marca: marca,
      categoria: categoria,
    );
  }
}
