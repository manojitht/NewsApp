import 'package:flutter/cupertino.dart';

Widget buildLoadingWidget() {
  return Center(
    child: Column(
      children: const [
        CupertinoActivityIndicator()
      ],
    ),
  );
}