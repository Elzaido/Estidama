class UserDataModel {
  String? status;
  Data? data;

  UserDataModel({this.status, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
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

  Data(
      {this.userName,
      this.userNumber,
      this.userProvince,
      this.userJoinDate,
      this.userGender,
      this.userPassword,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userNumber = json['user_number'];
    userProvince = json['user_province'];
    userJoinDate = json['user_join_date'];
    userGender = json['user_gender'];
    userPassword = json['user_password'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_number'] = this.userNumber;
    data['user_province'] = this.userProvince;
    data['user_join_date'] = this.userJoinDate;
    data['user_gender'] = this.userGender;
    data['user_password'] = this.userPassword;
    data['user_id'] = this.userId;
    return data;
  }
}