import 'package:app/global.dart';
import 'package:app/models/category.dart';
import 'package:app/models/product.dart';
import 'package:app/services/api.dart';
import 'package:app/services/auth.dart';
import 'package:app/ui/widgets/horizontal_category_item.dart';
import 'package:app/ui/widgets/products_page_view.dart';
import 'package:app/ui/widgets/rotated_category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _getProducts, _getCategories;
  int _activeCategory = 0;

  @override
  void initState() {
    _getCategories = Api().getCategories();
    _getProducts = Api().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                onTap: () async {
                  await Provider.of<AuthService>(context, listen: false).logout();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                title: Text("Logout"),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: MyColors.darkBlue,
          selectedIconTheme: IconThemeData(color: MyColors.accentBlue),
          unselectedIconTheme: IconThemeData(color: Colors.grey[200]),
          elevation: 0,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Container(
                width: 9,
                height: 3,
                decoration: BoxDecoration(
                  color: MyColors.accentBlue,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Container(
                width: 9,
                height: 3,
                decoration: BoxDecoration(
                  color: MyColors.accentBlue,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Container(
                width: 9,
                height: 3,
                decoration: BoxDecoration(
                  color: MyColors.accentBlue,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Container(
                width: 9,
                height: 3,
                decoration: BoxDecoration(
                  color: MyColors.accentBlue,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.lightBlue,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: "Search",
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Let's find your favorite furniture",
                      style: Theme.of(context)
                          .textTheme
                        .headline5
                          .copyWith(color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 9),
                      height: 65,
                      child: FutureBuilder<List<Category>>(
                        future: _getCategories,
                        builder: (context, snapshot) {
                          switch (snapshot.hasData) {
                            case true:
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) =>
                                    HorizontalCategoryItem(
                                  active: _activeCategory,
                                  category: snapshot.data[i],
                                  onTap: () {
                                    setState(() {
                                      _activeCategory = snapshot.data[i].id;
                                    });
                                    _getProducts = Api().getProducts(
                                        categoryId: snapshot.data[i].id);
                                  },
                                ),
                              );
                              break;
                            default:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 51,
                      child: RotatedCategoryList(),
                    ),
                    Expanded(
                      child: FutureBuilder<List<Product>>(
                        future: _getProducts,
                        builder: (context, snapshot) {
                          switch (snapshot.hasData) {
                            case true:
                              return ProductsPageView(
                                products: snapshot.data,
                              );

                              break;
                            default:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
