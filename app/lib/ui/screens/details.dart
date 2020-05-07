import 'package:app/global.dart';
import 'package:app/models/order.dart';
import 'package:app/models/product.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/order_api.dart';
import 'package:app/ui/widgets/color_selector.dart';
import 'package:app/ui/widgets/counter.dart';
import 'package:app/ui/widgets/order_result_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _amount = 1;
  int _activeColorId = 0;

  @override
  void initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "YOUR STRIP KEY",
        merchantId: "Test",
        androidPayMode: 'test'));

    print(Provider.of<AuthService>(context, listen: false).token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "${widget.product.name}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        "${widget.product.rating}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 11),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Price",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white70),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "${widget.product.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 9),
                            Text(
                              "Color Variant",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white70),
                            ),
                            SizedBox(height: 3),
                            ColorSelector(
                              colors: widget.product.colors,
                              onTap: (value) {
                                setState(() {
                                  _activeColorId = value;
                                });
                              },
                              active: _activeColorId,
                            ),
                            SizedBox(height: 9),
                            Text(
                              "Material",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white70),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "${widget.product.material}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        flex: 2,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height / 3,
                          ),
                          child: Image.network(
                            "${widget.product.image}",
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 11),
                  Text(
                    "About Chair",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white70),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${widget.product.description}",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 11),
                  Text(
                    "Quantity",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white70),
                  ),
                  SizedBox(height: 11),
                  Counter(
                    count: _amount,
                    reduce: () {
                      if (_amount > 1)
                        setState(() {
                          _amount -= 1;
                        });
                    },
                    add: () {
                      setState(() {
                        _amount += 1;
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: RaisedButton(
                color: MyColors.accentBlue,
                child: Text(
                  "Buy Now",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: () async {
                  widget.product.colors = [
                    widget.product.colors[_activeColorId]
                  ];
                  OrderApi _orderApi = OrderApi();
                  try {
                    final _paymentMethod =
                        await StripePayment.paymentRequestWithCardForm(
                      CardFormPaymentRequest(),
                    );
                    final _order = Order(
                      paymentMethodId: _paymentMethod.id,
                      address: "My awesome new address",
                      amount: _amount,
                      city: "My City",
                      postalCode: "21345",
                      product: widget.product.toJson(),
                    );

                    final _purchaseRequest = await _orderApi.purchase(
                        order: _order,
                        token: Provider.of<AuthService>(context, listen: false)
                            .token);

                    showDialog(
                      context: context,
                      builder: (context) => OrderResultDialog(
                        orderResponse: _orderApi.response,
                        success: _purchaseRequest,
                      ),
                    );
                  } catch (e) {
                    print(e.message);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
