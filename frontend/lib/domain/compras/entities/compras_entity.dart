import 'package:frontend/data/compras/models/compras_model.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';

class ComprasEntity {
  final int id;
  final String status;
  final double valorTotal;
  final double valorEstimado;
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
      id,
      status,
      valorTotal,
      valorEstimado,
      qtdItens,
      usuarioCpf,
      instituicao.toModel(),
    );
  }

  @override
  String toString() {
    return 'CompraEntity(id: $id, status: $status, valorTotal: $valorTotal, valorEstimado: $valorEstimado, qtdItens: $qtdItens, usuarioCpf: $usuarioCpf, instituicao: $instituicao)';
  }
}
