import 'package:flutter/material.dart';
import 'package:frontend/presentation/compras/widgets/lista_compras.dart';

class CompraHistoricoPage extends StatelessWidget {
  const CompraHistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 243, 234),
        title: const Text("Histórico de compras"),
      ),
      body: Center(child: ListaCompras()),
    );
  }
}
