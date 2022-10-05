import 'package:cashmify_admin/pages/dashboard/controller/dashboard_controller.dart';
import 'package:cashmify_admin/pages/dashboard/dashboard_screen.dart';
import 'package:cashmify_admin/pages/giveaways/giveaways.dart';
import 'package:cashmify_admin/pages/home/componants/sidebar_menu.dart';
import 'package:cashmify_admin/pages/home/controller/home_controller.dart';
import 'package:cashmify_admin/pages/requests/requests.dart';
import 'package:cashmify_admin/pages/settings/settings.dart';
import 'package:cashmify_admin/pages/transactions/transactions.dart';
import 'package:cashmify_admin/pages/users_screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Row(
          children: [
            Flexible(
              flex: 2,
              child: SideNavBar(
                items: controller.nav_items,
                onChange: (i) => controller.changeTab(i),
                currentindex: controller.currentIndex.value,
              ),
            ),
            Flexible(
              flex: 9,
              child: IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  DashboardScreen(),
                  UsersScreen(),
                  TransactionsScreen(),
                  RequestScreen(),
                  GiveawaysScreen(),
                  SettingsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
