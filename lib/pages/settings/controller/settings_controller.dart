import 'dart:developer';

import 'package:cashmify_admin/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as d;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SettingsController extends GetxController {
  final TextEditingController top_10_percentController =
      TextEditingController();
  final TextEditingController top_3_percentController = TextEditingController();
  final TextEditingController ban_duationController = TextEditingController();
  final TextEditingController withdrawalFeeController = TextEditingController();
  final TextEditingController bonusController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController joinDuraionController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String settingDocId = "EmOs8NZqA0BhOYlGiYdR";

  RxBool loading = false.obs;
  RxBool loading1 = false.obs;
  RxBool loading2 = false.obs;
  RxBool loading3 = false.obs;
  RxBool loading4 = false.obs;
  RxBool loading5 = false.obs;
  RxBool loading6 = false.obs;
  RxBool loading7 = false.obs;
  RxBool loading8 = false.obs;
  RxBool loading9 = false.obs;
  RxBool loading10 = false.obs;

  RxString country = "Nigeria".obs;
  RxString countryCode = "NG".obs;

  RxList countries = [].obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentSettings();
  }

  getCurrentSettings() async {
    var settings = await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .get();
    var data = settings.data();

    top_10_percentController.text = data!['top_10'].toString();
    top_3_percentController.text = data['top_2'].toString();
    ban_duationController.text = data['ban_duration'].toString();
    withdrawalFeeController.text = data['cashout_fee'].toString();
    bonusController.text = data['signup_bonus_amount'].toString();
    countries.value = data['signup_bonus'];
    rateController.text = data['converstion_rate'].toString();
    joinDuraionController.text = data['join_duration'].toString();
  }

  updateWinnerPercentage() async {
    loading.value = true;
    var top_10 = num.parse(top_10_percentController.text);
    var top_3 = num.parse(top_3_percentController.text);

    await _firestore.collection('giveaway_settings').doc(settingDocId).update({
      'top_10': top_10,
      'top_2': top_3,
    });
    loading.value = false;
  }

  updateBanDuration() async {
    loading1.value = true;
    var ban_duration = num.parse(ban_duationController.text);

    await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .update({'ban_duration': ban_duration});
    loading1.value = false;
  }

  updateCashoutFee() async {
    loading2.value = true;
    var cashout_fee = num.parse(withdrawalFeeController.text);

    await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .update({'cashout_fee': cashout_fee});
    loading2.value = false;
  }

  addNewCountry() async {
    loading3.value = true;
    Map<String, dynamic> data = {
      "signup_bonus": FieldValue.arrayUnion([
        {"country": country.value, "country_code": countryCode.value}
      ]),
    };
    await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .update(data);
    countries
        .add({"country": country.value, "country_code": countryCode.value});
    loading3.value = false;
  }

  removeCountry(Map<String, dynamic> item) async {
    Map<String, dynamic> data = {
      "signup_bonus": FieldValue.arrayRemove([item]),
    };
    await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .update(data);
    countries.remove(item);
  }

  saveBonusAmt() async {
    loading4.value = true;
    var bonus = num.parse(bonusController.text);
    Map<String, dynamic> data = {"signup_bonus_amount": bonus};
    await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .update(data);
    loading4.value = false;
  }

  downloadAllEmail() async {
    loading5.value = true;

    String text = 'Email                          Username\n';

    var result = await _firestore.collection('users').get();
    for (var item in result.docs) {
      var data = item.data();
      text = text + "\n${data["email"]}          " + "${data['username']}";
    }

    final bytes = utf8.encode(text);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'some_name.txt';
    html.document.body?.children.add(anchor);

    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    loading5.value = false;
  }

  download2WeekEmail() async {
    loading6.value = true;

    String text = 'Email                          Username\n';

    DateTime todaysDate = DateTime.now();
    DateTime twoWeeksAgo =
        DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day - 12);

    var result = await _firestore
        .collection('users')
        .where('today_timestamp', isEqualTo: twoWeeksAgo)
        .get();
    for (var item in result.docs) {
      var data = item.data();
      text = text + "\n${data["email"]}          " + "${data['username']}";
    }

    final bytes = utf8.encode(text);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'emails.txt';
    html.document.body?.children.add(anchor);

    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    loading6.value = false;
  }

  updateConverstionRate() async {
    loading7.value = true;
    var rate = num.parse(rateController.text);

    await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .update({'converstion_rate': rate});
    loading7.value = false;
  }

  sendAllUserNotification() async {
    loading8.value = true;
    var result = await _firestore.collection('users').get();
    for (var doc in result.docs) {
      var data = doc.data();
      String? deviceId = data['device_token'];
      if (deviceId != null && deviceId.isNotEmpty) {
        await sendNotification(deviceId);
      }
    }
    loading8.value = false;
  }

  Future sendNotification(String deviceToken) async {
    var body = {
      "token": deviceToken,
      "msg": bodyController.text,
      "title": titleController.text,
    };
    await http.post(Uri.parse("$apiEndpoint/sendNotification"), body: body);
  }

  updateJoinDuration() async {
    loading9.value = true;
    var joinDuration = num.parse(joinDuraionController.text);

    await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .update({'join_duration': joinDuration});
    loading9.value = false;
  }
}
