import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';

class ComprasState {
  final List<ComprasEntity> listaCompras;
  final bool carregando;
  final ComprasEntity compraAtual;
  final ComprasEntity? proximaCompra;
  final Map<String, String> economiaPorMes;
  final Map<String, String> porcentagemPorMesLucro;
  final String tendencia;
  final String? erro;
  final bool sucesso;

  ComprasState({
    required this.listaCompras,
    required this.carregando,
    required this.compraAtual,
    required this.proximaCompra,
    required this.economiaPorMes,
    required this.porcentagemPorMesLucro,
    required this.tendencia,
    required this.erro,
    required this.sucesso,
  });

  factory ComprasState.inicial() => ComprasState(
    compraAtual: ComprasEntity(
      id: 0,
      valorTotal: '0.00',
      valorEstimado: '0.00',
      qtdItens: 0,
      data: '',
      status: '',
      usuarioCpf: '',
      instituicao: InstituicaoEntity(nome: '', id: 0),
    ),
    listaCompras: [],
    proximaCompra: null,
    economiaPorMes: {},
    porcentagemPorMesLucro: {},
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
    Map<String, String>? economiaPorMes,
    Map<String, String>? porcentagemPorMesLucro,
    String? tendencia,
    String? erro,
    bool? sucesso,
  }) {
    return ComprasState(
      compraAtual: compra ?? compraAtual,
      listaCompras: listaCompras ?? this.listaCompras,
      carregando: carregando ?? this.carregando,
      tendencia: tendencia ?? this.tendencia,
      erro: erro,
      sucesso: sucesso ?? this.sucesso,
      porcentagemPorMesLucro:
          porcentagemPorMesLucro ?? this.porcentagemPorMesLucro,
      proximaCompra: null,
      economiaPorMes: economiaPorMes ?? this.economiaPorMes,
    );
  }
}
