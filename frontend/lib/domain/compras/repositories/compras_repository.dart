import 'dart:convert';

import 'package:frontend/data/compras/dtos/compras_dto.dart';
import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/services/shared_preferences_service.dart';

class ComprasRepository {
  Future<void> buscarComprasRecentes() async {}
  Future<void> buscarCompras() async {
    final prefs = await SharedPreferencesService.getInstance();
    final value = prefs.getData('valorEstimado') ?? 0;
    return null;
  }

  Future<void> criarCompra(ComprasEntity compra) async {
    final prefs = await SharedPreferencesService.getInstance();
    ComprasModel comprasModel = compra.toModel();
    ComprasDTO comprasDTO = comprasModel.toDto();
    final jsonString = jsonEncode(comprasDTO.toJson());
    await prefs.saveData('compra', jsonString);
  }

  Future<ComprasEntity> buscarCompraRecente() async {
    final prefs = await SharedPreferencesService.getInstance();
    final jsonString = prefs.getData('compra');
    if (jsonString == null) {
      return ComprasEntity(
        id: -1,
        status: '',
        valorTotal: 0,
        valorEstimado: 0,
        qtdItens: 0,
        usuarioCpf: '',
        instituicao: InstituicaoEntity(id: -1, nome: ''),
      );
    }

    final jsonMap = jsonDecode(jsonString);
    final ComprasDTO comprasDTO = ComprasDTO.fromJson(jsonMap);
    final ComprasModel comprasModel = ComprasModel.fromJDto(comprasDTO);
    final ComprasEntity compra = comprasModel.toEntity();
    return compra;
  }

  Future<void> atualizarValorEstimado(String novoValorEstimado) async {
    final prefs = await SharedPreferencesService.getInstance();

    dynamic jsonString = prefs.getData('compra');
    if (jsonString == null) {
      return;
    }

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    jsonMap['valorEstimado'] = novoValorEstimado;

    final ComprasDTO compraAtualizadaDTO = ComprasDTO.fromJson(jsonMap);

    final updatedJsonString = jsonEncode(compraAtualizadaDTO.toJson());
    await prefs.saveData('compra', updatedJsonString);
  }
}
