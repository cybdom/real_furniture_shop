import 'package:app/services/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Auth Test", () {
    test("login", () async {
      final response =
          await AuthService().login(username: "cybdom", password: "password");
      print(response);
    });
    test("signup", () async {
      final response = await AuthService().signup(
        password: "password",
        email: "client@gmail.com",
        username: "client",
      );
      print(response);
    });
  });
}
