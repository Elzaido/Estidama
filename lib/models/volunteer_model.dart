class VolunteerModel {
  String? volunteeringType;
  String? volunteerSkills;
  String? volunteering_id;
  String? userId;
  String? volunteerGroupType;

  String? is_voluteering_accepted;
  String? volunteers_names;
  VolunteerModel(
      {this.volunteeringType,
      this.volunteerSkills,
      this.volunteering_id,
      this.userId,
      this.volunteerGroupType,
      this.is_voluteering_accepted,
      this.volunteers_names});

  VolunteerModel.fromJson(Map<String, dynamic> json) {
    volunteeringType = json['volunteering_type'];
    volunteerSkills = json['volunteer_skills'];
    volunteering_id = json['volunteering_id'];
    userId = json['user_id'];
    volunteerGroupType = json['volunteer_group_type'];

    is_voluteering_accepted = json['is_voluteering_accepted'];
    volunteers_names = json['volunteers_names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteering_type'] = volunteeringType;
    data['volunteer_skills'] = volunteerSkills;
    data['volunteer_id'] = volunteering_id;
    data['user_id'] = userId;
    data['volunteer_group_type'] = volunteerGroupType;

    data['is_voluteering_accepted'] = is_voluteering_accepted;
    data['volunteers_names'] = volunteers_names;
    return data;
  }
}
