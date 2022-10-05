class TransactionsModel {
  String id;
  String username;
  String userId;
  String chargeId;
  num amount;
  DateTime createdAt;
  String method;
  String status;
  String type;
  String walletId;
  String walletType;
  String bankName;

  TransactionsModel.fromJson(Map json, String docId)
      : id = docId,
        username = json['username'],
        userId = json['user_ref'],
        chargeId = json['charge_Id'],
        amount = json['amount'],
        createdAt = json['created_at'].toDate(),
        method = json['method'],
        status = json['status'],
        walletId = json['wallet_Id'] ?? "",
        walletType = json['wallet_type'] ?? "",
        bankName = json['bank_name'] ?? "",
        type = json['type'];
}
