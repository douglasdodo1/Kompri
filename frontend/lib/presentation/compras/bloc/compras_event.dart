import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';

abstract class ComprasEvent {}

class CarregarDashboardCompras extends ComprasEvent {}

class BuscarComprasRecentes extends ComprasEvent {}

class CriarCompra extends ComprasEvent {
  final ComprasEntity compra;
  CriarCompra(this.compra);
}

class CarregarCompra extends ComprasEvent {
  CarregarCompra();
}

class AtualizarValorEstimado extends ComprasEvent {
  final String valorEstimado;
  AtualizarValorEstimado(this.valorEstimado);
}

class AtualizarCompra extends ComprasEvent {
  final String? status;
  final String? valorTotal;
  final String? valorEstimado;
  final int? qtdItens;
  final ItemEntity? item;
  final InstituicaoEntity? instituicao;

  AtualizarCompra({
    this.status,
    this.valorTotal,
    this.valorEstimado,
    this.qtdItens,
    this.item,
    this.instituicao,
  });
}

class BuscarCompraRecente extends ComprasEvent {
  BuscarCompraRecente();
}
