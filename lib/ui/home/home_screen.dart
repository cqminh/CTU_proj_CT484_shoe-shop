import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myproject_app/models/product.dart';
import 'package:myproject_app/shared/bottom_nav_bar.dart';
import 'package:myproject_app/ui/products/product_grid.dart';
import 'package:myproject_app/ui/products/product_info.dart';
import 'package:myproject_app/ui/products/product_search.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../products/products_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'assets/images/banner-1.jpg',
    'assets/images/banner-2.jpg',
    'assets/images/banner-3.jpg',
    
  ];
  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(color: Color(0xFFEDECF2)),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Bạn muốn tìm sản phẩm?",
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Xin hãy nhập giá trị.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        Navigator.of(context).pushNamed(ProductSearch.routeName,
                            arguments: value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 15, left: 10),
              child: Text(
                "Khuyến mãi",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff242f60),
                ),
              ),
            ),

            CarouselSlider(
              items: imageList.map((url) {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.asset(url, fit: BoxFit.cover, width: 1000.0),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                initialPage: 0,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: true,
                scrollDirection: Axis.horizontal,
              ),
            ),

            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Sản phẩm mới",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff242f60)),
              ),
            ),
            Consumer<ProductsManager>(
                builder: (context, productsManager, child) {
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                itemCount: showProduct(productsManager.itemCount),
                itemBuilder: (ctx, i) => ProductInfo(productsManager.items[i]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              );
            })
          ],
        ));
  }

  //Ham hien thi so luong trang chu
  int showProduct(i) {
    if (i > 6)
      return 6;
    else
      return i;
  }
}
