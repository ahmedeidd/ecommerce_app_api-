import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/URL/constants.dart';
import 'package:flutter_ecommerce_app/models/brand_model.dart';
import 'package:flutter_ecommerce_app/widgets/circular_progress.dart';
import 'package:flutter_ecommerce_app/widgets/grid_tiles_category.dart';
import 'package:http/http.dart';

BrandModel brandModel;
class BrandHomePage extends StatefulWidget
{
  String slug;
  bool isSubList;
  BrandHomePage({Key key, this.slug, this.isSubList=false}) : super(key: key);
  @override
  _BrandHomePageState createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<BrandHomePage>
{
  void initState()
  {
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      future: getCategoryList(widget.slug,widget.isSubList),
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
              return createListView(context, snapshot);
        }
      },
    );
  }
}
//******************************************************************************
// start get category list
Future<BrandModel> getCategoryList(String slug, bool isSubList) async
{
  if(brandModel == null)
  {
    Response response = await get(Url.ROOT_URL + slug);
    int statusCode = response.statusCode;
    var body = json.decode(response.body);
    log('${body}');
    if (statusCode == 200)
    {
      brandModel = BrandModel.fromJson(body);
      return brandModel;
    }
  }
  else
  {
    return brandModel;
  }
}
// end get category list
//******************************************************************************
// start create ListView
Widget createListView(BuildContext context, AsyncSnapshot snapshot)
{
  BrandModel values = snapshot.data;
  List<Results> results = values.results;
  return GridView.count(
    crossAxisCount: 3,
    padding: EdgeInsets.all(1.0),
    childAspectRatio: 8.0 / 9.0,
    children: List<Widget>.generate(results.length, (index)
    {
      return GridTile(
          child: GridTilesCategory(
            name: results[index].name,
            imageUrl: results[index].imageUrl,
            slug: results[index].slug,
          ),
      );
    }),
  );
}
// end create ListView
//******************************************************************************
