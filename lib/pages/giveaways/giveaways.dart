import 'package:cashmify_admin/models/giveaway_model.dart';
import 'package:cashmify_admin/models/transaction_model.dart';
import 'package:cashmify_admin/pages/giveaways/componants/winners_dialog/winner_dialog.dart';
import 'package:cashmify_admin/pages/giveaways/controller/giveaways_controller.dart';
import 'package:cashmify_admin/pages/requests/componants/request_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class GiveawaysScreen extends StatelessWidget {
  GiveawayController controller = Get.put(GiveawayController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Giveaways",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.selectedOrder.value = "Desc";
                            controller.getGiveaways();
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
                            controller.getGiveaways();
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
                          return FutureBuilder(
                            future: controller.getGiveawayUser(
                                data!, snapshot[i].id),
                            builder: (context, future) {
                              if (future.hasData) {
                                var model = future.data as GiveawayModel;
                                return UserItem(
                                  model: model,
                                  context: context,
                                  actionTap: (offset) {
                                    Get.defaultDialog(
                                      titlePadding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      title: 'Winners',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      radius: 11.0,
                                      content: WinnerDialog(
                                        model: model,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                          // return UserItem(
                          //   model: model,
                          //   context: context,
                          //   actionTap: (offset) {
                          //     Get.defaultDialog(
                          //       titlePadding:
                          //           const EdgeInsets.symmetric(vertical: 8.0),
                          //       title: 'Winners',
                          //       contentPadding:
                          //           const EdgeInsets.symmetric(horizontal: 16),
                          //       radius: 11.0,
                          //       content: WinnerDialog(
                          //         model: model,
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        query: controller.query.value,
                        itemBuilderType: PaginateBuilderType.listView,
                      )
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: controller.giveaways.length,
                //     itemBuilder: (context, index) {
                //       return UserItem(
                //         model: controller.giveaways[index],
                //         context: context,
                //         actionTap: (offset) {
                //           Get.defaultDialog(
                //             titlePadding:
                //                 const EdgeInsets.symmetric(vertical: 8.0),
                //             title: 'Winners',
                //             contentPadding:
                //                 const EdgeInsets.symmetric(horizontal: 16),
                //             radius: 11.0,
                //             content: WinnerDialog(
                //               model: controller.giveaways[index],
                //             ),
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
            width: context.percentWidth * 7,
            child: const Text(
              "Owner",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: const Text(
              "Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
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
            width: context.percentWidth * 7,
            child: const Text(
              "Max Participants",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: const Text(
              "Joined",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: const Text(
              "Amount",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 6,
            child: const Text(
              "Created At",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 6,
            child: const Text(
              "Pin Code",
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
    required GiveawayModel model,
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
            width: context.percentWidth * 7,
            child: Text(
              model.auther!.username,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: Text(
              model.status,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: getStatusColor(model.status),
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: Text(
              model.countryCode,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: Text(
              model.maxParticpant.toString(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: Text(
              "${model.particpantsIds.length}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 7,
            child: Text(
              model.amount.toString(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 6,
            child: Text(
              DateFormat.yMd().format(model.timestamp),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 6,
            child: Text(
              model.code,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 5,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTapDown: (details) => actionTap(details.globalPosition),
                child: const Icon(FontAwesomeIcons.arrowAltCircleRight),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "waiting":
        return Colors.teal;
      case "finished":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
