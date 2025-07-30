import 'package:frontend/domain/compras/entities/compras_entity.dart';

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
  final ComprasEntity compra;
  AtualizarCompra(this.compra);
}

class BuscarCompraRecente extends ComprasEvent {
  BuscarCompraRecente();
}
