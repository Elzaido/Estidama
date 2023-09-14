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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['complain_type'] = this.complainType;
    // data['complainer_id'] = this.complainerId;
    data['complain_date'] = this.complainDate;
    data['complain_location'] = this.complainLocation;
    data['complain_status'] = this.complainStatus;
    data['complain_description'] = this.complainDescription;
    data['complain_image_path'] = this.complainImagePath;
    data['complain_id'] = this.complainId;
    return data;
  }
}
