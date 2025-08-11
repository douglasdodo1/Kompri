import 'package:intl/intl.dart';

String nomeDoMes(String mesNumero) {
  final mesInt = int.tryParse(mesNumero);
  if (mesInt == null || mesInt < 1 || mesInt > 12) return 'Mês inválido';

  final dt = DateTime(2025, mesInt);
  return DateFormat.MMMM('pt_BR').format(dt);
}
