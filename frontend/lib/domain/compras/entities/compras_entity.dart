import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';

class ComprasEntity {
  final int? id;
  final String status;
  final String valorTotal;
  final String valorEstimado;
  final int qtdItens;
  final String usuarioCpf;
  final InstituicaoEntity instituicao;

  ComprasEntity({
    required this.id,
    required this.status,
    required this.valorTotal,
    required this.valorEstimado,
    required this.qtdItens,
    required this.usuarioCpf,
    required this.instituicao,
  });

  ComprasModel toModel() {
    return ComprasModel(
      id ?? -1,
      status,
      double.tryParse(valorTotal) ?? 0.00,
      double.tryParse(valorEstimado) ?? 0.00,
      qtdItens,
      usuarioCpf,
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
    InstituicaoEntity? instituicao,
  }) {
    return ComprasEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      valorTotal: valorTotal ?? this.valorTotal,
      valorEstimado: valorEstimado ?? this.valorEstimado,
      qtdItens: qtdItens ?? this.qtdItens,
      usuarioCpf: usuarioCpf ?? this.usuarioCpf,
      instituicao: instituicao ?? this.instituicao,
    );
  }

  @override
  String toString() {
    return 'CompraEntity(id: $id, status: $status, valorTotal: $valorTotal, valorEstimado: $valorEstimado, qtdItens: $qtdItens, usuarioCpf: $usuarioCpf, instituicao: $instituicao)';
  }
}
