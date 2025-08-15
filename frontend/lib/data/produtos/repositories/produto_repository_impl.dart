import 'dart:convert';
import 'package:frontend/data/produtos/models/produto_model.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/domain/produtos/repositories/produto_repository.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'package:uuid/uuid.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  final uuid = Uuid();

  @override
  Future<ProdutoEntity> criarProduto(ProdutoEntity produto) async {
    final prefs = await SharedPreferencesService.getInstance();
    print("produto para atualizar(NO PRODUTO_IMPL): ${produto}");
    final produtosString = prefs.getData('produtos');

    List<ProdutoModel> listaProdutosModel = [];
    if (produtosString != null) {
      final List decodedList = jsonDecode(produtosString);
      listaProdutosModel = decodedList
          .map((p) => ProdutoModel.fromJson(p))
          .toList();
    }

    final existe = listaProdutosModel.any(
      (p) =>
          p.nome == produto.nome &&
          p.marca == produto.marca &&
          p.categoria == produto.categoria,
    );

    if (!existe) {
      final novoProduto = produto.copyWith(id: uuid.v4());
      listaProdutosModel.add(novoProduto.toModel());

      await prefs.saveData(
        'produtos',
        jsonEncode(listaProdutosModel.map((p) => p.toJson()).toList()),
      );

      return novoProduto;
    } else {
      return produto;
    }
  }

  @override
  Future<List<ProdutoEntity>> getProdutos() async {
    final prefs = await SharedPreferencesService.getInstance();
    final produtosString = prefs.getData('produtos');

    List<ProdutoModel> listaProdutosModel = [];
    if (produtosString != null) {
      final List decodedList = jsonDecode(produtosString);
      listaProdutosModel = decodedList
          .map((p) => ProdutoModel.fromJson(p))
          .toList();
    }

    return listaProdutosModel.map((p) => p.toEntity()).toList();
  }

  @override
  Future<ProdutoEntity> getProduto(int id) {
    // TODO: implement getProduto
    throw UnimplementedError();
  }

  @override
  Future<List<ProdutoEntity>> atualizarProduto(
    String id,
    String? novaMarca,
    String? novaCategoria,
  ) async {
    final prefs = await SharedPreferencesService.getInstance();
    final produtosString = prefs.getData('produtos');
    List<ProdutoEntity> listaProdutosEntity = [];

    if (produtosString != null) {
      final List decodedList = jsonDecode(produtosString);
      listaProdutosEntity = decodedList
          .map((p) => ProdutoModel.fromJson(p).toEntity())
          .toList();
    }

    print('listaProdutosEntity: $listaProdutosEntity');

    print("id: $id, novaMarca: $novaMarca, novaCategoria: $novaCategoria");

    final produto = listaProdutosEntity
        .firstWhere((p) => p.id == id)
        .copyWith(marca: novaMarca, categoria: novaCategoria);

    int index = listaProdutosEntity.indexWhere((p) => p.id == produto.id);
    listaProdutosEntity[index] = produto;

    await prefs.saveData(
      'produtos',
      jsonEncode(listaProdutosEntity.map((p) => p.toModel().toJson()).toList()),
    );

    return listaProdutosEntity;
  }

  @override
  Future<void> deletarProduto(int id) {
    // TODO: implement deletarProduto
    throw UnimplementedError();
  }
}
