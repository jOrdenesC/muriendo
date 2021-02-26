import 'package:flutter/material.dart';
import 'package:movitronia/Design/All/Shop/productPage.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  Orientation orientation;
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: GridView.count(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              crossAxisCount: 1,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1000),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return ProductPage();
                        },
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return Align(
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: "image",
                      child: Image.network(
                          "https://www.gustore.cl/temp/img/poleras/poleraNaranja_800x859.png"),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ],
    );
  }
}
