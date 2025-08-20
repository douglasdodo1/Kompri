import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/routes/app_router.dart';
import 'package:frontend/presentation/auth/bloc/auth_bloc.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_bloc.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:frontend/services/injection_container.dart' as di;
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_bloc.dart';

Future<void> resetApp() async {
  final prefs = await SharedPreferencesService.getInstance();
  await prefs.clear();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  await di.init();
  if (kDebugMode) {
    await resetApp();
    print("Cache resetada para testes");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
            BlocProvider<UsuariosBloc>(create: (_) => di.sl<UsuariosBloc>()),
            BlocProvider<ComprasBloc>(create: (_) => di.sl<ComprasBloc>()),
            BlocProvider<ProdutosBloc>(create: (_) => di.sl<ProdutosBloc>()),
          ],
          child: MaterialApp.router(
            title: 'Kompri',
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
          ),
        );
      },
    );
  }
}
