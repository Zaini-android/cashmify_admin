import 'package:cashmify_admin/models/giveaway_model.dart';
import 'package:cashmify_admin/models/user_model.dart';
import 'package:cashmify_admin/services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WinnerDialogController extends GetxController {
  GiveawayModel model;

  WinnerDialogController(this.model);

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
    users.value = await UserServices().getUsers(model.top10Ids);
    loading.value = false;
  }
}
