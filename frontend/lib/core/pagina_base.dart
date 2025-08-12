import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/app_footer.dart';
import 'package:frontend/presentation/compras/pages/compra_page.dart';
import 'package:frontend/presentation/compras/pages/compras_historico_page.dart';

class PaginaBase extends StatefulWidget {
  const PaginaBase({super.key});

  @override
  State<PaginaBase> createState() => _PaginaBaseState();
}

class _PaginaBaseState extends State<PaginaBase> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    CompraPage(),
    Center(child: Text('Carrinho')),
    CompraHistoricoPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: AppFooter(
        onItemTapped: onItemTapped,
        selectedIndex: selectedIndex,
      ),
    );
  }
}
