import 'package:chairy_e_commerce_app/config/router/app_router.dart';
import 'package:chairy_e_commerce_app/features/product/domain/repositories/cart_repository.dart';
import 'package:chairy_e_commerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/localization_bloc/localization_bloc.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/product_bloc/product_event.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/dependency_injection/injection_container.dart';
import 'features/product/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'features/product/presentation/blocs/cart_bloc/cart_event.dart';
import 'features/product/presentation/blocs/check_out_bloc/checkout_bloc.dart';
import 'features/product/presentation/blocs/product_bloc/product_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeNotifications();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  await EasyLocalization.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('language_code') ?? 'en';
  Locale locale = Locale(languageCode);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      startLocale: locale,
      saveLocale: true,
      child: MyApp(),
    ),
  );
}

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings();

  final InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    settings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      debugPrint("Notification Clicked: ${response.payload}");
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(
            create: (context) => CartBloc(CartRepository())..add(LoadCart())),
        BlocProvider(
            create: (context) =>
                LocalizationBloc()..add(ChangeLanguageEvent(Locale('en')))),
        BlocProvider(create: (context) => ThemeBloc()..add(LoadThemeEvent())),
        BlocProvider(
            create: (_) => ProductBloc(repository: ProductRepository())
              ..add(LoadProductEvent())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.black,
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: "Montserrat",
                    bodyColor: Colors.black,
                    displayColor: Colors.black,
                  ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.white,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: "Montserrat",
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}
