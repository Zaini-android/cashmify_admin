import 'package:cashmify_admin/models/transaction_model.dart';
import 'package:cashmify_admin/models/user_model.dart';
import 'package:cashmify_admin/pages/users_screen/componants/transactions_dialog/controller/transaction_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class TransactionDialog extends StatelessWidget {
  final UserModel model;
  const TransactionDialog({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDialogController controller =
        Get.put(TransactionDialogController(model));
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
            "Transaction",
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
          width: context.percentWidth * 10,
          child: const Text(
            "Date",
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
            model.type,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: context.percentWidth * 10,
          child: Text(
            "\$${model.amount}",
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
            model.status,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
