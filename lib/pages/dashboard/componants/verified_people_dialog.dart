import 'package:cashmify_admin/models/user_model.dart';
import 'package:cashmify_admin/pages/dashboard/controller/verified_people_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class VerifiedPeopleDialog extends StatelessWidget {
  final List<String> authers;
  VerifiedPeopleDialog({
    Key? key,
    required this.authers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifiedPeopleController controller =
        Get.put(VerifiedPeopleController(authers));
    return Obx(
      () => controller.loading.value
          ? LinearProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.black.withOpacity(0.5),
            )
          : Column(
              children: [
                itemHeader(context),
                SizedBox(
                  height: context.percentHeight * 70,
                  width: context.percentWidth * 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.users.length,
                    itemBuilder: (ctx, i) {
                      return UserItem(
                          model: controller.users[i], context: context);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget itemHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.percentWidth * 10,
            child: const Text(
              "Username",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: const Text(
              "Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: const Text(
              "Phone",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: const Text(
              "Country",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget UserItem({
    required UserModel model,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black.withOpacity(0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              model.username,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              model.email,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              model.phone,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              model.country,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
