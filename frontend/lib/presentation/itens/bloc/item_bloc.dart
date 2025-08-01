import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/itens/usecases/item_usecase.dart';
import 'package:frontend/presentation/itens/bloc/item_event.dart';
import 'package:frontend/presentation/itens/bloc/item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemUsecase usecase;

  ItemBloc(this.usecase) : super(ItemState.inicial()) {
    on<CriarItem>(_criarItem);
    on<BuscarItens>(_buscarItens);
    on<AtualizarItens>(_atualizarItens);
    on<DeletarItem>(_deletarItem);
  }

  Future<void> _criarItem(CriarItem event, Emitter<ItemState> emit) async {
    await usecase.criarItem(event.item);

    emit(state.copyWith(sucesso: true));
  }

  Future<void> _buscarItens(BuscarItens event, Emitter<ItemState> emit) async {
    final itens = await usecase.buscarItens(3);
    emit(state.copyWith(itens: itens));
  }

  Future<void> _atualizarItens(
    AtualizarItens event,
    Emitter<ItemState> emit,
  ) async {
    final itemAtualizado = usecase.atualizarItem(event.item);

    emit(state.copyWith(sucesso: true));
  }

  Future<void> _deletarItem(DeletarItem event, Emitter<ItemState> emit) async {
    await usecase.deletarItem(event.itemId);
    emit(state.copyWith(sucesso: true));
  }
}
