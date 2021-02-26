import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movitronia/Utils/Colors.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      imgList.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Get.back()),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Polera Movitronia",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              // CarouselSlider(
              //     options: CarouselOptions(),
              //     items: imgList
              //         .map((item) => Center(
              //               child: Image.network(item,
              //                   width: MediaQuery.of(context).size.width * 0.7),
              //             ))
              //         .toList()),
              Center(
                child: Hero(
                    tag: "image",
                    child: Image.network(
                      "https://www.gustore.cl/temp/img/poleras/poleraNaranja_800x859.png",
                      width: MediaQuery.of(context).size.width * 0.7,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ),
                    Text(
                      "7.990",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                endIndent: 24,
                indent: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  sizes("S", Colors.cyan),
                  sizes("M", Colors.cyan),
                  sizes("L", Colors.cyan),
                  sizes("XL", Colors.cyan),
                ],
              ),
              Divider(
                color: Colors.white,
                endIndent: 24,
                indent: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget sizes(String text, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

List imgList = [
  'https://www.gustore.cl/temp/img/poleras/poleraNaranja_800x859.png',
  'https://www.gustore.cl/temp/img/poleras/poleraNaranja_800x859.png',
  'https://www.gustore.cl/temp/img/poleras/poleraNaranja_800x859.png',
  'https://www.gustore.cl/temp/img/poleras/poleraNaranja_800x859.png',
  'https://www.gustore.cl/temp/img/poleras/poleraNaranja_800x859.png'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Color.fromARGB(200, 0, 0, 0),
                          //     Color.fromARGB(0, 0, 0, 0)
                          //   ],
                          //   begin: Alignment.bottomCenter,
                          //   end: Alignment.topCenter,
                          // ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
