class Order {
  final String address, postalCode, city, paymentMethodId;
  final int amount;
  final Map<String, dynamic> product;

  Order({
    this.paymentMethodId,
    this.product,
    this.address,
    this.amount,
    this.postalCode,
    this.city,
  });

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

  OrderResponse({
    this.message,
    this.code,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json){
    return OrderResponse(
      message: json['message'],
      code: json['code'],
    );
  }
}
