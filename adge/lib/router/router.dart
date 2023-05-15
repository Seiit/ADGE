import 'package:adge/router/auth/auth_handlers.dart';
import 'package:adge/router/dashboard_handlers.dart';
import 'package:adge/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute = '/dashboard';
  static String blankRoute = '/dashboard/blank';
  static String categoriesRoute = '/dashboard/categories';

  static String usersRoute = '/dashboard/users';
  static String userRoute = '/dashboard/users/:uid';

  static String rolesRoute = '/dashboard/roles';
  static String rolRoute = '/dashboard/roles/:id';

  static String iconsRoute = '/dashboard/empresa';

  static void configureRoutes() async {
    // Auth Routes
    router.define(rootRoute,
        handler: await AuthHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: await AuthHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AuthHandlers.register, transitionType: TransitionType.none);

    // Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);

    router.define(rolesRoute,
        handler: DashboardHandlers.roles,
        transitionType: TransitionType.fadeIn);

    router.define(rolRoute,
        handler: DashboardHandlers.rol, transitionType: TransitionType.fadeIn);

/*
// Dashboard
    
    router.define(blankRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);
    router.define(categoriesRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);
    router.define(iconsRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);
*/
    // users
    router.define(usersRoute,
        handler: DashboardHandlers.users,
        transitionType: TransitionType.fadeIn);

    router.define(userRoute,
        handler: DashboardHandlers.user, transitionType: TransitionType.fadeIn);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
