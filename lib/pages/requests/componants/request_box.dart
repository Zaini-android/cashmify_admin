import 'package:cashmify_admin/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestBox extends StatelessWidget {
  final TransactionsModel model;
  final Function approve;
  final Function reject;
  final RxBool loading;
  const RequestBox({
    Key? key,
    required this.model,
    required this.approve,
    required this.reject,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTitleText(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          SelectableText(model.walletId),
          model.walletType == "Bank"
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Bank Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(model.bankName),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          const Text(
            "Wallet Type",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(model.walletType),
          const SizedBox(height: 10),
          const Text(
            "Amount",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text("\$${model.amount}"),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: loading.value ? null : () => approve(),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: loading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "APPROVE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: loading.value ? null : () => reject(),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: loading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "REJECT",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTitleText() {
    switch (model.walletType) {
      case "Paypal":
        return "Paypal email";
      case "Bank":
        return "Bank Account No";
      default:
        return "Wallet Address";
    }
  }
}
