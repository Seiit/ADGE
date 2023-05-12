import 'package:adge/providers/auth/auth_provider.dart';
import 'package:adge/ui/views/auth/login_view.dart';
import 'package:adge/ui/views/auth/register_view.dart';
import 'package:adge/ui/views/dashboard_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AuthHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return DashboardView();
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return RegisterView();
    else
      return DashboardView();
  });
}
