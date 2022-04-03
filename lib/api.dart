import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_app/model/video_model.dart';

const CHAVE_API = "AIzaSyD_rGV1w6bmEbNvM-WkYFrWHUaPRgzPnF8";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisar) async {
    http.Response response =
        await http.get(Uri.parse("${URL_BASE}search?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisar"));
    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      List<Video> videos =
          dadosJson["items"].map<Video>((m) => Video.fromJson(m)).toList();
      return videos;
    }
    return List<Video>.empty();
  }
}
