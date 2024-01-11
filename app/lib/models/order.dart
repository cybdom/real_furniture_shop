class Order {
  final String address, postalCode, city, paymentMethodId;
  final int amount;
  final Map<String, dynamic> product;

  Order(
      {required this.address,
      required this.postalCode,
      required this.city,
      required this.paymentMethodId,
      required this.amount,
      required this.product});

  Map<String, dynamic> toJson() => {
        'paymentMethodId': paymentMethodId,
        'address': address,
        'amount': amount,
        'postalCode': postalCode,
        'city': city,
        'product': product,
      };
}

class OrderResponse {
  final String message;
  final int code;

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      message: json['message'],
      code: json['code'],
    );
  }

  OrderResponse({required this.message, required this.code});
}
