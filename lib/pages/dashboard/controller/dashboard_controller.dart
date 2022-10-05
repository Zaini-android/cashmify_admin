import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String settingDocId = "EmOs8NZqA0BhOYlGiYdR";

  RxDouble allDeposit = 0.0.obs;
  RxDouble allCashout = 0.0.obs;
  RxDouble allEarning = 0.0.obs;
  RxDouble allTransfer = 0.0.obs;
  RxDouble allUsers = 0.0.obs;
  RxDouble activeGiveaways = 0.0.obs;
  RxDouble activeGiveawayAmount = 0.0.obs;
  RxDouble pendingRequests = 0.0.obs;
  RxDouble allCharityWalletAmount = 0.0.obs;
  RxDouble allEarningWalletAmount = 0.0.obs;
  RxDouble allBonusAmount = 0.0.obs;
  RxDouble verifiedPeopleAmount = 0.0.obs;
  RxList<String> verifiedAuthers = <String>[].obs;
  RxDouble todaysOnlineCount = 0.0.obs;
  RxDouble yesterdayOnlineCount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCount();
  }

  getCount() async {
    // All Deposit
    var allDeopsitTransactionsResult = await _firestore
        .collection("transactions")
        .where('type', isEqualTo: "Deposit")
        .where('status', isEqualTo: "Completed")
        .get();
    for (var item in allDeopsitTransactionsResult.docs) {
      var data = item.data();
      allDeposit.value += data['amount'];
    }

    // All Cashout
    var allCashoutTransactionsResult = await _firestore
        .collection("transactions")
        .where('type', isEqualTo: "Withdraw")
        .where('status', isEqualTo: "Completed")
        .get();
    for (var item in allCashoutTransactionsResult.docs) {
      var data = item.data();
      allCashout.value += data['amount'];
    }

    // All Earning
    var allUsersEarningResult = await _firestore.collection("users").get();
    allUsers.value = allUsersEarningResult.docs.length.toDouble();
    for (var item in allUsersEarningResult.docs) {
      var data = item.data();
      allEarning.value += data['total_earning'];
    }

    // Charity Wallet Amount // Earning Wallet Amount
    for (var item in allUsersEarningResult.docs) {
      var data = item.data();
      allCharityWalletAmount.value += data['wallet_balance'];
      allEarningWalletAmount.value += data['earning_balance'];
    }

    // All Transfer
    var allTransferTransactionsResult = await _firestore
        .collection("transactions")
        .where('type', isEqualTo: "Transfer")
        .where('status', isEqualTo: "Completed")
        .get();
    for (var item in allTransferTransactionsResult.docs) {
      var data = item.data();
      allTransfer.value += data['amount'];
    }

    // Active Giveaways
    var allActiveGivawaysResult = await _firestore
        .collection("giveaways")
        .where('status', isEqualTo: "waiting")
        .get();
    activeGiveaways.value = allActiveGivawaysResult.docs.length.toDouble();

    // All Active Giveaways Amount
    for (var item in allActiveGivawaysResult.docs) {
      var data = item.data();
      activeGiveawayAmount.value += data['amount'];
    }

    // All Cashout
    var allPendingRequestTransactionsResult = await _firestore
        .collection("transactions")
        .where('type', isEqualTo: "Withdraw")
        .where('status', isEqualTo: "Pending")
        .get();
    pendingRequests.value =
        allPendingRequestTransactionsResult.docs.length.toDouble();

    // All Bonus Amount
    var allBonusAmountResult = await _firestore
        .collection("users")
        .where('is_collected', isEqualTo: true)
        .get();
    var settings = await _firestore
        .collection('giveaway_settings')
        .doc(settingDocId)
        .get();
    var data = settings.data();
    var amt = data!['signup_bonus_amount'];
    allBonusAmount.value = (allBonusAmountResult.docs.length * amt).toDouble();

    // Verified People Amount
    var verifiedPeopleGivawaysResult = await _firestore
        .collection("giveaways")
        .where('for_verified', isEqualTo: true)
        .get();
    for (var item in verifiedPeopleGivawaysResult.docs) {
      var data = item.data();
      verifiedPeopleAmount.value += data['amount'];
      verifiedAuthers.add(data['auther']);
    }

    // Today Online Count
    DateTime now = DateTime.now();
    var todayOnilineResult = await _firestore
        .collection("users")
        .where('todays_date', isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
        .get();
    todaysOnlineCount.value = todayOnilineResult.docs.length.toDouble();

    // Yesterday Online Count
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    var yesterdayOnilineResult = await _firestore
        .collection("users")
        .where('todays_date',
            isLessThanOrEqualTo: DateTime(yesterday.year, yesterday.month, yesterday.day))
        .get();
    yesterdayOnlineCount.value = yesterdayOnilineResult.docs.length.toDouble();
  }
}
