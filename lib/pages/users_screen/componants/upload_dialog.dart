import 'package:cashmify_admin/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class UploadDialog extends StatelessWidget {
  final UserModel model;
  final TextEditingController amountController;
  final RxBool loading;
  final Function onTap;
  const UploadDialog({
    Key? key,
    required this.model,
    required this.amountController,
    required this.loading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Amount",
              border: OutlineInputBorder(),
            ),
            controller: amountController,
          ),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onTap(),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: loading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "UPLOAD",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
