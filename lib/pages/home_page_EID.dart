import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/pages/brand_home_page_EID.dart';
import 'package:flutter_ecommerce_app/pages/category_page_EID.dart';
import 'package:flutter_ecommerce_app/pages/shop_home_page_EID.dart';
import 'package:flutter_ecommerce_app/widgets/popular_menu.dart';
import 'package:flutter_ecommerce_app/widgets/search_widget.dart';
import 'package:flutter_ecommerce_app/widgets/top_promo_slider.dart';
class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Column(
        children:
        [
          SearchWidget(),
          TopPromoSlider(),
          //PopularMenu(),
          SizedBox(
            height: 5,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: TabBar(
              labelColor: Colors.black,
              tabs:
              [
                Tab(text: 'Categories',),
                Tab(text: 'Brands',),
                Tab(text: 'Shops',),
              ], // list of tabs
            ),
          ),
          SizedBox(
            height: 5,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          Expanded(
            child: TabBarView(
              children:
              [
                Container(
                  color: Colors.white24,
                  child: CategoryPage(slug: 'categories/'),
                ),
                Container(
                  color: Colors.white24,
                  child: BrandHomePage(slug: 'brands/?limit=20&page=1'),
                ),
                Container(
                  color: Colors.white24,
                  child: ShopHomePage(
                    slug: 'custom/shops/?page=1&limit=15',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
