import 'package:cashmify_admin/models/transaction_model.dart';
import 'package:cashmify_admin/pages/transactions/controller/transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionController controller = Get.put(TransactionController());

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
              "Transactions",
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
                      controller.searchTransaction(value);
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
                            controller.getTransactions();
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
                            controller.getTransactions();
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
                          var model =
                              TransactionsModel.fromJson(data!, snapshot[i].id);
                          return UserItem(
                            model: model,
                            context: context,
                            actionTap: (offset) {
                              // showMenuItems(context, offset, user);
                            },
                          );
                        },
                        query: controller.query.value,
                        itemBuilderType: PaginateBuilderType.listView,
                      )
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: controller.transactions.length,
                //     itemBuilder: (context, index) {
                //       return UserItem(
                //         model: controller.transactions[index],
                //         context: context,
                //         actionTap: (offset) {
                //           // showMenuItems(
                //           //   context,
                //           //   offset,
                //           //   index,
                //           // );
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

  showMenuItems(BuildContext context, Offset offset, int index) async {
    double left = offset.dx;
    double top = offset.dy;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          child: const Text("Edit"),
          value: 1,
          onTap: () {},
        ),
        PopupMenuItem(
          child: const Text("Delete"),
          value: 2,
          onTap: () {},
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
              "Method",
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
              "Type",
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
              "Created At",
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
              "Amount",
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
              "Status",
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
    required TransactionsModel model,
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
              model.username,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 15,
            child: Text(
              model.method,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              model.type,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              DateFormat.yMd().format(model.createdAt),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 10,
            child: Text(
              "${model.amount}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 5,
            child: Text(
              model.status,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: getStatusColor(model.status),
              ),
            ),
          ),
          // SizedBox(
          //   width: context.percentWidth * 5,
          //   child: MouseRegion(
          //     cursor: SystemMouseCursors.click,
          //     child: GestureDetector(
          //       onTapDown: (details) => actionTap(details.globalPosition),
          //       child: const Icon(Icons.more_horiz_rounded),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Canceled":
        return Colors.red;
      case "Completed":
        return Colors.green;
      case "Pending":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}
