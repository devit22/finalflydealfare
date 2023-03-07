class Country {
  final String? id;
  final String? name;
  final String? currency;

  Country({this.id, this.name, this.currency});

  static Country fromJson(Map<String, dynamic> json) =>
      Country(id: json['id'], name: json['name'], currency: json['currency']);
}
