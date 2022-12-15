import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/bloc/bottom_view_navigation_bar.dart';
import 'package:newsapp/screens/tabs/categories_screen.dart';
import 'package:newsapp/screens/tabs/home_screen.dart';
import 'package:newsapp/screens/tabs/search_screen.dart';
import 'package:newsapp/styles/theme.dart' as style;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: style.Colors.mainColor,
          title: const Text("NewsApp", style: TextStyle(
              color: Colors.white
          ),),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return const HomeScreen();
              case NavBarItem.CATEGORIES:
                return const CategoriesScreen();
              case NavBarItem.SEARCH:
                return const SearchScreen();
              default:
                return Container();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: style.Colors.grey,
                unselectedFontSize: 10.5,
                selectedFontSize: 11,
                type: BottomNavigationBarType.fixed,
                fixedColor: style.Colors.mainColor,
                currentIndex: snapshot.data!.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: const [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon:  Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Icon(EvaIcons.homeOutline),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Icon(EvaIcons.home),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Categories",
                    icon:  Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Icon(EvaIcons.gridOutline),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Icon(EvaIcons.grid),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Search",
                    icon:  Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Icon(EvaIcons.searchOutline),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Icon(EvaIcons.search),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
