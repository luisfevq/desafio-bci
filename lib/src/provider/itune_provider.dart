import 'dart:io';

import 'dart:convert';

import 'package:itunes/src/models/albumModel.dart';

class ItuneProvider {
  HttpClient httpClient = new HttpClient();

  
  Future<List<AlbumModel>> getListado(String terminoBusqueda) async {

    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse('https://itunes.apple.com/search?term=${terminoBusqueda}&mediaType=music&limit=50'));
    request.headers.set('content-type', 'application/json');

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    
    final List<AlbumModel> result = [];
    if (response.statusCode == 200) {
      final Map<dynamic, dynamic> decodedData = json.decode(reply);

      if (decodedData == null) return [];

      if (decodedData != null) {
          decodedData['results'].forEach((data1) {
            final fumigadoTemp = AlbumModel.fromJson(data1);
            result.add(fumigadoTemp);
          });
      }
    }
    return result;
  }
}