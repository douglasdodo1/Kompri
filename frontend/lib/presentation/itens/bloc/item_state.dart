import 'package:frontend/domain/itens/entities/item_entity.dart';

class ItemState {
  final List<ItemEntity> itens;
  final bool carregando;
  final String? erro;
  final bool sucesso;

  ItemState({
    required this.itens,
    required this.carregando,
    required this.erro,
    required this.sucesso,
  });

  factory ItemState.inicial() =>
      ItemState(itens: [], carregando: false, erro: null, sucesso: false);

  ItemState copyWith({
    List<ItemEntity>? itens,
    bool? carregando,
    String? erro,
    bool? sucesso,
  }) {
    return ItemState(
      itens: itens ?? this.itens,
      carregando: carregando ?? this.carregando,
      erro: erro,
      sucesso: sucesso ?? this.sucesso,
    );
  }
}
