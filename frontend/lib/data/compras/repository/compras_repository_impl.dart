import 'dart:convert';
import 'package:frontend/core/mock/compras_mock.dart';
import 'package:frontend/core/utils/virgula_para_ponto.dart';
import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'package:uuid/uuid.dart';

class ComprasRepositoryImpl implements ComprasRepository {
  final uuid = Uuid();

  @override
  Future<ComprasEntity> criarCompra(ComprasEntity compra) async {
    final prefs = await SharedPreferencesService.getInstance();
    final ComprasEntity compraConvertida = compra.copyWith(
      valorEstimado: virgulaParaPonto(compra.valorEstimado),
    );

    ComprasModel comprasModel = compraConvertida.toModel();
    final jsonString = jsonEncode(comprasModel.toJson());
    await prefs.saveData('compra', jsonString);
    final ComprasEntity compraCriada = comprasModel.toEntity();
    return compraCriada;
  }

  @override
  Future<ComprasEntity> buscarCompraRecente() async {
    final prefs = await SharedPreferencesService.getInstance();
    final jsonString = prefs.getData('compra');
    if (jsonString == null) {
      return ComprasEntity(
        id: -1,
        data: '',
        status: '',
        valorTotal: '0.00',
        valorEstimado: '0.00',
        qtdItens: 0,
        usuarioCpf: '',
        itens: [],
        instituicao: InstituicaoEntity(id: -1, nome: ''),
      );
    }

    final jsonMap = jsonDecode(jsonString);
    final ComprasModel comprasModel = ComprasModel.fromJson(jsonMap);
    final ComprasEntity compra = comprasModel.toEntity();
    return compra;
  }

  @override
  Future<List<ComprasEntity>> buscarCompras() async {
    final prefs = await SharedPreferencesService.getInstance();
    final String compraString = prefs.getData('compras') ?? '[]';
    final List<ComprasEntity> listaCompras = (jsonDecode(compraString) as List)
        .map((compra) => ComprasModel.fromJson(compra).toEntity())
        .toList();
    print("LISTA COMPRAS: $listaCompras");
    return listaCompras;
  }

  @override
  Future<void> buscarComprasRecentes() {
    throw UnimplementedError();
  }

  @override
  Future<ComprasEntity> atualizarCompra(
    String? status,
    String? valorTotal,
    String? valorEstimado,
    int? qtdItens,
    ItemEntity? item,
    InstituicaoEntity? instituicao,
    String? deletarItemId,
  ) async {
    final prefs = await SharedPreferencesService.getInstance();
    final compraJsonString = prefs.getData('compra');

    if (compraJsonString == null) {
      throw Exception('Nenhuma compra salva encontrada.');
    }

    final Map<String, dynamic> compraJson = jsonDecode(compraJsonString);

    final compraSalva = ComprasModel.fromJson(compraJson).toEntity();

    valorEstimado = valorEstimado == null
        ? compraSalva.valorEstimado
        : virgulaParaPonto(valorEstimado);

    final List<ItemEntity> listaItensAtual = [...compraSalva.itens];
    final List<ItemEntity> listaItensAtualizada = [...listaItensAtual];

    if (deletarItemId != null) {
      listaItensAtualizada.removeWhere((i) => i.id == deletarItemId);
    }
    int qtdItensAtualizada = listaItensAtualizada.length;

    if (item != null) {
      int index = listaItensAtualizada.indexWhere((i) => i.id == item?.id);
      if (index != -1) {
        listaItensAtualizada[index] = item;
      } else {
        item = item.copyWith(
          compraId: compraSalva.id,
          id: item.id,
          produto: item.produto.copyWith(id: item.produto.id),
        );

        listaItensAtualizada.add(item);
        qtdItensAtualizada++;
      }
    }

    final valorTotalCalculado = listaItensAtualizada.fold<double>(
      0,
      (total, item) => total + (item.valor * item.quantidade),
    );

    print('VALOR TOTAL CALCULADO: $valorTotalCalculado');

    final compraAtualizada = compraSalva.copyWith(
      status: status,
      valorTotal: valorTotalCalculado.toString(),
      valorEstimado: valorEstimado,
      qtdItens: qtdItensAtualizada,
      itens: listaItensAtualizada,
      instituicao: instituicao,
    );

    final compraModel = compraAtualizada.toModel();

    await prefs.saveData('compra', jsonEncode(compraModel.toJson()));
    return compraAtualizada;
  }

  Future<void> criarItemEmCompra(ItemEntity item) async {}

  @override
  Future<List<ComprasEntity>> salvarCompra(ComprasEntity compra) async {
    print("COMPRA PARA SER SALVA: ${compra.toModel().toJson()}");

    final prefs = await SharedPreferencesService.getInstance();
    final String compraString = prefs.getData('compras') ?? '[]';

    final List<dynamic> lista = (jsonDecode(compraString) as List<dynamic>);
    final List<ComprasModel> comprasModel = lista
        .map((c) => ComprasModel.fromJson(c))
        .toList();

    final ComprasEntity ultimaCompra;
    final ComprasEntity compraComId;
    if (comprasModel.isNotEmpty) {
      ultimaCompra = comprasModel.last.toEntity();
      compraComId = compra.copyWith(id: (ultimaCompra.id + 1));
      comprasModel.add(compraComId.toModel());
    } else {
      compraComId = compra.copyWith(id: 1);
      comprasModel.add(compraComId.toModel());
    }

    final listaAtualizada = comprasModel.map((c) => c.toJson()).toList();
    await prefs.saveData('compras', jsonEncode(listaAtualizada));

    return [];
  }
}
