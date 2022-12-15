import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_news_by_category_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loader_element.dart';
import 'package:newsapp/models/article.dart';
import 'package:newsapp/models/article_response.dart';
import 'package:newsapp/models/category.dart';
import 'package:newsapp/screens/news_details.dart';
import 'package:newsapp/styles/theme.dart' as style;
import 'package:timeago/timeago.dart' as timeago;

class CategoryDetails extends StatefulWidget {
  final CategoryModel category;
  const CategoryDetails({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState(category);
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final CategoryModel category;
  _CategoryDetailsState(this.category);

  @override
  void initState() {
    super.initState();
    getNewsByCategoryBloc.getCategoryNews(category.name.toLowerCase());
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: style.Colors.mainColor,
            title: Text(
              category.name,
            )
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<ArticleResponse>(
              stream: getNewsByCategoryBloc.subject.stream,
              builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.error != null &&
                      snapshot.data!.error.isNotEmpty) {
                    return Container();
                  }
                  return _buildCategoryNewsWidget(snapshot.requireData);
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return buildLoadingWidget();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryNewsWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;

    if (articles.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text(
              "No more news",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetails(
                          article: articles[index],
                        )));
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  color: Colors.white,
                ),
                height: 150,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(articles[index].title.toString(),
                              maxLines: 3,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14.0)),
                          Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                            timeUntil(DateTime.parse(articles[index]
                                                .publishedAt
                                                .toString())),
                                            style: const TextStyle(
                                                color: Colors.black26,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.0))
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        width: MediaQuery.of(context).size.width * 2 / 5,
                        height: 130,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)
                              ),
                              image: DecorationImage(
                                  image: articles[index].img == null ? AssetImage("") as ImageProvider : NetworkImage(
                                      articles[index].img.toString()),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
