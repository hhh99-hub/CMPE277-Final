import 'package:flutter/material.dart';
import 'package:flutter_travel_concept/screens/chat_screen.dart';
import 'package:flutter_travel_concept/screens/home.dart';
import 'package:flutter_travel_concept/screens/translate_service_screen.dart';
import 'package:flutter_travel_concept/screens/vision_service_screen.dart';
import 'package:flutter_travel_concept/widgets/icon_badge.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          Home(),              // Home screen
          FormScreen(),        // Chat screen
          TranslateServiceScreen(),
          VisionServiceScreen(),
          // Add other screens as necessary
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7.0),
            barIcon(icon: Icons.home, page: 0),
            barIcon(icon: Icons.chat_bubble, page: 1),
            barIcon(icon: Icons.translate_outlined, page: 2),
            barIcon(icon: Icons.flip, page: 3),
            SizedBox(width: 7.0),
          ],
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  Widget barIcon(
      {IconData icon = Icons.home, int page = 0, bool badge = false}) {
    return IconButton(
      icon: badge ? IconBadge(icon: icon, size: 24.0,color: Colors.black26,key: Key("barIcon")) : Icon(icon, size: 24.0),
      color:
          _page == page ? Theme.of(context).primaryColorDark : Colors.blueGrey[300],
      onPressed: () => _pageController.jumpToPage(page),
    );
  }
}
