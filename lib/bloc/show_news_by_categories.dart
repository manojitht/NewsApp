import 'package:newsapp/models/article_responses.dart';
import 'package:newsapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetNewsByCategoryBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
  BehaviorSubject<ArticleResponse>();

  getCategoryNews(String category) async {
    ArticleResponse response = await _repository.getNewsByCategory(category);
    _subject.sink.add(response);
  }

  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;

}

final getNewsByCategoryBloc = GetNewsByCategoryBloc();