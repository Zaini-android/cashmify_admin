class UserModel {
  String userId;
  String username;
  String firstname;
  String lastname;
  String about;
  String picurl;
  String email;
  String country;
  String countryCode;
  String phone;
  num earningBalance;
  num walletBalance;
  num diamondBalance;
  num totalGaveaway;
  num totalEarned;
  num earnedToday;
  bool notifications;
  bool sound;
  bool isRewarded;
  int rank;
  DateTime? nextAd;
  List specialPeople;
  List beneficiary;
  String deviceToken;
  bool signup_bonus;
  DateTime timestamp;

  UserModel(
    this.firstname,
    this.lastname,
    this.picurl,
    this.email,
    this.userId,
    this.username,
    this.about,
    this.country,
    this.countryCode,
    this.phone,
    this.earningBalance,
    this.walletBalance,
    this.diamondBalance,
    this.totalEarned,
    this.totalGaveaway,
    this.earnedToday,
    this.notifications,
    this.sound,
    this.isRewarded,
    this.rank,
    this.nextAd,
    this.specialPeople,
    this.beneficiary,
    this.deviceToken,
    this.signup_bonus,
    this.timestamp,
  );

  UserModel.fromJson(Map json, String id)
      : userId = id,
        username = json['username'],
        // TODO: remove this
        firstname = json['firstname'] ?? "test",
        lastname = json['lastname'] ?? "user",
        phone = json['phone'],
        about = json['about'],
        picurl = json['image'],
        country = json['country'],
        countryCode = json['country_code'] ?? "NG",
        earningBalance = json['earning_balance'],
        walletBalance = json['wallet_balance'],
        diamondBalance = json['diamond_balance'] ?? 0,
        totalGaveaway = json['total_gaveaway'] ?? 0,
        totalEarned = json['total_earning'] ?? 0,
        earnedToday = json['today_earning'] ?? 0,
        rank = json['rank'] ?? 0,
        notifications = json['notification'] ?? true,
        isRewarded = json['rewarded'] ?? false,
        sound = json['sound'] ?? true,
        specialPeople = json['special_people'] ?? [],
        beneficiary = json['beneficiary'] ?? [],
        deviceToken = json['device_token'] ?? "",
        timestamp = json['timestamp'].toDate(),
        signup_bonus = json['signup_bonus'] ?? false,
        nextAd = json['next_Ad'] != null
            ? (json['next_Ad']).toDate()
            : DateTime.now(),
        email = json['email'];
}
