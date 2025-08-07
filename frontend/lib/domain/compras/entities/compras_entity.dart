import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';

class ComprasEntity {
  final int? id;
  final String status;
  final String valorTotal;
  final String valorEstimado;
  final int qtdItens;
  final String usuarioCpf;
  final List<ItemEntity> itens;
  final InstituicaoEntity instituicao;

  ComprasEntity({
    required this.id,
    required this.status,
    required this.valorTotal,
    required this.valorEstimado,
    required this.qtdItens,
    required this.usuarioCpf,
    List<ItemEntity>? itens,
    required this.instituicao,
  }) : itens = itens ?? [];

  ComprasModel toModel() {
    return ComprasModel(
      id ?? -1,
      status,
      double.tryParse(valorTotal) ?? 0.00,
      double.tryParse(valorEstimado) ?? 0.00,
      qtdItens,
      usuarioCpf,
      itens.map((e) => e.toModel()).toList(),
      instituicao.toModel(),
    );
  }

  ComprasEntity copyWith({
    int? id,
    String? status,
    String? valorTotal,
    String? valorEstimado,
    int? qtdItens,
    String? usuarioCpf,
    List<ItemEntity>? itens,
    InstituicaoEntity? instituicao,
  }) {
    return ComprasEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      valorTotal: valorTotal ?? this.valorTotal,
      valorEstimado: valorEstimado ?? this.valorEstimado,
      qtdItens: qtdItens ?? this.qtdItens,
      usuarioCpf: usuarioCpf ?? this.usuarioCpf,
      itens: itens ?? this.itens,
      instituicao: instituicao ?? this.instituicao,
    );
  }

  @override
  String toString() {
    return 'ComprasEntity(id: $id, status: $status, valorTotal: $valorTotal, valorEstimado: $valorEstimado, qtdItens: $qtdItens, usuarioCpf: $usuarioCpf, itens: ${itens.toString()}, instituicao: $instituicao)';
  }
}
