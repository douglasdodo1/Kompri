import 'package:frontend/data/itens/models/item_model.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';

class ItemEntity {
  final String id;
  final int compraId;
  final ProdutoEntity produto;
  final int quantidade;
  final double valor;
  final bool comprado;

  ItemEntity({
    required this.id,
    required this.compraId,
    required this.produto,
    required this.quantidade,
    required this.valor,
    required this.comprado,
  });

  ItemModel toModel() {
    return ItemModel(
      id: id,
      compraId: compraId,
      produto: produto.toModel(),
      quantidade: quantidade,
      valor: valor,
      comprado: comprado,
    );
  }

  ItemEntity copyWith({
    String? id,
    int? compraId,
    ProdutoEntity? produto,
    int? quantidade,
    double? valor,
    bool? comprado,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      compraId: compraId ?? this.compraId,
      produto: produto ?? this.produto,
      quantidade: quantidade ?? this.quantidade,
      valor: valor ?? this.valor,
      comprado: comprado ?? this.comprado,
    );
  }

  @override
  String toString() {
    return 'ItemEntity{id: $id, compraId: $compraId, produto: $produto, quantidade: $quantidade, valor: $valor, comprado: $comprado}';
  }
}
