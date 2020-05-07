import 'package:app/models/product.dart';
import 'package:app/ui/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:app/global.dart';

class ProductsPageView extends StatefulWidget {
  final List<Product> products;
  const ProductsPageView({
    Key key,
    this.products,
  }) : super(key: key);

  @override
  _ProductsPageViewState createState() => _ProductsPageViewState();
}

class _ProductsPageViewState extends State<ProductsPageView> {
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            itemCount: widget.products.length,
            controller: PageController(viewportFraction: .75),
            onPageChanged: (value) {
              setState(() {
                _active = value;
              });
            },
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    product: widget.products[i],
                  ),
                ),
              ),
              child: FractionallySizedBox(
                heightFactor: _active == i ? 1 : .75,
                child: Container(
                  margin: const EdgeInsets.all(11),
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: MyColors.lightBlue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          Text(
                            "${widget.products[i].rating}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Colors.white),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.favorite_border,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Image.network("${widget.products[i].image}"),
                        ),
                      ),
                      Text(
                        "${widget.products[i].name}",
                        style: Theme.of(context)
                            .textTheme
                        .headline6
                            .copyWith(color: Colors.white70),
                      ),
                      Text(
                        "${widget.products[i].price}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.products.length,
              (f) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                height: 3,
                width: _active == f ? 11 : 5,
                decoration: BoxDecoration(
                  shape: _active == f ? BoxShape.rectangle : BoxShape.circle,
                  color: Colors.white,
                  borderRadius: _active == f ? BorderRadius.circular(3) : null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
