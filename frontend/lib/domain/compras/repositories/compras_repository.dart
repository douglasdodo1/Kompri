import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';

abstract class ComprasRepository {
  Future<void> buscarComprasRecentes();
  Future<List<ComprasEntity>> buscarCompras();
  Future<void> criarCompra(ComprasEntity compra);
  Future<ComprasEntity> buscarCompraRecente();
  Future<ComprasEntity> atualizarCompra(
    String? status,
    String? valorTotal,
    String? valorEstimado,
    int? qtdItens,
    ItemEntity? item,
    InstituicaoEntity? instituicao,
    String? deletarItemId,
  );
}
