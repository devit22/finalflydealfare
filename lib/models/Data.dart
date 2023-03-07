class Data {

  String? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? username;
  String? password;
  String? pass_value;
  String? dated;
  String? last_login;
  String? source;




  Data({
      this.id, 
      this.name, 
      this.email, 
      this.mobile, 
      this.address, 
      this.username, 
      this.password, 
      this.pass_value,
      this.dated, 
      this.last_login,
      this.source,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    username = json['username'];
    password = json['password'];
    pass_value = json['pass_value'];
    dated = json['dated'];
    last_login = json['last_login'];
    source = json['source'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['address'] = address;
    map['username'] = username;
    map['password'] = password;
    map['pass_value'] = pass_value;
    map['dated'] = dated;
    map['last_login'] = last_login;
    map['source'] = source;
    return map;
  }

}