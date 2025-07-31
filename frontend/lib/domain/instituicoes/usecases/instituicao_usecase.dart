import 'package:frontend/domain/instituicoes/repositories/instituicao_repository.dart';

class InstituicaoUsecase {
  final InstituicaoRepository repository;

  InstituicaoUsecase(this.repository);

  Future<void> salvarInstituicao(String nome) async => {
    repository.salvarInstituicao(nome),
  };
}
