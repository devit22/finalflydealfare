class States {
  final String? id;
  final String? name;
  final String? country_id;

  States({this.id, this.name, this.country_id});

  static States fromJson(Map<String, dynamic> json) => States(
      id: json['id'], name: json['name'], country_id: json['country_id']);
}
