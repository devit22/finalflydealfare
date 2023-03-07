import 'package:fly_deal_fare/models/output.dart';

class AirPorts {
  List<Output>? output;
  AirPorts({this.output});
  static AirPorts fromJson(Map<String, dynamic> json) => AirPorts(
        output: json['output'],
      );
}
