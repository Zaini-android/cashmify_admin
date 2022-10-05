import 'package:cashmify_admin/models/nav_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<NavBarItem> nav_items = [
    NavBarItem(icon: FontAwesomeIcons.home, name: "Dashboard"),
    NavBarItem(icon: FontAwesomeIcons.users, name: "Users"),
    NavBarItem(icon: FontAwesomeIcons.receipt, name: "Transactions"),
    NavBarItem(icon: FontAwesomeIcons.question, name: "Requests"),
    NavBarItem(icon: FontAwesomeIcons.gifts, name: "Giveaways"),
    NavBarItem(icon: FontAwesomeIcons.cogs, name: "Settings"),
  ];

  RxInt currentIndex = 0.obs;

  changeTab(int i) {
    currentIndex.value = i;
  }
}
