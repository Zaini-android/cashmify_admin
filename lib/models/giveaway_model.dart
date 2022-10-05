import 'package:cashmify_admin/models/user_model.dart';

class GiveawayModel {
  String id;
  UserModel? auther;
  num amount;
  bool isGlobal;
  int maxParticpant;
  List<UserModel> particpants;
  List particpantsIds;
  List<UserModel> elimenatedParticpants;
  List elimenatedParticpantsIds;
  String status;
  List<UserModel> top10;
  List top10Ids;
  List<UserModel> top3;
  List top3Ids;
  UserModel? winner;
  num top10Amount;
  num top3Amount;
  num winnerAmount;
  String countryCode;
  bool isRestricted;
  String code;
  DateTime timestamp;
  GiveawayModel(
    this.id,
    this.amount,
    this.auther,
    this.isGlobal,
    this.maxParticpant,
    this.particpants,
    this.elimenatedParticpants,
    this.elimenatedParticpantsIds,
    this.particpantsIds,
    this.status,
    this.top10,
    this.top10Ids,
    this.top3,
    this.top3Ids,
    this.winner,
    this.top10Amount,
    this.top3Amount,
    this.winnerAmount,
    this.countryCode,
    this.code,
    this.timestamp,
    this.isRestricted,
  );

  GiveawayModel.fromJson(
    Map json,
    String docId,
    UserModel? autherUser,
    List<UserModel> participantsModel,
    List<UserModel> elimenatedParticipantsModel,
    List<UserModel> top10Model,
    List<UserModel> top3Model,
    UserModel? winnerModel,
  )   : id = docId,
        auther = autherUser,
        amount = json['amount'],
        isGlobal = json['is_global'],
        maxParticpant = json['max_participants'],
        particpants = participantsModel,
        elimenatedParticpants = elimenatedParticipantsModel,
        elimenatedParticpantsIds = json['elminated_participants'] ?? [],
        particpantsIds = json['participants'],
        status = json['status'],
        top10 = top10Model,
        top10Ids = json['top_10'],
        top3Ids = json['top_3'],
        top3 = top3Model,
        winner = winnerModel,
        countryCode = json['country_code'],
        top10Amount = json['top10_amount'] ?? 0,
        winnerAmount = json['winner_amount'] ?? 0,
        isRestricted = json['is_restricted'],
        code = json['entry_code'],
        timestamp = json['timestamp'].toDate(),
        top3Amount = json['top3_amount'] ?? 0;

  GiveawayModel.normal(Map json, String docId, UserModel? user)
      : id = docId,
        auther = user,
        amount = json['amount'],
        isGlobal = json['is_global'],
        maxParticpant = json['max_participants'],
        particpantsIds = json['participants'],
        status = json['status'],
        countryCode = json['country_code'],
        isRestricted = json['is_restricted'],
        code = json['entry_code'],
        particpants = [],
        elimenatedParticpants = [],
        elimenatedParticpantsIds = [],
        top10 = [],
        top3 = [],
        top10Ids = json['top_10'],
        top3Ids = [],
        top10Amount = json['top10_amount'] ?? 0,
        winnerAmount = json['winner_amount'] ?? 0,
        timestamp = json['timestamp'].toDate(),
        top3Amount = json['top3_amount'] ?? 0;
}
