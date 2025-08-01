import 'package:frontend/core/mock/itens/itens_mock.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/itens/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  @override
  Future<void> criarItem(ItemEntity item) {
    // TODO: implement criarItem
    throw UnimplementedError();
  }

  @override
  Future<ItemEntity> buscarItem(int id) {
    // TODO: implement buscarItem
    throw UnimplementedError();
  }

  @override
  Future<List<ItemEntity>> buscarItens(int id) async {
    return itensMock;
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
