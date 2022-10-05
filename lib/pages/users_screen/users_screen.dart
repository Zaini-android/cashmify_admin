import 'package:cashmify_admin/models/user_model.dart';
import 'package:cashmify_admin/pages/users_screen/componants/edit_user_form.dart';
import 'package:cashmify_admin/pages/users_screen/componants/manage_balance.dart';
import 'package:cashmify_admin/pages/users_screen/componants/transactions_dialog/transaction_dialog.dart';
import 'package:cashmify_admin/pages/users_screen/componants/upload_dialog.dart';
import 'package:cashmify_admin/pages/users_screen/controller/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class UsersScreen extends StatelessWidget {
  UsersController controller = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Manage Users",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: context.percentWidth * 40,
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      controller.searchUsers(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search by username",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Obx(
                  () => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.selectedOrder.value = "Desc";
                            controller.refreshPage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            width: context.percentWidth * 6,
                            decoration: BoxDecoration(
                              color: controller.selectedOrder.value == "Desc"
                                  ? Colors.black
                                  : null,
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "DESC",
                                style: TextStyle(
                                  color:
                                      controller.selectedOrder.value == "Desc"
                                          ? Colors.white
                                          : Colors.black,
                                  fontWeight:
                                      controller.selectedOrder.value == "Desc"
                                          ? FontWeight.bold
                                          : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.selectedOrder.value = "Asc";
                            controller.refreshPage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            width: context.percentWidth * 6,
                            decoration: BoxDecoration(
                              color: controller.selectedOrder.value == "Asc"
                                  ? Colors.black
                                  : null,
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "ASC",
                                style: TextStyle(
                                  color: controller.selectedOrder.value == "Asc"
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight:
                                      controller.selectedOrder.value == "Asc"
                                          ? FontWeight.bold
                                          : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            itemHeader(context),
            Obx(() => controller.loading.value
                    ? LinearProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.black.withOpacity(0.6),
                      )
                    : PaginateFirestore(
                        itemsPerPage: 50,
                        shrinkWrap: true,
                        itemBuilder: (ctx, snapshot, i) {
                          final data = snapshot[i].data() as Map?;
                          var user = UserModel.fromJson(data!, snapshot[i].id);
                          return UserItem(
                            user: user,
                            context: context,
                            actionTap: (offset) {
                              showMenuItems(context, offset, user);
                            },
                          );
                        },
                        isLive: true,
                        query: controller.query.value,
                        itemBuilderType: PaginateBuilderType.listView,
                      )
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: controller.users.length,
                //     itemBuilder: (context, index) {
                //       return UserItem(
                //         user: controller.users[index],
                //         context: context,
                //         actionTap: (offset) {
                //           showMenuItems(
                //             context,
                //             offset,
                //             index,
                //           );
                //         },
                //       );
                //     },
                //   ),
                ),
          ],
        ),
      ),
    );
  }

  showMenuItems(BuildContext context, Offset offset, UserModel user) async {
    double left = offset.dx;
    double top = offset.dy;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          child: const Text("Edit"),
          value: 1,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.defaultDialog(
                titlePadding: const EdgeInsets.all(8.0),
                title: 'Edit User',
                contentPadding: const EdgeInsets.all(16.0),
                radius: 11.0,
                content: EditUserForm(
                  user: user,
                  onUpdate: (model) {
                    controller.updateUser(model).then((value) => Get.back());
                  },
                ),
              );
            });
          },
        ),
        PopupMenuItem(
          child: const Text("Delete"),
          value: 2,
          onTap: () {
            controller.deleteUser(user.userId);
          },
        ),
        PopupMenuItem(
          child: const Text("Manage Wallet"),
          value: 3,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.defaultDialog(
                titlePadding: const EdgeInsets.all(8.0),
                title: 'Manage Wallet',
                contentPadding: const EdgeInsets.all(16.0),
                radius: 11.0,
                content: ManageBalance(
                  deposit: () {
                    controller.depositWallet(user).then((value) {
                      Get.back();
                      Get.snackbar(
                        "Success",
                        "Wallet deposited",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    });
                  },
                  withdraw: () {
                    controller.withdrawWallet(user).then((value) {
                      Get.back();
                      Get.snackbar(
                        "Success",
                        "Wallet withdrawn",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    });
                  },
                  controller: controller.amountController,
                ),
              );
            });
          },
        ),
        PopupMenuItem(
          child: const Text("Manage Earning"),
          value: 4,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.defaultDialog(
                titlePadding: const EdgeInsets.all(8.0),
                title: 'Manage Earning',
                contentPadding: const EdgeInsets.all(16.0),
                radius: 11.0,
                content: ManageBalance(
                  deposit: () {
                    controller.depositEarning(user).then((value) {
                      Get.back();
                      Get.snackbar(
                        "Success",
                        "Earning deposited",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    });
                  },
                  withdraw: () {
                    controller.withdrawEarning(user).then((value) {
                      Get.back();
                      Get.snackbar(
                        "Success",
                        "Earning withdrawn",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    });
                  },
                  controller: controller.amountController,
                ),
              );
            });
          },
        ),
        PopupMenuItem(
          child: const Text("Transactions"),
          value: 5,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.defaultDialog(
                titlePadding: const EdgeInsets.all(8.0),
                title: 'User Transactions',
                contentPadding: const EdgeInsets.all(16.0),
                radius: 11.0,
                content: TransactionDialog(model: user),
              );
            });
          },
        ),
        PopupMenuItem(
          child: const Text("Upload Video"),
          value: 5,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.defaultDialog(
                titlePadding: const EdgeInsets.all(8.0),
                title: 'Upload Video',
                contentPadding: const EdgeInsets.all(16.0),
                radius: 11.0,
                content: UploadDialog(
                  model: user,
                  amountController: controller.amountController,
                  loading: controller.loading1,
                  onTap: () => controller.uploadVideo(user),
                ),
              );
            });
          },
        ),
      ],
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
            width: context.percentWidth * 15,
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
              "Country",
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
              "Created At",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          // const SizedBox(width: 20),
          SizedBox(
            width: context.percentWidth * 10,
            child: const Text(
              "Earning Balance",
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
              "Wallet Balance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 5,
            child: const Text(
              "Actions",
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
    required UserModel user,
    required BuildContext context,
    required Function(Offset) actionTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: Text(
              user.username,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          // const SizedBox(width: 20),
          SizedBox(
            width: context.percentWidth * 15,
            child: Text(
              user.email,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              user.country,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              DateFormat.yMd().format(user.timestamp),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          // const SizedBox(width: 20),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              "\$${user.earningBalance.toStringAsFixed(2)} (\$${user.totalEarned})",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          // const SizedBox(width: 20),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              "\$${user.walletBalance.toStringAsFixed(2)} (\$${user.totalGaveaway})",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 5,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTapDown: (details) => actionTap(details.globalPosition),
                child: const Icon(Icons.more_horiz_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
