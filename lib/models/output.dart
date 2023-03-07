class Output {
  final String? name;
  final String? code;

  Output({this.name, this.code});

  static Output fromJson(Map<String, dynamic> json) => Output(
        name: json['name'],
        code: json['code'],
      );
}
