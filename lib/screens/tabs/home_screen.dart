import 'package:flutter/material.dart';
import 'package:newsapp/widgets/headline_carousel_sliders.dart';
import 'package:newsapp/widgets/hot_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        HeadlinesSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Hot News", style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        ),
        HotNews()
      ],
    );
  }
}
