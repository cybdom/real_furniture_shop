import 'package:flutter/material.dart';
import 'package:app/global.dart';

class RotatedCategoryList extends StatefulWidget {
  const RotatedCategoryList({
    Key key,
  }) : super(key: key);

  @override
  _RotatedCategoryListState createState() => _RotatedCategoryListState();
}

class _RotatedCategoryListState extends State<RotatedCategoryList> {
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, i) => RotatedBox(
        quarterTurns: -1,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _active = i;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 9),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: _active == i
                  ? LinearGradient(colors: [
                      MyColors.accentBlue.withOpacity(.3),
                      Colors.transparent
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                  : null,
            ),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Popular",
                  style: TextStyle(
                    color:
                        _active == i ? MyColors.accentBlue : Colors.grey[200],
                  ),
                ),
                if (_active == i)
                  Container(
                    width: 15,
                    height: 3,
                    color: MyColors.accentBlue,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
