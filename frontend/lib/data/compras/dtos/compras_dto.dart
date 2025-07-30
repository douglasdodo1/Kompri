import 'package:frontend/data/instituicoes/dtos/instituicao_dto.dart';

class ComprasDTO {
  int id;
  String status;
  double valorTotal;
  double valorEstimado;
  int qtdItens;
  String usuarioCpf;
  InstituicaoDTO instituicao;

  ComprasDTO({
    required this.id,
    required this.status,
    required this.valorTotal,
    required this.valorEstimado,
    required this.qtdItens,
    required this.usuarioCpf,
    required this.instituicao,
  });

  factory ComprasDTO.fromJson(Map<String, dynamic> json) {
    return ComprasDTO(
      id: json['id'],
      status: json['status'],
      valorTotal: json['valorTotal'],
      valorEstimado: json['valorEstimado'],
      qtdItens: json['qtdItens'],
      usuarioCpf: json['usuarioCpf'],
      instituicao: InstituicaoDTO.fromJson(json['instituicao']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'status': status,
    'valorTotal': valorTotal,
    'valorEstimado': valorEstimado,
    'qtdItens': qtdItens,
    'usuarioCpf': usuarioCpf,
    'instituicao': instituicao.toJson(),
  };

  @override
  toString() {
    return 'ComprasDTO(id: $id, status: $status, valorTotal: $valorTotal, valorEstimado: $valorEstimado, qtdItens: $qtdItens, usuarioCpf: $usuarioCpf, instituicao: $instituicao)';
  }
}
