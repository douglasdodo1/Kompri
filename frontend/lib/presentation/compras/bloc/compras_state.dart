import 'package:frontend/domain/compras/entities/compras_entity.dart';

class ComprasState {
  final List<ComprasEntity> comprasRecentes;
  final bool carregando;
  final ComprasEntity? compra;
  final String valorEstimado;
  final String tendencia;
  final String? erro;
  final bool sucesso;

  ComprasState({
    required this.valorEstimado,
    required this.comprasRecentes,
    required this.carregando,
    required this.compra,
    required this.tendencia,
    required this.erro,
    required this.sucesso,
  });

  factory ComprasState.inicial() => ComprasState(
    compra: null,
    comprasRecentes: [],
    carregando: false,
    tendencia: "",
    valorEstimado: "0",
    erro: null,
    sucesso: false,
  );

  ComprasState copyWith({
    List<ComprasEntity>? comprasRecentes,
    bool? carregando,
    ComprasEntity? compra,
    String? valorEstimado,
    String? tendencia,
    String? erro,
    bool? sucesso,
  }) {
    return ComprasState(
      compra: compra ?? this.compra,
      comprasRecentes: comprasRecentes ?? this.comprasRecentes,
      carregando: carregando ?? this.carregando,
      tendencia: tendencia ?? this.tendencia,
      valorEstimado: valorEstimado ?? this.valorEstimado,
      erro: erro,
      sucesso: sucesso ?? this.sucesso,
    );
  }
}
