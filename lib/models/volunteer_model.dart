class VolunteerModel {
  // String? isAccepted;
  String? volunteeringType;
  String? volunteerSkills;
  String? volunteerId;
  String? userId;
  String? volunteerGroupType;
  String? is_voluteering_accepted;
  VolunteerModel(
      {this.volunteeringType,
      this.volunteerSkills,
      this.volunteerId,
      this.userId,
      this.volunteerGroupType,
      this.is_voluteering_accepted});

  VolunteerModel.fromJson(Map<String, dynamic> json) {
    volunteeringType = json['volunteering_type'];
    volunteerSkills = json['volunteer_skills'];
    volunteerId = json['volunteer_id'];
    userId = json['user_id'];
    volunteerGroupType = json['volunteer_group_type'];
    is_voluteering_accepted = json['is_voluteering_accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteering_type'] = volunteeringType;
    data['volunteer_skills'] = volunteerSkills;
    data['volunteer_id'] = volunteerId;
    data['user_id'] = userId;
    data['volunteer_group_type'] = volunteerGroupType;
    data['is_voluteering_accepted'] = is_voluteering_accepted;
    return data;
  }
}
