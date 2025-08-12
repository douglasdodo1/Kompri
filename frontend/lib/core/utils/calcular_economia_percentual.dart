String calcularEconomiaPercentual(
  String valorTotalAtual,
  String valorTotalAnterior,
) {
  final double totalAtual =
      double.tryParse(valorTotalAtual.replaceAll(',', '.')) ?? 0.0;
  final double totalAnterior =
      double.tryParse(valorTotalAnterior.replaceAll(',', '.')) ?? 0.0;

  if (totalAnterior == 0) return '0.00';
  if (totalAtual == totalAnterior) {
    return '0.00';
  }
  final double diferenca = totalAtual - totalAnterior;
  final double percentual = ((diferenca / totalAnterior) * 100);
  print(
    'totalAtual: $totalAtual, totalAnterior: $totalAnterior, diferenca: $diferenca, percentual: $percentual',
  );

  return percentual.toStringAsFixed(2);
}
