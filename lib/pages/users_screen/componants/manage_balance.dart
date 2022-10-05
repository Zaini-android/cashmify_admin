import 'package:flutter/material.dart';

class ManageBalance extends StatelessWidget {
  final Function() deposit;
  final Function() withdraw;
  final TextEditingController controller;
  const ManageBalance({
    Key? key,
    required this.deposit,
    required this.withdraw,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "Amount",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => deposit(),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Deposit",
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
            onTap: () => withdraw(),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Withdraw",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
