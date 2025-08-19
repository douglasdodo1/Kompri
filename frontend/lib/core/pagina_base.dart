import 'package:flutter/material.dart';
import 'package:frontend/presentation/auth/pages/login_page.dart';
import 'package:frontend/presentation/compras/pages/compra_page.dart';
import 'package:frontend/presentation/compras/pages/compras_historico_page.dart';
import 'package:frontend/presentation/produtos/pages/lista_produtos_page.dart';
import 'package:frontend/core/widgets/app_footer.dart';
import 'package:go_router/go_router.dart';

class PaginaBase extends StatefulWidget {
  const PaginaBase({super.key});

  @override
  State<PaginaBase> createState() => _PaginaBaseState();
}

class _PaginaBaseState extends State<PaginaBase> {
  int selectedIndex = 0;

  final List<String> routes = ['/compra', '/produtos', '/historico'];

  final List<Widget> pages = [
    const CompraPage(),
    const ListaProdutosPage(),
    const CompraHistoricoPage(),
  ];

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);
    GoRouter.of(context).go(routes[index]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocation = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();
    final index = routes.indexWhere((r) => currentLocation.startsWith(r));
    if (index != -1 && index != selectedIndex) {
      setState(() => selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
