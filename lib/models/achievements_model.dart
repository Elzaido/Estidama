class AchievementModel {
  String? id;
  String? achievementImg;
  String? achievementDescription;
  String? achievementTitle;

  AchievementModel(
      {this.id,
      this.achievementImg,
      this.achievementDescription,
      this.achievementTitle});

  AchievementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    achievementImg = json['achievement_img'];
    achievementDescription = json['achievement_description'];
    achievementTitle = json['achievement_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['achievement_img'] = this.achievementImg;
    data['achievement_description'] = this.achievementDescription;
    data['achievement_title'] = this.achievementTitle;
    return data;
  }
}