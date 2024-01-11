import 'package:app/models/order.dart';
import 'package:flutter/material.dart';

import '../../global.dart';

class OrderResultDialog extends StatelessWidget {
  final OrderResponse orderResponse;
  final bool success;

  const OrderResultDialog(
      {super.key, required this.orderResponse, required this.success});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MyColors.darkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  success ? "Order Successful" : "Order Failed",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            SizedBox(height: 11),
            Text(
              orderResponse.message,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 11),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text("Done"),
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: MyColors.accentBlue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
