import 'package:newsapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:newsapp/models/article_responses.dart';

class SearchBloc {
  final NewsRepository _newsRepository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();

  search(String value) async {
    ArticleResponse articleResponse = await _newsRepository.searchArticle(value);
    _subject.sink.add(articleResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final searchBloc = SearchBloc();