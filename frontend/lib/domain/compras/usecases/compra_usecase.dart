import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';

class CompraUsecase {
  final ComprasRepository repository;
  CompraUsecase(this.repository);

  Future<void> criarCompra(ComprasEntity compra) async =>
      repository.criarCompra(compra);

  Future<ComprasEntity> buscarCompraRecente() async =>
      repository.buscarCompraRecente();

  Future<ComprasEntity> atualizarCompra(
    String? status,
    String? valorTotal,
    String? valorEstimado,
    int? qtdItens,
    ItemEntity? item,
    InstituicaoEntity? instituicao,
  ) async => repository.atualizarCompra(
    status,
    valorTotal,
    valorEstimado,
    qtdItens,
    item,
    instituicao,
  );

  Future<void> buscarCompras() async => repository.buscarCompras();
}
