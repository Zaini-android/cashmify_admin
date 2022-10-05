import 'package:cashmify_admin/pages/dashboard/componants/dash_card.dart';
import 'package:cashmify_admin/pages/dashboard/componants/verified_people_dialog.dart';
import 'package:cashmify_admin/pages/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardScreen extends StatelessWidget {
  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashCard(
                    title: "All Deposit",
                    value:
                        "\$${NumberFormat.compact().format(controller.allDeposit.value)}",
                  ),
                  DashCard(
                    title: "All Cashout",
                    value:
                        "\$${NumberFormat.compact().format(controller.allCashout.value)}",
                  ),
                  DashCard(
                    title: "All Earning",
                    value:
                        "\$${NumberFormat.compact().format(controller.allEarning.value)}",
                  ),
                  DashCard(
                    title: "All Transfer",
                    value:
                        "\$${NumberFormat.compact().format(controller.allTransfer.value)}",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashCard(
                    title: "Users",
                    value: NumberFormat.compact()
                        .format(controller.allUsers.value),
                  ),
                  DashCard(
                    title: "Active Giveaway",
                    value: NumberFormat.compact()
                        .format(controller.activeGiveaways.value),
                  ),
                  DashCard(
                    title: "Active Giveaway Amount",
                    value:
                        "\$${NumberFormat.compact().format(controller.activeGiveawayAmount.value)}",
                  ),
                  DashCard(
                    title: "Pending Requests",
                    value: NumberFormat.compact()
                        .format(controller.pendingRequests.value),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashCard(
                    title: "Charity Wallet Amount",
                    value:
                        "\$${NumberFormat.compact().format(controller.allCharityWalletAmount.value)}",
                  ),
                  DashCard(
                    title: "Earning Wallet Amount",
                    value:
                        "\$${NumberFormat.compact().format(controller.allEarningWalletAmount.value)}",
                  ),
                  DashCard(
                    title: "Bonus Amount",
                    value:
                        "\$${NumberFormat.compact().format(controller.allBonusAmount.value)}",
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: "Users",
                          content: VerifiedPeopleDialog(
                              authers: controller.verifiedAuthers),
                        );
                      },
                      child: DashCard(
                        title: "Verified People",
                        value:
                            "\$${NumberFormat.compact().format(controller.verifiedPeopleAmount.value)}",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashCard(
                    title: "Yesterday Online",
                    value: NumberFormat.compact()
                        .format(controller.yesterdayOnlineCount.value),
                  ),
                  DashCard(
                    title: "Today Online",
                    value: NumberFormat.compact()
                        .format(controller.todaysOnlineCount.value),
                  ),
                  SizedBox(width: context.percentWidth * 18),
                  SizedBox(width: context.percentWidth * 18),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
