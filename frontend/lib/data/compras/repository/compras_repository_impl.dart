import 'dart:convert';
import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/services/shared_preferences_service.dart';

class ComprasRepositoryImpl implements ComprasRepository {
  @override
  Future<void> criarCompra(ComprasEntity compra) async {
    final prefs = await SharedPreferencesService.getInstance();
    ComprasModel comprasModel = compra.toModel();
    final jsonString = jsonEncode(comprasModel.toJson());
    await prefs.saveData('compra', jsonString);
  }

  @override
  Future<ComprasEntity> buscarCompraRecente() async {
    final prefs = await SharedPreferencesService.getInstance();
    final jsonString = prefs.getData('compra');
    if (jsonString == null) {
      return ComprasEntity(
        id: -1,
        status: '',
        valorTotal: '0.00',
        valorEstimado: '0.00',
        qtdItens: 0,
        usuarioCpf: '',
        instituicao: InstituicaoEntity(id: -1, nome: ''),
      );
    }

    final jsonMap = jsonDecode(jsonString);
    final ComprasModel comprasModel = ComprasModel.fromJson(jsonMap);
    final ComprasEntity compra = comprasModel.toEntity();
    return compra;
  }

  @override
  Future<void> buscarCompras() async {}

  @override
  Future<void> buscarComprasRecentes() {
    throw UnimplementedError();
  }

  @override
  Future<ComprasEntity> atualizarCompra(ComprasEntity compra) async {
    final prefs = await SharedPreferencesService.getInstance();

    ComprasModel compraCache = ComprasModel.fromJson(
      jsonDecode(prefs.getData('compra') ?? '{}'),
    );

    final ComprasEntity compraAtualizada = compraCache.toEntity().copyWith(
      status: compra.status,
      valorTotal: compra.valorTotal,
      valorEstimado: compra.valorEstimado,
      qtdItens: compra.qtdItens,
      instituicao: compra.instituicao,
    );

    final ComprasModel compraAtualizadaModel = compraAtualizada.toModel();
    prefs.saveData('compra', jsonEncode(compraAtualizadaModel.toJson()));
    return compraAtualizada;
  }
}
