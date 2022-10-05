import 'package:cashmify_admin/const.dart';
import 'package:cashmify_admin/models/transaction_model.dart';
import 'package:cashmify_admin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RequestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<Query<Object?>> query = FirebaseFirestore.instance
      .collection("transactions")
      .where('status', isEqualTo: "Pending")
      .where('type', isEqualTo: "Withdraw")
      .orderBy("created_at", descending: true)
      .obs;

  RxInt selectedFilter = 0.obs;
  RxString selectedOrder = "Desc".obs;

  RxBool loading = false.obs;
  RxBool loading1 = false.obs;

  @override
  void onInit() {
    query.value = FirebaseFirestore.instance
        .collection("transactions")
        .where('status', isEqualTo: "Pending")
        .where('type', isEqualTo: "Withdraw")
        .orderBy("created_at", descending: selectedOrder.value == "Desc");
    super.onInit();
  }

  Future getTransactions() async {
    loading.value = true;
    query.value = FirebaseFirestore.instance
        .collection("transactions")
        .where('status', isEqualTo: "Pending")
        .where('type', isEqualTo: "Withdraw")
        .orderBy("created_at", descending: selectedOrder.value == "Desc");
    Future.delayed(const Duration(seconds: 1), () {
      loading.value = false;
    });
  }

  Future approve(TransactionsModel model) async {
    loading1.value = true;
    await _firestore
        .collection("transactions")
        .doc(model.id)
        .update({'status': 'Completed'});

    await _firestore
        .collection("users")
        .doc(model.userId)
        .collection('transaction_history')
        .doc(model.id)
        .update({'status': 'Completed'});
    await sendNotification(model.userId,
        "Your withdraw request has been approved", "Withdrawal Successfull");
    loading1.value = false;
    Get.back();
  }

  Future reject(TransactionsModel model) async {
    loading1.value = true;
    await _firestore
        .collection("transactions")
        .doc(model.id)
        .update({'status': 'Canceled'});

    await _firestore
        .collection("users")
        .doc(model.userId)
        .collection('transaction_history')
        .doc(model.id)
        .update({'status': 'Canceled'});

    await _firestore
        .collection("users")
        .doc(model.userId)
        .update({'earning_balance': FieldValue.increment(model.amount)});
    await sendNotification(model.userId,
        "Your withdraw request has been rejected", "Withdraw Failed");
    loading1.value = false;
    Get.back();
  }

  Future sendNotification(String userId, String msg, String title) async {
    var user = await _firestore.collection('users').doc(userId).get();
    var data = user.data();
    UserModel model = UserModel.fromJson(data as Map, user.id);
    var body = {
      "token": model.deviceToken,
      "msg": msg,
      "title": title,
    };
    await http.post(Uri.parse("$apiEndpoint/sendNotification"), body: body);
  }
}
