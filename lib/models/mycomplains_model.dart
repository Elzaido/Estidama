class ComplainsModel {
  String? complainDate;
  String? complainLocation;
  String? complainStatus;
  String? complainDescription;
  String? complainImagePath;
  String? complainId;

  ComplainsModel(
      {this.complainDate,
      this.complainLocation,
      this.complainStatus,
      this.complainDescription,
      this.complainImagePath,
      this.complainId});

  ComplainsModel.fromJson(Map<String, dynamic> json) {
    // complainType = json['complain_type'];
    // complainerId = json['complainer_id'];
    complainDate = json['complain_date'];
    complainLocation = json['complain_location'];
    complainStatus = json['complain_status'];
    complainDescription = json['complain_description'];
    complainImagePath = json['complain_image_path'];
    complainId = json['complain_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['complain_date'] = complainDate;
    data['complain_location'] = complainLocation;
    data['complain_status'] = complainStatus;
    data['complain_description'] = complainDescription;
    data['complain_image_path'] = complainImagePath;
    data['complain_id'] = complainId;
    return data;
  }
}
