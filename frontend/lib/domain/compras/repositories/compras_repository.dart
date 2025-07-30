import 'package:frontend/domain/compras/entities/compras_entity.dart';

abstract class ComprasRepository {
  Future<void> buscarComprasRecentes();
  Future<void> buscarCompras();
  Future<void> criarCompra(ComprasEntity compra);
  Future<ComprasEntity> buscarCompraRecente();
  Future<ComprasEntity> atualizarCompra(ComprasEntity compra);
}
