class VolunteerModel {
  String? volunteeringType;
  String? volunteerSkills;
  String? volunteerId;
  String? userId;
  String? volunteerGroupType;
  String? isVoluteeringAccepted;
  VolunteerModel(
      {this.volunteeringType,
      this.volunteerSkills,
      this.volunteerId,
      this.userId,
      this.volunteerGroupType,
      this.isVoluteeringAccepted});

  VolunteerModel.fromJson(Map<String, dynamic> json) {
    volunteeringType = json['volunteering_type'];
    volunteerSkills = json['volunteer_skills'];
    volunteerId = json['volunteer_id'];
    userId = json['user_id'];
    volunteerGroupType = json['volunteer_group_type'];
    isVoluteeringAccepted = json['is_voluteering_accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteering_type'] = volunteeringType;
    data['volunteer_skills'] = volunteerSkills;
    data['volunteer_id'] = volunteerId;
    data['user_id'] = userId;
    data['volunteer_group_type'] = volunteerGroupType;
    data['is_voluteering_accepted'] = isVoluteeringAccepted;
    return data;
  }
}
