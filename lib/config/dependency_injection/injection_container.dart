import 'package:chairy_e_commerce_app/core/network/api_service.dart';
import 'package:chairy_e_commerce_app/features/product/domain/repositories/cart_repository.dart';
import 'package:chairy_e_commerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../features/product/data/datasource/product_remote_data_source.dart';
import 'injection_container.config.dart';

final sl = GetIt.instance;

Future<void> init(GetIt sl) async {
  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton<Dio>(() => Dio());
  }
  sl.registerLazySingleton(
    () => ApiService(),
  );
  sl.registerLazySingleton(
    () => ProductRepository(),
  );
  sl.registerLazySingleton(
    () => CartRepository(),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());


}

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => init(sl);
