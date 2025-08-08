String calcularDiferenca(String? valor1, String? valor2) {
  if (valor1 == null || valor2 == null || valor1.isEmpty || valor2.isEmpty) {
    return '0.00';
  }
  final double v1 = double.tryParse(valor1.replaceAll(',', '.')) ?? 0.0;
  final double v2 = double.tryParse(valor2.replaceAll(',', '.')) ?? 0.0;

  final double diff = v1 - v2;

  return diff.toStringAsFixed(2);
}
