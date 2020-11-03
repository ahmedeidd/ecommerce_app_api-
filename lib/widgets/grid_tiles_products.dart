import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/pages/product_detail_screen_EID.dart';
class GridTilesProducts extends StatelessWidget
{
  String name;
  String imageUrl;
  String slug;
  String price;
  bool fromSubProducts = false;
  GridTilesProducts(
      {Key key,
        @required this.name,
        @required this.imageUrl,
        @required this.slug,
        @required this.price,
        this.fromSubProducts})
      : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: ()
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              slug: "products/" + slug + "/",
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 5),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Center(
            child: Column(
              children:
              [
                Image.network(
                  imageUrl,
                  width: 150,
                  height: 150,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Text(
                    (name.length <= 40 ? name : name.substring(0, 40)),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontFamily: 'Roboto-Light.ttf',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Text(
                    "৳  ${(price != null) ? price : 'Unavailable'}",
                    style: TextStyle(
                      color: (price != null) ? Color(0xFFf67426) : Color(0xFF0dc2cd),
                      fontFamily: 'Roboto-Light.ttf',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
