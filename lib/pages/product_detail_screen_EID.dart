import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/URL/constants.dart';
import 'package:flutter_ecommerce_app/models/product_details_model.dart';
import 'package:flutter_ecommerce_app/widgets/app_bar_widget.dart';
import 'package:flutter_ecommerce_app/widgets/circular_progress.dart';
import 'package:http/http.dart';

ProductDetails productDetails;
class ProductDetailScreen extends StatefulWidget
{
  String slug;
  ProductDetailScreen({Key key, @required this.slug}) : super(key: key);
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      appBar: appBarWidget(context),
      body: FutureBuilder(
        future: getDetailData(widget.slug),
        builder: (context, AsyncSnapshot snapshot)
        {
          switch (snapshot.connectionState)
          {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgress();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return createDetailView(context, snapshot);
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
//******************************************************************************
// start get detail data
Future<ProductDetails> getDetailData(String slug) async
{
  Response response= await get(Url.ROOT_URL + slug);
  int statusCode = response.statusCode;
  final body = json.decode(response.body);
  if (statusCode == 200)
  {
    productDetails = ProductDetails.fromJson(body);
    return productDetails;
  } else {
    return productDetails = ProductDetails();
  }
}
// end get detail data
//******************************************************************************
// staaaart create detail view
Widget createDetailView(BuildContext context, AsyncSnapshot snapshot)
{
  ProductDetails values = snapshot.data;
  return DetailScreen(
    productDetails: values,
  );
}
// endddddddd create detail view
// *****************************
// start Detail Screen
class DetailScreen extends StatefulWidget
{
  ProductDetails productDetails;
  DetailScreen({Key key, this.productDetails}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Column(
        children:
        [
          Image.network(
            widget.productDetails.data.productVariants[0].productImages[0],
            fit: BoxFit.fill,
            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress)
            {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null ?
                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Text(
                  "SKU".toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF565656),
                  ),
                ),
                Text(
                  widget.productDetails.data.productVariants[0].sku,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF999999),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Text(
                  'Price'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF565656),
                  ),
                ),
                Text(
                  "৳ ${(widget.productDetails.data.productVariants[0].maxPrice != null) ? widget.productDetails.data.productVariants[0].maxPrice
                      : "Unavailable"}".toUpperCase(),
                  style: TextStyle(
                    color: (widget.productDetails.data.productVariants[0].maxPrice != null) ? Color(0xFFf67426) : Color(0xFF0dc2cd),
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF565656),
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  "${widget.productDetails.data.productVariants[0].productDescription}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4c4c4c),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  "Specification",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF565656),
                  ),
                ),
                SizedBox(height: 15,),
                Column(
                  children: generateProductSpecification(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //*******************************************
  // start generate Product Specification
  List<Widget> generateProductSpecification(BuildContext context)
  {
    List<Widget> list = [];
    int count = 0;
    widget.productDetails.data.productSpecifications.forEach((specification)
    {
      Widget element = Container(
        height: 30,
        child: Row(
          children:
          [
            Text(
              specification.specificationName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF444444),
              ),
            ),
            Text(
              specification.specificationValue,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
      );
      list.add(element);
      count++;
    });
    return list;
  }
  // end generate Product Specification
  //*******************************************
}
// end Detail Screen
//******************************************************************************

// start create Bottom NavBar
class BottomNavBar extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        children:
        [
          Icon(
            Icons.favorite_border,
            color: Color(0xFF5e5e5e),
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              side: BorderSide(color: Color(0xFFfef2f2)),
            ),
            onPressed: () {},
            color: Color(0xFFfef2f2),
            textColor: Colors.white,
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Text(
                "Add to cart".toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              side: BorderSide(color: Colors.orange),
            ),
            onPressed: () {},
            color: Colors.orange,
            textColor: Colors.white,
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Text(
                "available at shops".toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// end create Bottom NavBar

