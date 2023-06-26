import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:requests/requests.dart';
import 'package:url_launcher/url_launcher.dart';

import 'movies.dart';

part 'moviestore.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  @observable
  List<String> titleList = [];

  @observable
  List<int> idList = [];

  @observable
  List<String> posterPathList = [];

  @observable
  List<String> overviewList = [];

  @observable
  List<Result> movies = [];

  @action
  void updateMovieData(Movies movieData) {
    movies = movieData.results;
  }

  Future<void> getMovies(String movieTitle) async {
    final cleanedTitle = movieTitle.replaceAll(" ", "+");
    // titleList.clear();
    // idList.clear();
    // posterPathList.clear();
    // overviewList.clear();

    final r = await Requests.get(
        "https://api.themoviedb.org/3/search/movie?api_key=87d5585a5497b373679e8bdc7d6f0d22&query=$cleanedTitle");

    final stringResult = r.content();
    final jsonResult = json.decode(stringResult);

    Movies movies = Movies.fromMap(jsonResult);

    updateMovieData(movies);

    print("API_Result: ${movies.toString()}");
    List<String> tempTitle = [];
    List<int> tempID = [];
    List<String> tempPoster = [];
    List<String> tempOverview = [];

    //
    // for (final item in results) {
    //   final title = item['title']??"";
    //   final id = item['id']??0;
    //   final posterPath = item['poster_path']??"";
    //   final overview = item['overview']??"";
    //
    //   tempTitle.add(title);
    //   tempID.add(id);
    //   tempPoster.add(posterPath);
    //   tempOverview.add(overview);
    // }
    //
    // titleList = tempTitle;
    // idList = tempID;
    // posterPathList = tempPoster;
    // overviewList = tempOverview;
    //return titleList;
  }

  @action
  Future<void> playMovie(int id) async {
    final url = "https://v2.vidsrc.me/embed/$id/";
    final uri = Uri.parse(url);

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}
