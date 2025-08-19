import 'package:frontend/presentation/auth/pages/login_page.dart';
import 'package:frontend/presentation/usuarios/pages/cadastro_page.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/presentation/compras/pages/compra_page.dart';
import 'package:frontend/presentation/compras/pages/compras_historico_page.dart';
import 'package:frontend/presentation/produtos/pages/lista_produtos_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/compra',
      name: 'compra',
      builder: (context, state) => const CompraPage(),
    ),
    GoRoute(
      path: '/cadastro',
      name: 'cadastro',
      builder: (context, state) => const CadastroPage(),
    ),
    GoRoute(
      path: '/produtos',
      name: 'produtos',
      builder: (context, state) => const ListaProdutosPage(),
    ),
    GoRoute(
      path: '/historico',
      name: 'historico',
      builder: (context, state) => const CompraHistoricoPage(),
    ),
  ],
);
