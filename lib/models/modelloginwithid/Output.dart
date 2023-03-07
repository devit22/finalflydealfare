class Output {

  String? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? username;
  String? password;
  String? passValue;
  String? dated;
  String? lastLogin;
  String? source;

  Output({
      this.id, 
      this.name, 
      this.email, 
      this.mobile, 
      this.address, 
      this.username, 
      this.password, 
      this.passValue, 
      this.dated, 
      this.lastLogin, 
      this.source,});

  Output.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    username = json['username'];
    password = json['password'];
    passValue = json['pass_value'];
    dated = json['dated'];
    lastLogin = json['last_login'];
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
    map['pass_value'] = passValue;
    map['dated'] = dated;
    map['last_login'] = lastLogin;
    map['source'] = source;
    return map;
  }

}