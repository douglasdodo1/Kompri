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
  Future<void> buscarCompras() async {}

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
    InstituicaoEntity? instituicao,
    String? marca,
  ) async {
    final prefs = await SharedPreferencesService.getInstance();
    final compraJsonString = prefs.getData('compra');

    if (compraJsonString == null) {
      throw Exception('Nenhuma compra salva encontrada.');
    }

    final Map<String, dynamic> compraJson = jsonDecode(compraJsonString);

    final compraSalva = ComprasModel.fromJson(compraJson).toEntity();

    final compraAtualizada = compraSalva.copyWith(
      status: status,
      valorTotal: valorTotal,
      valorEstimado: valorEstimado,
      qtdItens: qtdItens,
      instituicao: instituicao,
      // marca não faz parte da compra, provavelmente deve atualizar o Item ou Produto,
      // então precisa lógica específica se quiser alterar isso aqui
    );

    // Salvar a compra atualizada
    final compraModel = compraAtualizada.toModel();
    await prefs.saveData('compra', jsonEncode(compraModel.toJson()));

    return compraAtualizada;
  }
}
