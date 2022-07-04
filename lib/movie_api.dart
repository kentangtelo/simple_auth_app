import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tvshow.dart';

const String url = 'https://www.episodate.com/api/search?q=arrow&page=1';

Future<List<TvShows>> fetchdata() async {
  final response =
      await http.get(Uri.parse('https://www.episodate.com/api/most-popular'));
  Map data = jsonDecode(response.body);
  List _temp = [];
  for (var i in data['tv_shows']) {
    _temp.add(i);
  }
  return TvShows.movieSnapshot(_temp);
}
