import 'Output.dart';

class ReferralUsers {
  List<Output>? output;
  ReferralUsers({ this.output,});

  ReferralUsers.fromJson(dynamic json) {
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