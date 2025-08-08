import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/itens/repositories/item_repository.dart';

class ItemUsecase {
  final ItemRepository itemRepository;

  ItemUsecase(this.itemRepository);

  Future<ItemEntity> criarItem(ItemEntity item) =>
      itemRepository.criarItem(item);

  Future<List<ItemEntity>> buscarItens() => itemRepository.buscarItens();

  Future<ItemEntity> buscarItem(int id) => itemRepository.buscarItem(id);

  Future<ItemEntity> atualizarItem(
    ItemEntity item,
    String? marca,
    String? categoria,
    double? valor,
    int? quantidade,
    bool? comprado,
  ) => itemRepository.atualizarItem(
    item,
    marca,
    categoria,
    valor,
    quantidade,
    comprado,
  );

  Future<void> deletarItem(int id) => itemRepository.deletarItem(id);
}
