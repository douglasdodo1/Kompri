import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/itens/repositories/item_repository.dart';

class ItemUsecase {
  final ItemRepository itemRepository;

  ItemUsecase(this.itemRepository);

  Future<void> criarItem(ItemEntity item) => itemRepository.criarItem(item);

  Future<List<ItemEntity>> buscarItens(int id) =>
      itemRepository.buscarItens(id);

  Future<ItemEntity> buscarItem(int id) => itemRepository.buscarItem(id);

  Future<void> atualizarItem(ItemEntity item) =>
      itemRepository.atualizarItem(item);

  Future<void> deletarItem(int id) => itemRepository.deletarItem(id);
}
