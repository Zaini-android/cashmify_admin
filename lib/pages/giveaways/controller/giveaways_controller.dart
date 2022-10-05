import 'package:cashmify_admin/models/giveaway_model.dart';
import 'package:cashmify_admin/models/user_model.dart';
import 'package:cashmify_admin/services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GiveawayController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<Query<Object?>> query = FirebaseFirestore.instance
      .collection("giveaways")
      .orderBy("created_at", descending: true)
      .obs;

  RxInt selectedFilter = 0.obs;
  RxString selectedOrder = "Desc".obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    query.value = _firestore
        .collection("giveaways")
        .orderBy("timestamp", descending: selectedOrder.value == "Desc");
    getGiveaways();
    super.onInit();
  }

  Future getGiveaways() async {
    loading.value = true;
    query.value = _firestore
        .collection("giveaways")
        .orderBy("timestamp", descending: selectedOrder.value == "Desc");
    Future.delayed(const Duration(seconds: 1), () {
      loading.value = false;
    });
  }

  Future<GiveawayModel> getGiveawayUser(Map data, String docId) async {
    UserModel user = await UserServices().getUser(data['auther']);
    return GiveawayModel.normal(data, docId, user);
  }
}
