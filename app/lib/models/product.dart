import 'package:app/global.dart';

class Product {
  final int id;
  final double price, rating;
  final String name, description, material, image;
  List<dynamic> colors;

  Product({
    this.id,
    this.price,
    this.rating,
    this.name,
    this.description,
    this.material,
    this.image,
    this.colors,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      colors: json['colors']['colors'],
      description: json['description'],
      id: json['id'],
      image: "$baseServerUrl${json['image']['url']}",
      material: json['material'],
      name: json['name'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'rating': rating,
        'name': name,
        'description': description,
        'material': material,
        'image': image,
        'colors': colors,
      };
}
