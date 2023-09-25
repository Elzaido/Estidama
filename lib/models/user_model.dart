class UserDataModel {
  String? status;
  Data? data;

  UserDataModel({this.status, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userName;
  String? userNumber;
  int? userProvince;
  String? userJoinDate;
  String? userGender;
  String? userPassword;
  int? userId;
  String? user_token;
  Data(
      {this.userName,
      this.userNumber,
      this.userProvince,
      this.userJoinDate,
      this.userGender,
      this.userPassword,
      this.userId,
      this.user_token});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userNumber = json['user_number'];
    userProvince = json['user_province'];
    userJoinDate = json['user_join_date'];
    userGender = json['user_gender'];
    userPassword = json['user_password'];
    userId = json['user_id'];
    user_token=json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['user_number'] = userNumber;
    data['user_province'] = userProvince;
    data['user_join_date'] = userJoinDate;
    data['user_gender'] = userGender;
    data['user_password'] = userPassword;
    data['user_id'] = userId;
    data['user_token']=user_token;
    return data;
  }
}
