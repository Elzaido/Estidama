class RecyclingModel {
  String? orderId;
  String? materialType;
  String? materialWeight;
  String? materialImg;
  String? materialLocation;
  String? recyclerId;
  String? orderDate;
  String? recyclingcAcepetanceStatus;

  RecyclingModel(
      {this.orderId,
      this.materialType,
      this.materialWeight,
      this.materialImg,
      this.materialLocation,
      this.recyclerId,
      this.orderDate,
      this.recyclingcAcepetanceStatus});

  RecyclingModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    materialType = json['material_type'];
    materialWeight = json['material_weight'];
    materialImg = json['material_img'];
    materialLocation = json['material_location'];
    recyclerId = json['recycler_id'];
    orderDate = json['order_date'];
    recyclingcAcepetanceStatus = json['recycling_accepetance_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['material_type'] = materialType;
    data['material_weight'] = materialWeight;
    data['material_img'] = materialImg;
    data['material_location'] = materialLocation;
    data['recycler_id'] = recyclerId;
    data['order_date'] = orderDate;
    data['recycling_accepetance_status'] = recyclingcAcepetanceStatus;
    return data;
  }
}
