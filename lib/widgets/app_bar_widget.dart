import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/components/app_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
Widget appBarWidget(context)
{
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      "EID",
      style: TextStyle(
        color: Colors.orange,
        fontFamily: 'Roboto-Light.ttf',
        fontSize: 40,
      ),
    ),
    actions:
    [
      IconButton(
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AppSignIn()),);
        },
        icon: Icon(FontAwesomeIcons.user),
        color: Colors.orange
      ),
    ],
  );
}