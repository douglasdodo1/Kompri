import 'package:frontend/presentation/usuarios/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/presentation/compras/pages/compra_page.dart';
import 'package:frontend/presentation/compras/pages/compras_historico_page.dart';
import 'package:frontend/presentation/produtos/pages/lista_produtos_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/compra', builder: (context, state) => const CompraPage()),
    GoRoute(
      path: '/produtos',
      builder: (context, state) => const ListaProdutosPage(),
    ),
    GoRoute(
      path: '/historico',
      builder: (context, state) => const CompraHistoricoPage(),
    ),
  ],
);
