import 'dart:convert';
import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/data/produtos/models/produto_model.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/domain/produtos/repositories/produto_repository.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'package:uuid/uuid.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  @override
  Future<ProdutoEntity?> criarProduto(ProdutoEntity produto) async {
    final prefs = await SharedPreferencesService.getInstance();
    final produtosString = prefs.getData('produtos');

    List<ProdutoModel> listaProdutosModel = [];
    if (produtosString != null) {
      final List decodedList = jsonDecode(produtosString);
      listaProdutosModel = decodedList
          .map((p) => ProdutoModel.fromJson(p))
          .toList();
    }

    final List<ProdutoEntity> listaProdutosEntity = listaProdutosModel
        .map((p) => p.toEntity())
        .toList();

    final existe = listaProdutosEntity.any((p) => p.id == produto.id);

    if (existe) {
      return null;
    }

    listaProdutosEntity.add(produto);

    final List<ProdutoModel> listaFinal = listaProdutosEntity
        .map((p) => p.toModel())
        .toList();

    await prefs.saveData('produtos', jsonEncode(listaFinal));
    return produto;
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

    final produto = listaProdutosEntity.firstWhere(
      (p) => p.id == id,
      orElse: () => ProdutoEntity(id: '', nome: '', marca: '', categoria: ''),
    );

    int index = listaProdutosEntity.indexWhere((p) => p.id == produto.id);

    if (index != -1) {
      listaProdutosEntity[index] = produto;
      await prefs.saveData(
        'produtos',
        jsonEncode(
          listaProdutosEntity.map((p) => p.toModel().toJson()).toList(),
        ),
      );
    }

    return listaProdutosEntity;
  }

  @override
  Future<void> adicionarEmCompra(ProdutoEntity produto) async {
    final prefs = await SharedPreferencesService.getInstance();

    final String compraString = prefs.getData('compra') ?? '[]';
    final ComprasEntity compra = ComprasModel.fromJson(
      jsonDecode(compraString),
    ).toEntity();

    final ItemEntity novoItem = ItemEntity(
      id: Uuid().v4(),
      compraId: compra.id,
      produto: produto,
      quantidade: 1,
      valor: 0.0,
      comprado: false,
    );

    compra.itens.add(novoItem);

    await prefs.saveData(
      'compra',
      jsonEncode(ComprasModel.fromEntity(compra).toJson()),
    );
  }

  @override
  Future<void> deletarProduto(String id) async {
    final prefs = await SharedPreferencesService.getInstance();
    String produtosString = prefs.getData('produtos') ?? '[]';

    final List<ProdutoEntity> listaProdutosEntity =
        (jsonDecode(produtosString) as List)
            .map(
              (p) =>
                  ProdutoModel.fromJson(p as Map<String, dynamic>).toEntity(),
            )
            .toList();

    listaProdutosEntity.removeWhere((p) => p.id == id);

    await prefs.saveData(
      'produtos',
      jsonEncode(listaProdutosEntity.map((p) => p.toModel().toJson()).toList()),
    );
  }
}
