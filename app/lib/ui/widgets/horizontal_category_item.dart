import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:app/global.dart';

class HorizontalCategoryItem extends StatelessWidget {
  final onTap;
  final active;
  final Category category;
  const HorizontalCategoryItem(
      {Key key, this.onTap, this.active, this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: active == category.id
                      ? MyColors.accentBlue
                      : MyColors.lightBlue,
                ),
                child: Image.network(
                  "${category.iconUrl}",
                  color: active == category.id ? Colors.black87 : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 3),
            Text(
              "${category.name}",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: active == category.id
                      ? MyColors.accentBlue
                      : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
