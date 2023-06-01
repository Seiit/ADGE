import 'package:adge/api/AdgeApi.dart';
import 'package:adge/firebase_options.dart';
import 'package:adge/providers/asignaciones/asignacion_form_provider.dart';
import 'package:adge/providers/asignaciones/asignaciones_provider.dart';
import 'package:adge/providers/auth/auth_provider.dart';
import 'package:adge/providers/calendarios/calendario_form_provider.dart';
import 'package:adge/providers/calendarios/calendarios_provider.dart';
import 'package:adge/providers/dashboard/sidemenu_provider.dart';
import 'package:adge/providers/empresas/empresa_form_provider.dart';
import 'package:adge/providers/empresas/empresas_provider.dart';
import 'package:adge/providers/eventos/evento_form_provider.dart';
import 'package:adge/providers/eventos/eventos_provider.dart';
import 'package:adge/providers/evidencias/evidencia_form_provider.dart';
import 'package:adge/providers/roles/rol_form_provider.dart';
import 'package:adge/providers/roles/roles_provider.dart';
import 'package:adge/providers/user/user_form_provider.dart';
import 'package:adge/providers/user/users_provider.dart';
import 'package:adge/router/router.dart';
import 'package:adge/services/local_storage.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/ui/layouts/auth/auth_layout.dart';
import 'package:adge/ui/layouts/dashboard_layout.dart';
import 'package:adge/ui/layouts/splash/splash_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalStorage.configurePrefs();
  AdgeApi.configureDio();

  Flurorouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider(context)),
        ChangeNotifierProvider(create: (_) => UserFormProvider()),
        ChangeNotifierProvider(create: (_) => RolesProvider(context)),
        ChangeNotifierProvider(create: (_) => RolFormProvider()),
        ChangeNotifierProvider(create: (_) => EmpresasProvider(context)),
        ChangeNotifierProvider(create: (_) => EmpresaFormProvider()),
        ChangeNotifierProvider(create: (_) => AsignacionesProvider(context)),
        ChangeNotifierProvider(create: (_) => AsignacionFormProvider()),
        ChangeNotifierProvider(create: (_) => EventosProvider(context)),
        ChangeNotifierProvider(create: (_) => EventoFormProvider()),
        ChangeNotifierProvider(create: (_) => CalendariosProvider(context)),
        ChangeNotifierProvider(create: (_) => CalendarioFormProvider()),
        ChangeNotifierProvider(create: (_) => EvidenciaFormProvider())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ADGE',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking)
          return SplashLayout();

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5)))),
    );
  }
}
