import 'package:badges/badges.dart';
import 'package:cashmify_admin/models/nav_item.dart';
import 'package:cashmify_admin/pages/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SideNavBar extends StatelessWidget {
  final List<NavBarItem> items;
  final Function(int) onChange;
  final int currentindex;
  const SideNavBar({
    Key? key,
    required this.items,
    required this.onChange,
    this.currentindex = 0,
  }) : super(key: key);

  Widget _buildLogoandName() {
    return Row(
      children: const [
        Text(
          "Cashmify",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildSignOutButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Icon(
          FontAwesomeIcons.signOutAlt,
          size: 28,
          color: Colors.black,
        ),
        SizedBox(width: 23),
        Text(
          "Sign Out",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogoandName(),
          const SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (ctx, i) {
              bool selected = currentindex == i;
              return InkWell(
                onTap: () => onChange(i),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selected ? Colors.black : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        items[i].icon,
                        size: 28,
                        color: selected ? Colors.white : Colors.black,
                      ),
                      const SizedBox(width: 23),
                      Text(
                        items[i].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          color: selected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => Login());
            },
            child: _buildSignOutButton(),
          ),
        ],
      ),
    );
  }
}
