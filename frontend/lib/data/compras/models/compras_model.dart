import 'package:frontend/data/instituicoes/models/instituicao_model.dart';
import 'package:frontend/data/itens/models/item_model.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';

class ComprasModel {
  final int id;
  final String status;
  final double valorTotal;
  final double valorEstimado;
  final int qtdItens;
  final String usuarioCpf;
  final List<ItemModel> itens;
  final InstituicaoModel instituicao;

  ComprasModel(
    this.id,
    this.status,
    this.valorTotal,
    this.valorEstimado,
    this.qtdItens,
    this.usuarioCpf,
    this.itens,
    this.instituicao,
  );

  factory ComprasModel.fromJson(Map<String, dynamic> json) {
    return ComprasModel(
      json['id'],
      json['status'],
      json['valorTotal'],
      json['valorEstimado'],
      json['qtdItens'],
      json['usuarioCpf'],
      (json['itens'] as List).map((e) => ItemModel.fromJson(e)).toList(),
      InstituicaoModel.fromJson(json['instituicao']),
    );
  }

  ComprasEntity toEntity() {
    return ComprasEntity(
      id: id,
      status: status,
      valorTotal: valorTotal.toStringAsFixed(2),
      valorEstimado: valorEstimado.toStringAsFixed(2),
      qtdItens: qtdItens,
      usuarioCpf: usuarioCpf,
      itens: itens.map((e) => e.toEntity()).toList(),
      instituicao: instituicao.toEntity(),
    );
  }

  Map toJson() => <String, dynamic>{
    'id': id,
    'status': status,
    'valorTotal': valorTotal,
    'valorEstimado': valorEstimado,
    'qtdItens': qtdItens,
    'usuarioCpf': usuarioCpf,
    'itens': itens.map((e) => e.toJson()).toList(),
    'instituicao': instituicao.toJson(),
  };

  @override
  String toString() {
    return 'ComprasModel(id: $id, status: $status, valorTotal: $valorTotal, valorEstimado: $valorEstimado, qtdItens: $qtdItens, usuarioCpf: $usuarioCpf, itens: $itens, instituicao: $instituicao)';
  }
}
