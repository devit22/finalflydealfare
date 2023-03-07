class BlogList {
  String? title;
  String? image;
  String? link;

  BlogList({
      this.title, 
      this.image, 
      this.link,});

  BlogList.fromJson(dynamic json) {
    title = json['title'];
    image = json['image'];
    link = json['link'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['image'] = image;
    map['link'] = link;
    return map;
  }

}