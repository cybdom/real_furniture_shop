import 'package:app/global.dart';

class Category {
  final String name, iconUrl;
  final int id;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      iconUrl: "$baseServerUrl${json['icon']['url']}",
      name: json['name'],
    );
  }

  Category({required this.name, required this.iconUrl, required this.id});
}
