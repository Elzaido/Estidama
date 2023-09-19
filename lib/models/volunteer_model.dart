class VolunteerModel {
  String? isAccepted;
  String? volunteeringType;
  String? volunteerSkills;
  String? volunteerId;
  String? userId;
  String? volunteerGroupType;

  VolunteerModel(
      {this.isAccepted,
      this.volunteeringType,
      this.volunteerSkills,
      this.volunteerId,
      this.userId,
      this.volunteerGroupType});

  VolunteerModel.fromJson(Map<String, dynamic> json) {
    isAccepted = json['is_accepted'];
    volunteeringType = json['volunteering_type'];
    volunteerSkills = json['volunteer_skills'];
    volunteerId = json['volunteer_id'];
    userId = json['user_id'];
    volunteerGroupType = json['volunteer_group_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_accepted'] = isAccepted;
    data['volunteering_type'] = volunteeringType;
    data['volunteer_skills'] = volunteerSkills;
    data['volunteer_id'] = volunteerId;
    data['user_id'] = userId;
    data['volunteer_group_type'] = volunteerGroupType;
    return data;
  }
}
