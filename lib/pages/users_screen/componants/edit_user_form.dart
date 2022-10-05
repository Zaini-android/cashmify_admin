import 'package:cashmify_admin/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserForm extends StatelessWidget {
  final UserModel user;
  final Function(UserModel) onUpdate;
  const EditUserForm({
    Key? key,
    required this.user,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: user.firstname,
          decoration: const InputDecoration(
            labelText: "first name",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => user.firstname = value,
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: user.lastname,
          decoration: const InputDecoration(
            labelText: "last name",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => user.lastname = value,
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: user.username,
          decoration: const InputDecoration(
            labelText: "username",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => user.username = value,
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: user.email,
          decoration: const InputDecoration(
            labelText: "email",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => user.email = value,
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: user.phone,
          decoration: const InputDecoration(
            labelText: "phone",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => user.phone = value,
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: user.about,
          decoration: const InputDecoration(
            labelText: "about",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => user.about = value,
        ),
        const SizedBox(height: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onUpdate(user),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "UPDATE",
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
            onTap: () => Get.back(),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "CLOSE",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
