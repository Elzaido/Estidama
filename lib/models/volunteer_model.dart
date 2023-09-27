class VolunteerModel {
  String? volunteeringType;
  String? volunteerSkills;
  String? volunteeringId;
  String? userId;
  String? volunteerGroupType;
  String? isVolunteeringAccepted;
  String? volunteersNames;

  VolunteerModel(
      {this.volunteeringType,
      this.volunteerSkills,
      this.volunteeringId,
      this.userId,
      this.volunteerGroupType,
      this.isVolunteeringAccepted,
      this.volunteersNames});

  VolunteerModel.fromJson(Map<String, dynamic> json) {
    volunteeringType = json['volunteering_type'];
    volunteerSkills = json['volunteer_skills'];
    volunteeringId = json['volunteering_id'];
    userId = json['user_id'];
    volunteerGroupType = json['volunteer_group_type'];

    isVolunteeringAccepted = json['is_voluteering_accepted'];
    volunteersNames = json['volunteers_names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteering_type'] = volunteeringType;
    data['volunteer_skills'] = volunteerSkills;
    data['volunteer_id'] = volunteeringId;
    data['user_id'] = userId;
    data['volunteer_group_type'] = volunteerGroupType;

    data['is_voluteering_accepted'] = isVolunteeringAccepted;
    data['volunteers_names'] = volunteersNames;
    return data;
  }
}
