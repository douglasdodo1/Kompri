import 'package:frontend/data/compras/repository/compras_repository_impl.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:frontend/domain/compras/repositories/compras_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ComprasRepository>(() => ComprasRepositoryImpl());
  sl.registerFactory(() => ComprasBloc(sl()));
}
