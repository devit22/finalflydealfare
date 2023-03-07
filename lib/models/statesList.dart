import 'package:fly_deal_fare/models/States.dart';

class StateList {
  List<States>? output;

  StateList({this.output});

  static StateList fromJson(Map<String, dynamic> json) => StateList(
        output: json['output'],
      );
}
