class RegisterResponse {
  String? data;
  String? error;
  String? status;
  String? UserId;
  RegisterResponse({
      this.data, 
      this.error, 
      this.status,
      this.UserId
  });

  RegisterResponse.fromJson(dynamic json) {
    data = json['data'];
    error = json['error'];
    status = json['status'];
    UserId = json['UserId'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['error'] = error;
    map['status'] = status;
    map['UserId'] = UserId;
    return map;
  }

}