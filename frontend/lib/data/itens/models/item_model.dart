import 'package:frontend/data/produtos/models/produto_model.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';

class ItemModel {
  final String id;
  final int compraId;
  final ProdutoModel produto;
  final int quantidade;
  final double valor;
  final bool comprado;

  ItemModel({
    required this.id,
    required this.compraId,
    required this.produto,
    required this.quantidade,
    required this.valor,
    required this.comprado,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'compraId': compraId,
    'produto': produto.toJson(),
    'quantidade': quantidade,
    'valor': valor,
    'comprado': comprado,
  };

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      compraId: json['compraId'],
      produto: ProdutoModel.fromJson(json['produto']),
      quantidade: json['quantidade'],
      valor: (json['valor'] as num).toDouble(),
      comprado: json['comprado'],
    );
  }

  ItemEntity toEntity() {
    return ItemEntity(
      id: id,
      compraId: compraId,
      produto: produto.toEntity(),
      quantidade: quantidade,
      valor: valor,
      comprado: comprado,
    );
  }
}
