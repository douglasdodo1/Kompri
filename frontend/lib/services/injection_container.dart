import 'package:frontend/data/auth/repositorys/auth_repository.dart';
import 'package:frontend/data/compras/repository/compras_repository_impl.dart';
import 'package:frontend/data/itens/repositories/item_repository_impl.dart';
import 'package:frontend/data/produtos/repositories/produto_repository_impl.dart';
import 'package:frontend/data/usuarios/repositorys/usuario_repository.dart';
import 'package:frontend/domain/auth/repositorys/auth_repository.dart';
import 'package:frontend/domain/auth/usecases/auth_usecase.dart';
import 'package:frontend/domain/compras/usecases/compra_usecase.dart';
import 'package:frontend/domain/itens/repositories/item_repository.dart';
import 'package:frontend/domain/itens/usecases/item_usecase.dart';
import 'package:frontend/domain/produtos/repositories/produto_repository.dart';
import 'package:frontend/domain/produtos/usecases/produto_usecase.dart';
import 'package:frontend/domain/usuarios/repositorys/usuarios_repository.dart';
import 'package:frontend/domain/usuarios/usecases/usuarios_usecase.dart';
import 'package:frontend/presentation/auth/bloc/auth_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_bloc.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AuthRepository>(() => sl<AuthRepositoryImpl>());
  sl.registerLazySingleton<AuthUsecase>(() => sl<AuthUsecase>());
  sl.registerFactory(() => AuthBloc(sl<AuthUsecase>()));

  sl.registerLazySingleton<UsuariosRepository>(() => UsuariosRepositoryImpl());
  sl.registerLazySingleton(() => UsuariosUseCase(sl<UsuariosRepository>()));
  sl.registerFactory(() => UsuariosBloc(sl<UsuariosUseCase>()));

  sl.registerLazySingleton<ComprasRepository>(() => ComprasRepositoryImpl());
  sl.registerLazySingleton(() => CompraUsecase(sl<ComprasRepository>()));
  sl.registerFactory(() => ComprasBloc(sl<CompraUsecase>()));

  sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl());
  sl.registerLazySingleton(() => ItemUsecase(sl<ItemRepository>()));

  sl.registerLazySingleton<ProdutoRepository>(() => ProdutoRepositoryImpl());
  sl.registerLazySingleton(() => ProdutoUsecase(sl<ProdutoRepository>()));
  sl.registerCachedFactory(() => ProdutosBloc(sl<ProdutoUsecase>()));
}
