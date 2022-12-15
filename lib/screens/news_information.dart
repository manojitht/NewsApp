import 'package:flutter/material.dart';
import 'package:newsapp/models/articles.dart';
import 'package:newsapp/styles/theme.dart' as style;
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  final ArticleModel article;
  const NewsDetails({Key? key, required this.article}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState(article);
}

class _NewsDetailsState extends State<NewsDetails> {
  final ArticleModel article;
  _NewsDetailsState(this.article);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(article.url.toString()));
        },
        child: Container(
          height: 48.0,
          width: MediaQuery.of(context).size.width,
          color: style.Colors.mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Read More",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0
                ),
              ),
            ],
          ),
        ),
      ),
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: style.Colors.mainColor,
            title: Text(
              article.title.toString(),
            )
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0)
                  ),
                  image: DecorationImage(
                      image: article.img == null ? const AssetImage("assets/placeholder.png") as ImageProvider : NetworkImage(
                          article.img.toString()),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Published on: ${article.publishedAt.toString().substring(0,10)}",
                  style: const TextStyle(
                    color: style.Colors.mainColor,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  article.title.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  article.content.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
