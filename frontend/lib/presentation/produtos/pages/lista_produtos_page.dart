import 'package:flutter/material.dart';
import 'package:frontend/presentation/produtos/widgets/lista_produtos_widget.dart';

class ListaProdutosPage extends StatelessWidget {
  const ListaProdutosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meus produtos",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 56, 57, 58),
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
      body: ListaProdutosWidget(),
    );
  }
}
