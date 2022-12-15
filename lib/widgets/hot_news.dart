import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_hotnews_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loader_element.dart';
import 'package:newsapp/models/article.dart';
import 'package:newsapp/models/article_response.dart';
import 'package:newsapp/screens/news_details.dart';
import 'package:newsapp/styles/theme.dart' as style;
import 'package:timeago/timeago.dart' as timeago;

class HotNews extends StatefulWidget {
  const HotNews({Key? key}) : super(key: key);

  @override
  State<HotNews> createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    super.initState();
    getHotNewsBloc.getHotNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getHotNewsBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.error != null && snapshot.data!.error.isNotEmpty) {
            return Container();
          }
          return _buildHotNews(snapshot.requireData);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error.toString());
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHotNews(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;

    if(articles.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text("No more news",
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      );
    } else {
      return Container(
        height: articles.length / 2 * 210.0,
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetails(
                          article: articles[index],
                        )));
              },
              child: Card(
                elevation: 2.0,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: articles[index].img == null
                                  ? const AssetImage("") as ImageProvider
                                  : NetworkImage(
                                  articles[index].img.toString()),
                              fit: BoxFit.fitWidth),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articles[index].title.toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.person),
                                Text(
                                  articles[index].source!.name.toString(),
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    color: style.Colors.mainColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Icon(Icons.date_range),
                                Text(
                                  timeUntil(DateTime.parse(
                                      articles[index].publishedAt.toString())),
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    color: style.Colors.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        }),
      );
    }
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
