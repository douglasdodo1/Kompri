import 'package:frontend/data/instituicoes/models/instituicao_model.dart';

class InstituicaoEntity {
  int id;
  String nome;

  InstituicaoEntity({required this.id, required this.nome});

  InstituicaoModel toModel() {
    return InstituicaoModel(id, nome);
  }

  @override
  String toString() {
    return 'InstituicaoEntity(id: $id, nome: $nome)';
  }
}
