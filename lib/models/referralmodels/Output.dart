class Output {

  String? id;
  String? userId;
  String? depcity;
  String? descity;
  String? depdate;
  String? email;
  String? mobile;
  String? name;
  String? status;
  String? dated;


  Output({
      this.id, 
      this.userId, 
      this.depcity, 
      this.descity, 
      this.depdate, 
      this.email, 
      this.mobile, 
      this.name, 
      this.status, 
      this.dated,});

  Output.fromJson(dynamic json) {
    id = json['id'];
    userId = json['UserId'];
    depcity = json['depcity'];
    descity = json['descity'];
    depdate = json['depdate'];
    email = json['email'];
    mobile = json['mobile'];
    name = json['name'];
    status = json['status'];
    dated = json['dated'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['UserId'] = userId;
    map['depcity'] = depcity;
    map['descity'] = descity;
    map['depdate'] = depdate;
    map['email'] = email;
    map['mobile'] = mobile;
    map['name'] = name;
    map['status'] = status;
    map['dated'] = dated;
    return map;
  }

}