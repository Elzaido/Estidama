class RecyclingModel {
  String? orderId;
  String? materialType;
  String? materialWeight;
  String? materialImg;
  String? materialLocation;
  String? recyclerId;
  String? orderDate;
  String ?recycling_accepetance_status;

  RecyclingModel(
      {this.orderId,
      this.materialType,
      this.materialWeight,
      this.materialImg,
      this.materialLocation,
      this.recyclerId,
      this.orderDate,
      this.recycling_accepetance_status});

  RecyclingModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    materialType = json['material_type'];
    materialWeight = json['material_weight'];
    materialImg = json['material_img'];
    materialLocation = json['material_location'];
    recyclerId = json['recycler_id'];
    orderDate = json['order_date'];
    recycling_accepetance_status=json['recycling_accepetance_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['material_type'] = this.materialType;
    data['material_weight'] = this.materialWeight;
    data['material_img'] = this.materialImg;
    data['material_location'] = this.materialLocation;
    data['recycler_id'] = this.recyclerId;
    data['order_date'] = this.orderDate;
    data['recycling_accepetance_status']=this.recycling_accepetance_status;
    return data;
  }
}