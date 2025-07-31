import 'package:frontend/domain/itens/entities/item_entity.dart';

abstract class ItemEvent {
  const ItemEvent();
}

class CriarItem extends ItemEvent {
  final ItemEntity item;
  const CriarItem({required this.item});
}

class BuscarItens extends ItemEvent {
  const BuscarItens();
}

class AtualizarItens extends ItemEvent {
  final ItemEntity item;
  const AtualizarItens({required this.item});
}

class DeletarItem extends ItemEvent {
  final int itemId;
  const DeletarItem({required this.itemId});
}
