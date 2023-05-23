import 'package:adge/providers/auth/auth_provider.dart';
import 'package:adge/providers/dashboard/sidemenu_provider.dart';
import 'package:adge/router/router.dart';
import 'package:adge/ui/views/asignaciones/asignacion_view.dart';
import 'package:adge/ui/views/auth/login_view.dart';
import 'package:adge/ui/views/dashboard_view.dart';
import 'package:adge/ui/views/asignaciones/asignaciones_view.dart';
import 'package:adge/ui/views/empresas/empresa_view.dart';
import 'package:adge/ui/views/empresas/empresas_view.dart';
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
        .setCurrentPageUrl(Flurorouter.userRoute);

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

  /*
// users
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
*/
  /*

  static Handler icons = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.iconsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return IconsView();
    else
      return LoginView();
  });

  static Handler blank = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.blankRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return BlankView();
    else
      return LoginView();
  });

  static Handler categories = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.categoriesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return CategoriesView();
    else
      return LoginView();
  });

  // users
  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return UsersView();
    else
      return LoginView();
  });

  // user
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

  */
}
