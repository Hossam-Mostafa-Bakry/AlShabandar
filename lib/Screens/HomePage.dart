import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Screens/Notifications.dart';
import 'package:mishwar/Screens/slmlmProvider.dart';
import 'package:mishwar/bottomBarWidgets.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dbHelper.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'Branches.dart';
import '../main.dart';
import 'Cart.dart';
import 'Favourite.dart';
import 'Offers.dart';
import 'mainPage.dart';

class HomePage extends StatefulWidget {
  static String UserId;
  final int index;

  HomePage({this.index});

  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  int _currentIndex = 0;
  List dataLocal = [];
  DbHelper db = new DbHelper();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  home h = new home();

  loadCartItems() async {
    dataLocal = await db.allProduct();
    setState(() {});
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      HomePage.UserId = prefs.getString("UserId");
    });
  }

  List<Widget> itemsUi = [
    MainPage(),
    Expanded(child: Offers()),
    Expanded(child: Cart()),
    Expanded(child: Favourite()),
  ];
  List<String> titles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedpage();
    loadData();
  }

  void selectedpage() {
    if (widget.index != null) {
      setState(() {
        _currentIndex = widget.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadCartItems();

    titles = [
      DemoLocalizations.of(context).title['main'],
      DemoLocalizations.of(context).title['Offers'],
      DemoLocalizations.of(context).title['cart'],
      DemoLocalizations.of(context).title['favorite'],
    ];
    //Observer
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        iconTheme: IconThemeData(size: 30, color: Colors.black),
        backgroundColor:Color(h.mainColor),
        centerTitle: true,
        title: Text(
          titles[_currentIndex],
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, GlobalFunction.routeBottom(Notifications()));
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle),
              padding: EdgeInsets.all(8),
              child: ImageIcon(
                AssetImage("images/icon/notification.png"),
                size: 22,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(6),
          child: InkWell(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Icon(
              Icons.menu,
              size: 24,
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [itemsUi[_currentIndex]],
        ),
      ),
      extendBody: false,
      bottomNavigationBar: CustomBottomBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        itemShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          CustomBottomBarItem(
              title: Text(
                DemoLocalizations.of(context).title['main'],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              icon: ImageIcon(
                AssetImage("images/icon/home.png"),
                size: 20,
              )),
          CustomBottomBarItem(
            title: Text(
              DemoLocalizations.of(context).title['Offers'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            icon: ImageIcon(
              AssetImage("images/offerIcon.png"),
              size: 22,
            ),
          ),
          CustomBottomBarItem(
            title: Text(
              DemoLocalizations.of(context).title['cart'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            icon: Container(
              child: Stack(
                alignment: Alignment(3, -18),
                children: [
                  Container(
                    child: ImageIcon(
                      AssetImage(
                        "images/icon/cart_bar.png",
                      ),
                      size: 22,
                    ),
                  ),
                  dataLocal.length == 0
                      ? SizedBox()
                      : Stack(
                          alignment: Alignment(0.1, -0.4),
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 8,
                            ),
                            Text(
                              // '${Provider.of<SlmlmProvider>(context, listen: false).cartItems.length}',
                              '${dataLocal.length}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          CustomBottomBarItem(
            title: Text(
              DemoLocalizations.of(context).title['favorite'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            icon: Icon(
              Icons.star_border,
              size: 24,
            ),
          ),
        ],
      ),

      /*BottomNavigationBar(
        elevation: 15.5,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        selectedFontSize: 12,
        unselectedItemColor: Colors.black45,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/icon/home.png"),
              size: 18,
            ),
            label: DemoLocalizations.of(context).title['main'],
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/offerIcon.png"),
              size: 18,
            ),
            label: DemoLocalizations.of(context).title['Offers'],
          ),
          BottomNavigationBarItem(
            icon: Container(
              child: Stack(
                alignment: Alignment(1.5, -6),
                children: [
                  Container(
                    child: ImageIcon(
                      AssetImage(
                        "images/icon/cart_bar.png",
                      ),
                      size: 20,
                    ),
                  ),
                  dataLocal.length == 0
                      ? SizedBox()
                      : Stack(
                          alignment: Alignment(0, -0.2),
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(h.mainColor),
                              radius: 6.1,
                            ),
                            Text(
                              // '${Provider.of<SlmlmProvider>(context, listen: false).cartItems.length}',
                              '${dataLocal.length}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            label: DemoLocalizations.of(context).title['cart'],
            // title: Text(
            //   DemoLocalizations.of(context).title['cart'],
            //   style: TextStyle(
            //     height: 1.75,
            //     fontSize: 10,
            //   ),
            // ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
              size: 24,
            ),
            label: DemoLocalizations.of(context).title['favorite'],
          ),
        ],
      ),*/
    );
  }
}
