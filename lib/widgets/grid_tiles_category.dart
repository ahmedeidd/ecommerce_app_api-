import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/pages/products_screen_EID.dart';
import 'package:flutter_ecommerce_app/pages/sub_category_screen_EID.dart';
class GridTilesCategory extends StatelessWidget
{
  String name;
  String imageUrl;
  String slug;
  bool fromSubProducts = false;
  GridTilesCategory({Key key, @required this.name, @required this.imageUrl, @required this.slug, this.fromSubProducts}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: ()
      {
        if(fromSubProducts)
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                slug: "products/?page=1&limit=12&category=" + slug,
                name: name,
              ),
            ),
          );
        }
        else
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubCategoryScreen(slug: slug,),
            ),
          );
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Center(
          child: Column(
            children:
            [
              Image.network(
                imageUrl,
                width: 80,
                height: 70,
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

