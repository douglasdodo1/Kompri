import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';

final List<ItemEntity> itensMock = [
  ItemEntity(
    id: 1,
    compraId: 101,
    produto: ProdutoEntity(
      id: 1,
      nome: 'Arroz',
      categoria: 'Alimentos',
      marca: 'Tio João',
    ),
    quantidade: 2,
    valor: 5.50,
    comprado: false,
  ),
  ItemEntity(
    id: 2,
    compraId: 101,
    produto: ProdutoEntity(
      id: 2,
      nome: 'Feijão',
      categoria: 'Alimentos',
      marca: 'Tio João',
    ),
    quantidade: 1,
    valor: 7.20,
    comprado: true,
  ),
  ItemEntity(
    id: 3,
    compraId: 101,
    produto: ProdutoEntity(
      id: 3,
      nome: 'Óleo de soja',
      categoria: 'Alimentos',
      marca: 'Tio João',
    ),
    quantidade: 1,
    valor: 8.90,
    comprado: false,
  ),
  ItemEntity(
    id: 4,
    compraId: 101,
    produto: ProdutoEntity(
      id: 4,
      nome: 'Macarrão',
      categoria: 'Alimentos',
      marca: 'Tio João',
    ),
    quantidade: 3,
    valor: 4.30,
    comprado: true,
  ),
];
