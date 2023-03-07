class PriceModel {

  String? owFrom;
  String? owTo;
  String? rtFrom;
  String? rtTo;

  PriceModel({
      this.owFrom, 
      this.owTo, 
      this.rtFrom, 
      this.rtTo,});

  PriceModel.fromJson(dynamic json) {
    owFrom = json['ow_from'];
    owTo = json['ow_to'];
    rtFrom = json['rt_from'];
    rtTo = json['rt_to'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ow_from'] = owFrom;
    map['ow_to'] = owTo;
    map['rt_from'] = rtFrom;
    map['rt_to'] = rtTo;
    return map;
  }

}