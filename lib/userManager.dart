import 'package:voting_app/fireStore.dart';
import 'package:voting_app/user.dart';
import 'package:voting_app/userModel.dart';

class UserManager {
  static login(String userName, String password) async {
    FirestoreManager.instance.table = "user";
    var response = await FirestoreManager.instance.find((value) =>
        value["userName"] == userName && value["password"] == password);
    if (response != null) {
      User.self = UserModel.fromMap(response);
    }
  }

  static logout() async {
    User.self = null;
  }

  static register(String userName, String password) async {
    FirestoreManager.instance.table = "user";
    await FirestoreManager.instance
        .add(userName, {"userName": userName, "password": password});
    User.self = UserModel(userName);
  }
}
