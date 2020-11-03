import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/pages/home_page_EID.dart';
import 'package:flutter_ecommerce_app/pages/shopping_cart_page_EID.dart';
import 'package:flutter_ecommerce_app/pages/wish_list_page_EID.dart';
import 'package:flutter_ecommerce_app/widgets/app_bar_widget.dart';
import 'package:flutter_ecommerce_app/widgets/bottom_navbar_widget.dart';
import 'package:flutter_ecommerce_app/widgets/drawer_widget.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
//******************************************************************************
int currentIndex = 0;
void navigateToScreens(int index)
{
  currentIndex = index;
}
// *****************************************************************************
class MyHomePage extends StatefulWidget
{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  final List<Widget> viewContainer =
  [
    HomePage(),
    WishListPage(),
    ShoppingCartPage(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(context),
        drawer: DrawerWidget(),
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
//******************************************************************************



