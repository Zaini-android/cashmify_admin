import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<Query<Object?>> query = FirebaseFirestore.instance
      .collection("transactions")
      .orderBy("created_at", descending: true)
      .obs;

  RxInt selectedFilter = 0.obs;
  RxString selectedOrder = "Desc".obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    query.value = _firestore
        .collection("transactions")
        .orderBy("created_at", descending: selectedOrder.value == "Desc");
    super.onInit();
  }

  Future getTransactions() async {
    loading.value = true;
    query.value = _firestore
        .collection("transactions")
        .orderBy("created_at", descending: selectedOrder.value == "Desc");
    Future.delayed(const Duration(seconds: 1), () {
      loading.value = false;
    });
  }

  Future searchTransaction(String searchKey) async {
    loading.value = true;
    query.value = _firestore
        .collection("transactions")
        .where('username', isEqualTo: searchKey.isEmpty ? null : searchKey);
    Future.delayed(const Duration(seconds: 1), () {
      loading.value = false;
    });
  }
}
