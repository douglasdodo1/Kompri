import 'dart:convert';
import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/itens/repositories/item_repository.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'package:uuid/uuid.dart';

class ItemRepositoryImpl implements ItemRepository {
  final _uuid = Uuid();

  @override
  Future<ItemEntity> criarItem(ItemEntity item) async {
    final prefs = await SharedPreferencesService.getInstance();
    final ComprasModel compraAtualModel = ComprasModel.fromJson(
      jsonDecode(prefs.getData('compra')),
    );

    final ComprasEntity compraAtual = compraAtualModel.toEntity();

    ItemEntity itemComId = item.id == -1 ? item.copyWith(id: _uuid.v4()) : item;

    itemComId = itemComId.copyWith(compraId: compraAtual.id);

    final novaCompra = compraAtual.copyWith(
      qtdItens: compraAtual.qtdItens + 1,
      itens: [...compraAtual.itens, itemComId],
      valorTotal: (double.parse(compraAtual.valorTotal) + itemComId.valor)
          .toString(),
    );

    await prefs.saveData('compra', jsonEncode(novaCompra.toModel().toJson()));
    return itemComId;
  }

  @override
  Future<ItemEntity> buscarItem(int id) async {
    final prefs = await SharedPreferencesService.getInstance();
    final compraAtualModel = ComprasModel.fromJson(
      jsonDecode(prefs.getData('itens')),
    );

    final ComprasEntity compraAtual = compraAtualModel.toEntity();

    return compraAtual.itens.firstWhere((item) => item.id == id);
  }

  @override
  Future<List<ItemEntity>> buscarItens() async {
    final prefs = await SharedPreferencesService.getInstance();
    final ComprasModel compraAtualModel = ComprasModel.fromJson(
      jsonDecode(prefs.getData('compra')),
    );

    final ComprasEntity compraAtual = compraAtualModel.toEntity();
    return compraAtual.itens;
  }

  @override
  Future<ItemEntity> atualizarItem(
    ItemEntity item,
    String? marca,
    String? categoria,
    double? valor,
    int? quantidade,
    bool? comprado,
  ) async {
    final itemAtualizado = item.copyWith(
      valor: valor ?? item.valor,
      quantidade: quantidade ?? item.quantidade,
      comprado: comprado ?? item.comprado,
      produto: item.produto.copyWith(
        marca: marca ?? item.produto.marca,
        categoria: categoria ?? item.produto.categoria,
      ),
    );

    print('Item atualizado: $itemAtualizado');

    return itemAtualizado;
  }

  @override
  Future<void> deletarItem(int id) async {
    final prefs = await SharedPreferencesService.getInstance();
    final compraAtual = await prefs.getData('compra') as ComprasEntity;

    final itensAtualizados = compraAtual.itens
        .where((i) => i.id != id)
        .toList();

    final novaCompra = compraAtual.copyWith(
      itens: itensAtualizados,
      qtdItens: compraAtual.qtdItens - 1,
    );

    await prefs.saveData('compra', novaCompra.toModel().toJson());
  }
}
