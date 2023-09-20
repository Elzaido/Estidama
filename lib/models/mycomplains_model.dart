class ComplainsModel {
  String? complainDate;
  String? complainLocation;
  String? complainStatus;
  String? complainDescription;
  String? complainImagePath;
  String? complainId;
  String ?complain_accepetance_status;
  ComplainsModel(
      {this.complainDate,
      this.complainLocation,
      this.complainStatus,
      this.complainDescription,
      this.complainImagePath,
      this.complainId,
      this.complain_accepetance_status});

  ComplainsModel.fromJson(Map<String, dynamic> json) {
    // complainType = json['complain_type'];
    // complainerId = json['complainer_id'];
    complainDate = json['complain_date'];
    complainLocation = json['complain_location'];
    complainStatus = json['complain_status'];
    complainDescription = json['complain_description'];
    complainImagePath = json['complain_image_path'];
    complainId = json['complain_id'];
    complain_accepetance_status=json['complain_accepetance_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['complain_date'] = complainDate;
    data['complain_location'] = complainLocation;
    data['complain_status'] = complainStatus;
    data['complain_description'] = complainDescription;
    data['complain_image_path'] = complainImagePath;
    data['complain_id'] = complainId;
    data['complain_accepetance_status']=complain_accepetance_status;
    return data;
  }
}
