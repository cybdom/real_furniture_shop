import 'dart:convert';

import 'package:app/global.dart';
import 'package:app/models/order.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  late OrderResponse _response;
  OrderResponse get response => _response;
  Future<bool> purchase({required Order order, required String token}) async {
    final request = await http.post(
      Uri.http(baseServerUrl, '/orders'),
      body: jsonEncode(order.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': "Bearer $token",
      },
    );
    if (request.statusCode == 200) {
      _response = OrderResponse.fromJson(json.decode(request.body));
      return true;
    } else {
      print(jsonDecode(request.body));
      return false;
    }
  }
}
