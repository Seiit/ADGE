import 'package:adge/providers/auth/auth_provider.dart';
import 'package:adge/providers/dashboard/sidemenu_provider.dart';
import 'package:adge/router/router.dart';
import 'package:adge/ui/views/asignaciones/asignacion_view.dart';
import 'package:adge/ui/views/auth/login_view.dart';
import 'package:adge/ui/views/calendarios/calendario_view.dart';
import 'package:adge/ui/views/calendarios/calendarios_view.dart';
import 'package:adge/ui/views/dashboard_view.dart';
import 'package:adge/ui/views/asignaciones/asignaciones_view.dart';
import 'package:adge/ui/views/empresas/empresa_view.dart';
import 'package:adge/ui/views/empresas/empresas_view.dart';
import 'package:adge/ui/views/eventos/evento_view.dart';
import 'package:adge/ui/views/eventos/eventos_view.dart';
import 'package:adge/ui/views/evidencias/evidencia_view.dart';
import 'package:adge/ui/views/roles/rol_view.dart';
import 'package:adge/ui/views/roles/roles_view.dart';
import 'package:adge/ui/views/user/user_view.dart';
import 'package:adge/ui/views/user/users_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return DashboardView();
    else
      return LoginView();
  });

//users
  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return UsersView();
    else
      return LoginView();
  });

  static Handler user = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['uid']?.first != null) {
        return UserView(uid: params['uid']!.first);
      } else {
        return UsersView();
      }
    } else {
      return LoginView();
    }
  });

  static Handler roles = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.rolesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const RolesView();
    } else {
      return LoginView();
    }
  });

  static Handler rol = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['id']?.first != null) {
        return RolView(id: params['id']!.first, isCreate: false);
      } else {
        return RolesView();
      }
    } else {
      return LoginView();
    }
  });

  static Handler empresas = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.empresasRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const EmpresasView();
    } else {
      return LoginView();
    }
  });

  static Handler empresa = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.empresaRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['id']?.first != null) {
        return EmpresaView(id: params['id']!.first, isCreate: false);
      } else {
        return EmpresasView();
      }
    } else {
      return LoginView();
    }
  });

  static Handler asignaciones = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['uid']?.first != null) {
        return AsignacionesView(uid: params['uid']!.first);
      } else {
        return UsersView();
      }
    } else {
      return LoginView();
    }
  });

  static Handler asignacion = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.asignacionRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['id']?.first != null) {
        return AsignacionView(
          id: params['id']!.first,
          isCreate: false,
        );
      } else {
        return UsersView();
      }
    } else {
      return LoginView();
    }
  });

  static Handler eventos = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.eventosRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const EventosView();
    } else {
      return LoginView();
    }
  });

  static Handler evento = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.eventoRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['id']?.first != null) {
        return EventoView(
          id: params['id']!.first,
          isCreate: false,
        );
      } else {
        return EventosView();
      }
    } else {
      return LoginView();
    }
  });

  static Handler calendarios = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.calendariosRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CalendariosView();
    } else {
      return LoginView();
    }
  });

  static Handler calendario = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.calendarioRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['id']?.first != null) {
        return CalendarioView(
          id: params['id']!.first,
          isCreate: false,
        );
      } else {
        return CalendariosView();
      }
    } else {
      return LoginView();
    }
  });

  static Handler evidencia = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.calendarioRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['id']?.first != null) {
        return EvidenciaView(
          uid: params['id']!.first,
        );
      } else {
        return CalendariosView();
      }
    } else {
      return LoginView();
    }
  });
}
