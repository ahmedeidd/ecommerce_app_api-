import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/components/app_sign_in.dart';
import 'package:flutter_ecommerce_app/main.dart';
import 'package:flutter_ecommerce_app/pages/wish_list_page_EID.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class DrawerWidget extends StatefulWidget
{
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:
          [
            _createDrawerHeader(),
            _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            _createDrawerItem(
              icon: FontAwesomeIcons.user,
              text: 'Sign In',
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppSignIn()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.favorite_border,
              text: 'Wish List',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishListPage()),
              ),
            ),
            _createDrawerItem(
              icon: Icons.call,
              text: 'Contact Us',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmptyWishListScreen()
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//******************************************************************************
// srart create drawer header
Widget _createDrawerHeader()
{
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: Stack(
      children:
      [
        Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child:Text(
              "EID",
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Roboto-Light.ttf',
                fontSize: 50,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
// end create drawer header
//******************************************************************************
// srart create drawer item
Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap})
{
  return ListTile(
    title: Row(
      children:
      [
        Icon(
          icon,
          color: Colors.orange,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
// end create drawer item
//******************************************************************************
