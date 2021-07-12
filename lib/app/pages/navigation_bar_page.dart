import 'package:flower_recognizer/app/pages/history/history_page.dart';
import 'package:flower_recognizer/app/pages/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flower_recognizer/app/pages/recognizer/loading_image_page.dart';
import 'package:flutter/material.dart';

class NavigationBarPage extends StatefulWidget {
  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    LoadingImagePage(),
    HistoryPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: true,
            child: buildBottomNavigationBar()
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return CurvedNavigationBar(
      key: Key('bottomNavigationBar'),
      backgroundColor: Colors.green[50],
      items: [
        Icon(Icons.home, key: Key('homeLogo'),),
        Icon(Icons.camera_enhance, key: Key('cameraLogo'),),
        ImageIcon(AssetImage("assets/icon/icon-android.png"), key: Key('flowerLogo'),),
      ],
      onTap: _onItemTapped,
      buttonBackgroundColor: Colors.green[100],
      animationDuration: Duration(milliseconds: 200),
      height: 50,
    );
  }
}