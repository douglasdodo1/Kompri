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

class AtualizarCompra extends ComprasEvent {
  final String? status;
  final String? valorTotal;
  final String? valorEstimado;
  final int? qtdItens;
  final ItemEntity? item;
  final String? deletarItemId;

  final InstituicaoEntity? instituicao;

  AtualizarCompra({
    this.status,
    this.valorTotal,
    this.valorEstimado,
    this.qtdItens,
    this.item,
    this.instituicao,
    this.deletarItemId,
  });
}

class BuscarCompraRecente extends ComprasEvent {
  BuscarCompraRecente();
}

class BuscarCompras extends ComprasEvent {
  BuscarCompras();
}

class SalvarCompra extends ComprasEvent {
  SalvarCompra();
}
