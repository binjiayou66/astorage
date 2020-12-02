import 'package:astorage/defines/acolors.dart';
import 'package:astorage/defines/afont.dart';
import 'package:astorage/defines/avariables.dart';
import 'package:astorage/pages/home/home_page.dart';
import 'package:astorage/pages/me/me_page.dart';
import 'package:astorage/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Widget> _pages;
  List<BottomNavigationBarItem> _itemList;
  int _currentIndex = 0;

  var _pageController = PageController(initialPage: 0);

  final items = [
    _Item(
        '首页',
        Icon(
          Icons.home_rounded,
          color: AColors.textMain,
        ),
        Icon(
          Icons.home_rounded,
          color: AColors.primary,
        )),
    _Item(
        '我的',
        Icon(
          Icons.account_circle,
          color: AColors.textMain,
        ),
        Icon(
          Icons.account_circle,
          color: AColors.primary,
        )),
  ];

  @override
  void initState() {
    super.initState();

    if (_pages == null) {
      _pages = [
        HomePage(),
        MePage(),
      ];
    }
    if (_itemList == null) {
      _itemList = items
          .map(
            (item) => BottomNavigationBarItem(
              icon: item.normalIcon,
              label: item.name,
              activeIcon: item.activeIcon,
            ),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: _onTap,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _getPagesWidget(index);
        },
        itemCount: _pages.length,
      ),
      backgroundColor: AColors.background,
      bottomNavigationBar: BottomNavigationBar(
        items: _itemList,
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
        iconSize: 24,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AColors.primary,
        selectedFontSize: AFontSize.sub1,
        unselectedFontSize: AFontSize.sub1,
      ),
    );
  }

  void _onTap(int index) async {
    switch (index) {
      case AVariables.homeIndex:
        {
          final homeProvider =
              Provider.of<HomeProvider>(context, listen: false);
          homeProvider.refresh();
          break;
        }
      case AVariables.meIndex:
        break;
      default:
    }
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getPagesWidget(int index) {
    return _pages[index];
  }
}

class _Item {
  String name;
  Icon activeIcon, normalIcon;

  _Item(this.name, this.normalIcon, this.activeIcon);
}
