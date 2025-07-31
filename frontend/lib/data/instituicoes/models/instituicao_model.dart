import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';

class InstituicaoModel {
  final int id;
  final String nome;

  InstituicaoModel(this.id, this.nome);

  factory InstituicaoModel.fromJson(Map<String, dynamic> json) {
    return InstituicaoModel(json['id'], json['nome']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'nome': nome};

  InstituicaoEntity toEntity() {
    return InstituicaoEntity(id: id, nome: nome);
  }
}
