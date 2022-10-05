import 'package:cashmify_admin/models/transaction_model.dart';
import 'package:cashmify_admin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransactionDialogController extends GetxController {
  UserModel model;

  TransactionDialogController(this.model);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool loading = false.obs;

  RxList<TransactionsModel> users = <TransactionsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getWinnerUsers();
  }

  getWinnerUsers() async {
    loading.value = true;
    var result = await _firestore
        .collection('users')
        .doc(model.userId)
        .collection('transaction_history')
        .orderBy('created_at')
        .get();
    users.value = result.docs
        .map((e) => TransactionsModel.fromJson(e.data(), e.id))
        .toList();
    loading.value = false;
  }
}
