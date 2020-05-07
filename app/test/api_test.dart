
import 'package:app/services/api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Api Test", () {
    test("Get Categories", () async {
      final response = await Api().getCategories();
      for (var category in response) {
        print(category.iconUrl);
      }
    });
    test("Get Products", () async {
      final response = await Api().getProducts();
      for (var product in response) {
        print(product.colors);
      }
    });
    test("Get Products by category", () async {
      final response = await Api().getProducts(categoryId: 1);
      for (var product in response) {
        print(product.colors);
      }
    });

    test("Get Single Product", () async {
      final response = await Api().getSingleProduct(productId: 1);
      print(response.colors);
    });

  });
}
