/*import 'package:adge/api/AdgeApi.dart';
import 'package:adge/app/values/responsive_app.dart';
import 'package:adge/app/values/string_app.dart';
import 'package:adge/providers/auth_provider.dart';
import 'package:adge/router/router.dart';
import 'package:adge/services/local_storage.dart';
import 'package:adge/ui/layouts/auth/auth_layout.dart';
import 'package:adge/ui/layouts/splash/splash_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalStorage.configurePrefs();
  AdgeApi.configureDio();

  Flurorouter.configureRoutes();

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ResponsiveApp responsiveApp;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appNameStr,
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return SplashLayout();
        }

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return SplashLayout();
        } else {
          return AuthLayout();
        }

        return Container();
      },
      theme: getAppTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

getAppTheme() {
  return ThemeData(
    backgroundColor: const Color.fromRGBO(235, 233, 246, 0),
    primaryColor: Colors.black,
    accentColor: Colors.orange,
    iconTheme: const IconThemeData(color: Colors.black),
    cardColor: Colors.white,
    primaryTextTheme: getTextTheme(),
    textTheme: getTextTheme(),
    indicatorColor: Colors.white,
    unselectedWidgetColor: Colors.yellow,
    tabBarTheme: const TabBarTheme(
        labelColor: Colors.black, unselectedLabelColor: Colors.blue),
  );
}

getTextTheme() {
  return const TextTheme(
      displaySmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black));
}
*/