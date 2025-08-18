import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:intl/intl.dart';

class CompraUsecase {
  final ComprasRepository repository;
  CompraUsecase(this.repository);

  Future<ComprasEntity> criarCompra(ComprasEntity compra) async =>
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
    String? deletarItemId,
  ) async => repository.atualizarCompra(
    status,
    valorTotal,
    valorEstimado,
    qtdItens,
    item,
    instituicao,
    deletarItemId,
  );

  Future<List<ComprasEntity>> buscarCompras() async {
    final List<ComprasEntity> listaCompras = await repository.buscarCompras();
    if (listaCompras.isEmpty) return [];

    listaCompras.sort((a, b) {
      final dateA = DateFormat('MM/yyyy').parse(a.data);
      final dateB = DateFormat('MM/yyyy').parse(b.data);
      return dateB.compareTo(dateA);
    });
    return listaCompras;
  }

  Future<List<ComprasEntity>> salvarCompra(ComprasEntity compra) async =>
      repository.salvarCompra(compra);
}
