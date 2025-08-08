import 'package:frontend/core/utils/virgula_para_ponto.dart';

double calcularValorProgresso(String valor1, String valor2) {
  final double v1 = double.tryParse(virgulaParaPonto(valor1)) ?? 0.0;
  final double v2 = double.tryParse(virgulaParaPonto(valor2)) ?? 0.0;
  if (v2 == 0) return 0.0;
  final double progresso = v1 / v2;
  return progresso;
}
