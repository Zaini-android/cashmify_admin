
import 'package:cashmify_admin/models/user_model.dart';
import 'package:cashmify_admin/services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VerifiedPeopleController extends GetxController {
  List<String> authers;

  VerifiedPeopleController(this.authers);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool loading = false.obs;

  RxList<UserModel> users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getWinnerUsers();
  }

  getWinnerUsers() async {
    loading.value = true;
    users.value = await UserServices().getUsers(authers);
    loading.value = false;
  }
}
