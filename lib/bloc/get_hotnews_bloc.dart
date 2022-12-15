import 'package:newsapp/models/article_response.dart';
import 'package:newsapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetHotNewsBloc {
  final NewsRepository _newsRepository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();

  getHotNews() async {
    ArticleResponse articleResponse = await _newsRepository.getHotNews();
    _subject.sink.add(articleResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getHotNewsBloc = GetHotNewsBloc();