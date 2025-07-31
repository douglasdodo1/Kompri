import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/produtos/repositories/produto_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  @override
  Future<void> criarItem(ItemEntity item) {
    // TODO: implement criarItem
    throw UnimplementedError();
  }

  @override
  Future<List<ItemEntity>> getItens() {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  @override
  Future<ItemEntity> getItem(int id) {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  Future<void> atualizarItem(ItemEntity item) {
    // TODO: implement atualizarItem
    throw UnimplementedError();
  }

  @override
  Future<void> deletarItem(int id) {
    // TODO: implement deletarItem
    throw UnimplementedError();
  }
}
