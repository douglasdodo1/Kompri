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
  Future<void> criarItem(ItemEntity item) async {
    final prefs = await SharedPreferencesService.getInstance();
    final ComprasModel compraAtualModel = await ComprasModel.fromJson(
      jsonDecode(prefs.getData('compra')),
    );

    final ComprasEntity compraAtual = compraAtualModel.toEntity();

    ItemEntity itemComId = item.id == -1
        ? item.copyWith(id: _uuid.v4().hashCode)
        : item;

    itemComId = itemComId.copyWith(compraId: compraAtual.id);

    final novaCompra = compraAtual.copyWith(
      qtdItens: compraAtual.qtdItens + 1,
      itens: [...compraAtual.itens, itemComId],
    );

    await prefs.saveData('compra', jsonEncode(novaCompra.toModel().toJson()));
  }

  @override
  Future<ItemEntity> buscarItem(int id) async {
    final prefs = await SharedPreferencesService.getInstance();
    final ComprasModel compraAtualModel = ComprasModel.fromJson(
      jsonDecode(prefs.getData('compra')),
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
    print(compraAtual.itens);
    return compraAtual.itens;
  }

  @override
  Future<void> atualizarItem(ItemEntity item) async {
    final prefs = await SharedPreferencesService.getInstance();
    final compraAtual = await prefs.getData('compra') as ComprasEntity;

    final itensAtualizados = compraAtual.itens.map((i) {
      return i.id == item.id ? item : i;
    }).toList();

    final novaCompra = compraAtual.copyWith(itens: itensAtualizados);

    await prefs.saveData('compra', novaCompra.toModel().toJson());
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
