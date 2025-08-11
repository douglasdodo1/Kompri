import 'package:frontend/domain/compras/entities/compras_entity.dart';

class ComprasState {
  final List<ComprasEntity> listaCompras;
  final bool carregando;
  final ComprasEntity? compra;
  final String tendencia;
  final String? erro;
  final bool sucesso;

  ComprasState({
    required this.listaCompras,
    required this.carregando,
    required this.compra,
    required this.tendencia,
    required this.erro,
    required this.sucesso,
  });

  factory ComprasState.inicial() => ComprasState(
    compra: null,
    listaCompras: [],
    carregando: false,
    tendencia: "",
    erro: null,
    sucesso: false,
  );

  ComprasState copyWith({
    List<ComprasEntity>? listaCompras,
    bool? carregando,
    ComprasEntity? compra,
    String? valorEstimado,
    String? tendencia,
    String? erro,
    bool? sucesso,
  }) {
    return ComprasState(
      compra: compra ?? this.compra,
      listaCompras: listaCompras ?? this.listaCompras,
      carregando: carregando ?? this.carregando,
      tendencia: tendencia ?? this.tendencia,
      erro: erro,
      sucesso: sucesso ?? this.sucesso,
    );
  }
}
