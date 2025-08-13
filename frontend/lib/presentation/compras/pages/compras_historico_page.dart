import 'package:flutter/material.dart';
import 'package:frontend/presentation/compras/widgets/lista_compras.dart';

class CompraHistoricoPage extends StatelessWidget {
  const CompraHistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de compras"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.grey, height: 1.0),
        ),
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 240, 238, 238),
          child: const ListaCompras(),
        ),
      ),
    );
  }
}
