import 'package:flutter/material.dart';
import 'package:newsapp/helpers/utils.dart';
import 'package:newsapp/models/categories.dart';
import 'package:newsapp/screens/show_categories.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoryModel> categories = Utils.getCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              "News Categories List",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 20.0,
                    right: 20.0
                  ),
                  height: 150.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CategoryDetails(category: categories[index])
                      ));
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset("assets/${categories[index].name.toLowerCase()}.jpg",
                              fit: BoxFit.cover,),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.9),
                                      Colors.transparent
                                    ]
                                )
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      categories[index].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0
                                      ),
                                    )
                                  ],
                                )
                            )
                        )
                      ],
                    ),
                  )
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
