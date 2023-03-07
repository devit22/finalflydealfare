import 'Output.dart';

class LogInDataWithUserId {
  List<Output>? output;

  LogInDataWithUserId({
      this.output,});

  LogInDataWithUserId.fromJson(dynamic json) {
    if (json['output'] != null) {
      output = [];
      json['output'].forEach((v) {
        output!.add(Output.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (output != null) {
      map['output'] = output!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}