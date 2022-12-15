import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/bloc/top_news_headlines.dart';
import 'package:newsapp/elements/error.dart';
import 'package:newsapp/elements/loader.dart';
import 'package:newsapp/models/articles.dart';
import 'package:newsapp/models/article_responses.dart';
import 'package:newsapp/screens/news_information.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlinesSliderWidget extends StatefulWidget {
  const HeadlinesSliderWidget({Key? key}) : super(key: key);

  @override
  State<HeadlinesSliderWidget> createState() => _HeadlinesSliderWidgetState();
}

class _HeadlinesSliderWidgetState extends State<HeadlinesSliderWidget> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesBloc.getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.error != null && snapshot.data!.error.isNotEmpty) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildHeadlineSliderWidget(snapshot.requireData);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error.toString());
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHeadlineSliderWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            height: 200.0,
            viewportFraction: 0.8
        ),
        items: getExpenseSliders(articles),
      ),
    );
  }

  getExpenseSliders(List<ArticleModel> articles) {
    return articles.map((article) => GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(article: article,)));
      },
      child: Container(
        padding: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            top: 10.0,
            bottom: 10.0
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: article.img == null ? AssetImage("") as ImageProvider : NetworkImage(
                        article.img.toString()),
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.white.withOpacity(0.0)
                      ]
                  )
              ),
            ),
            Positioned(
                bottom: 30.0,
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  width: 250.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        article.title.toString(),

                        style: const TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5),
                      ),
                    ],
                  ),
                )
            ),
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: Text(
                article.source!.name.toString(),
                style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 9.0
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: Text(
                timeUntil(DateTime.parse(article.publishedAt.toString())),
                style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 9.0
                ),
              ),
            )
          ],
        ),
      ),
    )
    ).toList();
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}


