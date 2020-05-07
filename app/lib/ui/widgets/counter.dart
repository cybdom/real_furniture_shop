import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final add, reduce;
  final int count;

  const Counter({Key key, this.add, this.reduce, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: add,
          child: Container(
            height: 41,
            width: 41,
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
            ),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 15.0),
        Container(
          height: 41,
          width: 71,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
          alignment: Alignment.center,
          child: Text("$count"),
        ),
        SizedBox(width: 15.0),
        GestureDetector(
          onTap: reduce,
          child: Container(
            height: 41,
            width: 41,
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
            ),
            child: Icon(
              Icons.remove,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
