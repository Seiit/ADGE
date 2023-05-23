import 'package:adge/providers/auth/auth_provider.dart';
import 'package:adge/providers/dashboard/sidemenu_provider.dart';
import 'package:adge/router/router.dart';
import 'package:adge/services/navigation_service.dart';
import 'package:adge/ui/views/shared/widgets/logo.dart';
import 'package:adge/ui/views/shared/widgets/menu_item.dart';
import 'package:adge/ui/views/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Logo(),
          SizedBox(height: 50),
          TextSeparator(text: 'Administracion'),
          MenuItem(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          ),
          MenuItem(
            text: 'Eventos',
            icon: Icons.shopping_cart_outlined,
            onPressed: () => navigateTo(Flurorouter.eventosRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.eventosRoute,
          ),
          MenuItem(
              text: 'Analytic',
              icon: Icons.show_chart_outlined,
              onPressed: () {}),
          MenuItem(
            text: 'Roles',
            icon: Icons.layers_outlined,
            onPressed: () => navigateTo(Flurorouter.rolesRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.rolesRoute,
          ),
          MenuItem(
            text: 'Empresas',
            icon: Icons.dashboard_outlined,
            onPressed: () => navigateTo(Flurorouter.empresasRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.empresasRoute,
          ),
          MenuItem(
            text: 'Calendarios',
            icon: Icons.attach_money_outlined,
            onPressed: () => navigateTo(Flurorouter.calendariosRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.calendariosRoute,
          ),
          MenuItem(
            text: 'Users',
            icon: Icons.people_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.usersRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
          ),
          SizedBox(height: 30),
          TextSeparator(text: 'Personal'),
          MenuItem(
            text: 'Empresa',
            icon: Icons.list_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.empresasRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.empresasRoute,
          ),
          MenuItem(
              text: 'Marketing',
              icon: Icons.mark_email_read_outlined,
              onPressed: () {}),
          MenuItem(
              text: 'Campaign',
              icon: Icons.note_add_outlined,
              onPressed: () {}),
          MenuItem(
            text: 'Black',
            icon: Icons.post_add_outlined,
            onPressed: () => navigateTo(Flurorouter.blankRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
          ),
          SizedBox(height: 50),
          TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Logout',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xffC62828),
        Color(0xffB71C1C),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
