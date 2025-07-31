import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';

class CompraUsecase {
  final ComprasRepository repository;
  CompraUsecase(this.repository);

  Future<void> criarCompra(ComprasEntity compra) async =>
      repository.criarCompra(compra);

  Future<ComprasEntity> buscarCompraRecente() async =>
      repository.buscarCompraRecente();

  Future<ComprasEntity> atualizarCompra(ComprasEntity compra) async =>
      repository.atualizarCompra(compra);

  Future<void> buscarCompras() async => repository.buscarCompras();
}
