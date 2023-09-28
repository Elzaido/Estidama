class VolunteerModel {
  String? volunteeringType;
  String? volunteerSkills;
  String? volunteeringId;
  String? leader_id;
  String? volunteerGroupType;
  String? is_volunteering_accepted;
  String? volunteersNames;
//volunteersNames
  VolunteerModel(
      {this.volunteeringType,
      this.volunteerSkills,
      this.volunteeringId,
      this.leader_id,
      this.volunteerGroupType,
      this.is_volunteering_accepted,
      this.volunteersNames});

  VolunteerModel.fromJson(Map<String, dynamic> json) {
    volunteeringType = json['volunteering_type'];
    volunteerSkills = json['volunteer_skills'];
    volunteeringId = json['volunteering_id'];
    leader_id = json['leader_id'];
    volunteerGroupType = json['volunteer_group_type'];

    is_volunteering_accepted = json['is_volunteering_accepted'];
    volunteersNames = json['volunteers_names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteering_type'] = volunteeringType;
    data['volunteer_skills'] = volunteerSkills;
    data['volunteer_id'] = volunteeringId;
    data['leader_id'] = leader_id;
    data['volunteer_group_type'] = volunteerGroupType;

    data['is_volunteering_accepted'] = is_volunteering_accepted;
    data['volunteers_names'] = volunteersNames;
    return data;
  }
}
