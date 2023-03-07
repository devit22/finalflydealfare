import 'Data.dart';

class LoggedInUser {
  Data? data;
  String? error;
  String? status;
  LoggedInUser({
      this.data, 
      this.error, 
      this.status,});

  LoggedInUser.fromJson(dynamic json) {
    data = json['data'] ;
    error = json['error'];
    status = json['status'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['error'] = error;
    map['status'] = status;
    return map;
  }

}