import 'package:frontend/data/instituicoes/dtos/instituicao_dto.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';

class InstituicaoModel {
  final int id;
  final String nome;

  InstituicaoModel(this.id, this.nome);

  factory InstituicaoModel.fromJDto(InstituicaoDTO dto) {
    return InstituicaoModel(dto.id, dto.nome);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'nome': nome};

  InstituicaoEntity toEntity() {
    return InstituicaoEntity(id: id, nome: nome);
  }
}
