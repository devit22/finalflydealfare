import 'package:fly_deal_fare/models/Country.dart';

class Countries {
  List<Country>? output;

  Countries({this.output});

  static Countries fromJson(Map<String, dynamic> json) => Countries(
        output: json['output'],
      );
}
