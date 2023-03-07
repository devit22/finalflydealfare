class ReturnRespons {

  String? result;
  ReturnRespons({
      required this.result,});

  ReturnRespons.fromJson(dynamic json) {
    result = json['result'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = result;
    return map;
  }

}