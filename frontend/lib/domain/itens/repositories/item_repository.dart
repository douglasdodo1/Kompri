import 'package:frontend/domain/itens/entities/item_entity.dart';

abstract class ItemRepository {
  Future<void> criarItem(ItemEntity item);
  Future<List<ItemEntity>> buscarItens(int id);
  Future<ItemEntity> buscarItem(int id);
  Future<void> atualizarItem(ItemEntity item);
  Future<void> deletarItem(int id);
}
