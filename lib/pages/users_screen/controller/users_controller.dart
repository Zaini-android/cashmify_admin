import 'dart:developer';

import 'package:cashmify_admin/const.dart';
import 'package:cashmify_admin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart' as d;

class UsersController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController amountController = TextEditingController();

  Rx<Query<Object?>> query = FirebaseFirestore.instance
      .collection('users')
      .orderBy("timestamp", descending: true)
      .obs;

  RxInt selectedFilter = 0.obs;
  RxString selectedOrder = "Desc".obs;

  RxBool loading = false.obs;
  RxBool loading1 = false.obs;

  @override
  void onInit() {
    query.value = _firestore
        .collection('users')
        .orderBy("timestamp", descending: selectedOrder.value == "Desc");
    super.onInit();
  }

  Future refreshPage() async {
    loading.value = true;
    query.value = _firestore
        .collection('users')
        .orderBy("timestamp", descending: selectedOrder.value == "Desc");
    Future.delayed(const Duration(seconds: 1), () {
      loading.value = false;
    });
  }

  Future searchUsers(String searchKey) async {
    loading.value = true;
    if (searchKey.isEmpty) {
      query.value = _firestore
          .collection('users')
          .orderBy("timestamp", descending: selectedOrder.value == "Desc");
    } else {
      query.value = _firestore
          .collection("users")
          .where('search_query', arrayContains: searchKey);
    }
    Future.delayed(const Duration(seconds: 1), () {
      loading.value = false;
    });
  }

  Future updateUser(UserModel model) async {
    Map<String, dynamic> data = {
      "firstname": model.firstname,
      "lastname": model.lastname,
      "username": model.username,
      "email": model.email,
      "phone": model.phone,
      "about": model.about,
    };
    await _firestore.collection("users").doc(model.userId).update(data);
  }

  Future deleteUser(String id) async {
    await _firestore.collection("users").doc(id).delete();
    await deleteUserFirebase(id);
  }

  Future depositWallet(UserModel userModel) async {
    num? amount = num.tryParse(amountController.text);
    if (amount != null) {
      Map<String, dynamic> data = {
        "wallet_balance": FieldValue.increment(amount)
      };
      await _firestore.collection("users").doc(userModel.userId).update(data);
      await createTransaction(
          amt: amount, usermodel: userModel, type: "Deposit");
      await sendNotification(userModel,
          "\$$amount successfully added to charity wallet", "Deposit Success");
    }
    amountController.clear();
  }

  Future withdrawWallet(UserModel userModel) async {
    num? amount = num.tryParse(amountController.text);
    if (amount != null) {
      Map<String, dynamic> data = {
        "wallet_balance": FieldValue.increment(-amount)
      };
      await _firestore.collection("users").doc(userModel.userId).update(data);
      await createTransaction(
          amt: amount, usermodel: userModel, type: "Withdraw");
      await sendNotification(
          userModel,
          "\$$amount successfully withdraw from charity wallet",
          "Withdraw Success");
    }
    amountController.clear();
  }

  Future depositEarning(UserModel userModel) async {
    num? amount = num.tryParse(amountController.text);
    if (amount != null) {
      Map<String, dynamic> data = {
        "earning_balance": FieldValue.increment(amount)
      };
      await _firestore.collection("users").doc(userModel.userId).update(data);
      await createTransaction(
          amt: amount, usermodel: userModel, type: "Deposit");
      await sendNotification(userModel,
          "\$$amount successfully added to earning wallet", "Deposit Success");
    }
    amountController.clear();
  }

  Future withdrawEarning(UserModel userModel) async {
    num? amount = num.tryParse(amountController.text);
    if (amount != null) {
      Map<String, dynamic> data = {
        "earning_balance": FieldValue.increment(-amount)
      };
      await _firestore.collection("users").doc(userModel.userId).update(data);
      await createTransaction(
          amt: amount, usermodel: userModel, type: "Withdraw");
      await sendNotification(
          userModel,
          "\$$amount successfully withdraw from earning wallet",
          "Withdraw Success");
    }
    amountController.clear();
  }

  Future createTransaction(
      {required num amt,
      required UserModel usermodel,
      required String type}) async {
    var data = {
      "amount": amt,
      "charge_Id": "",
      "confirmed_at": FieldValue.serverTimestamp(),
      "created_at": FieldValue.serverTimestamp(),
      "status": "Completed",
      "user_email": usermodel.email,
      "username": usermodel.username,
      "method": "ADMIN",
      "type": type,
      "wallet_Id": "",
      'wallet_type': "",
      "user_ref": usermodel.userId,
    };

    // create initial transaction doc in database
    var docRef = await _firestore.collection('transactions').add(data);

    // add doc to user history
    await _firestore
        .collection('users')
        .doc(usermodel.userId)
        .collection('transaction_history')
        .doc(docRef.id)
        .set(data);
  }

  Future sendNotification(UserModel model, String msg, String title) async {
    var body = {
      "token": model.deviceToken,
      "msg": msg,
      "title": title,
    };
    await http.post(Uri.parse("$apiEndpoint/sendNotification"), body: body);
  }

  Future deleteUserFirebase(String id) async {
    var body = {"id": id};
    await http.post(Uri.parse("$apiEndpoint/delete/user"), body: body);
  }

  uploadVideo(UserModel user) async {
    loading1.value = true;
    final picker = ImagePicker();
    var pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      String videoUrl = await uploadVideoToAWS(pickedFile);
      await createBeneficiary(videoUrl, user);
      Get.back();
    }
    loading1.value = false;
  }

  Future uploadVideoToAWS(XFile videoFile) async {
    String? downloadURL;
    String randomName = const Uuid().v4();
    try {
      var dio = d.Dio();
      var formData = d.FormData.fromMap(
        {
          "file": d.MultipartFile.fromBytes(await videoFile.readAsBytes(),
              filename: "$randomName.mp4")
        },
      );

      Map<String, dynamic> headers = {
        "Authorization": "Bearer BEkWxgQcXe3NbV02zyhnA95xJiemhjWTJH13pEMX"
      };
      var response = await dio.post(
        cloudflareVideoEndpoint,
        data: formData,
        options: d.Options(headers: headers),
      );
      var json = response.data as Map;
      downloadURL = json['result']['playback']["dash"];
    } catch (e) {
      inspect(e);
    }
    return downloadURL;
  }

  Future createBeneficiary(String videoUrl, UserModel usermodel) async {
    num amt = num.parse(amountController.text);
    var data = {
      "amount": amt,
      "country_code": usermodel.countryCode,
      "first_name": usermodel.firstname,
      "username": usermodel.username,
      "video": videoUrl,
      "image": usermodel.picurl,
      "user_Id": usermodel.userId,
      "timestamp": FieldValue.serverTimestamp(),
    };

    var result = await _firestore.collection('beneficiary').add(data);
    await _firestore.collection('users').doc(usermodel.userId).update({
      "beneficiary": FieldValue.arrayUnion([result.id]),
    });
  }
}
