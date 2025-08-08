import 'package:frontend/domain/itens/entities/item_entity.dart';

abstract class ItemRepository {
  Future<ItemEntity> criarItem(ItemEntity item);
  Future<List<ItemEntity>> buscarItens();
  Future<ItemEntity> buscarItem(int id);
  Future<ItemEntity> atualizarItem(
    ItemEntity item,
    String? marca,
    String? categoria,
    double? valor,
    int? quantidade,
    bool? comprado,
  );
  Future<void> deletarItem(int id);
}
