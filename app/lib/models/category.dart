import 'package:app/global.dart';

class Category {
  final String name, iconUrl;
  final int id;

  Category({this.id, this.name, this.iconUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      iconUrl: "$baseServerUrl${json['icon']['url']}",
      name: json['name'],
    );
  }
}
