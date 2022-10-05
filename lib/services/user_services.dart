import 'package:cashmify_admin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers(List userIds) async {
    List<UserModel> users = [];
    for (var userId in userIds) {
      var userDoc = await _firestore.collection('users').doc(userId).get();
      var user = UserModel.fromJson(userDoc.data() as Map, userDoc.id);
      users.add(user);
    }
    return users;
  }

  Future<List<UserModel>> getUsersWithLimit(List userIds, int limit) async {
    List<UserModel> users = [];
    int interval = 0;
    for (var userId in userIds) {
      var userDoc = await _firestore.collection('users').doc(userId).get();
      var user = UserModel.fromJson(userDoc.data() as Map, userDoc.id);
      users.add(user);
      if (interval == limit) {
        break;
      } else {
        interval++;
      }
    }
    return users;
  }

  Future getUser(String userId) async {
    if (userId.isNotEmpty) {
      var userDoc = await _firestore.collection('users').doc(userId).get();
      return UserModel.fromJson(userDoc.data()!, userDoc.id);
    }
  }
}
