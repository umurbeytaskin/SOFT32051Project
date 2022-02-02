class UserModel {
  String userName;
  UserModel(this.userName);

  factory UserModel.fromMap(m) {
    return UserModel(m["userName"]);
  }

  toMap() {
    return {"userName": this.userName};
  }
}
