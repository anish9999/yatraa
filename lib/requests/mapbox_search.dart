//access token is required

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../helpers/dio_exceptions.dart';
import '../main.dart';

String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken =
    "pk.eyJ1IjoicnVzdHUtbmV1cGFuZSIsImEiOiJjbGFnN3N4emgxY2VzM29ydHlhc2ozbW41In0.HterCgrAMUExckM18JX8ig";
String searchType = 'place%2Cpostcode%2Caddress%2Clocality%2Cpoi';
String searchResultsLimit = '5';
String proximity =
    '${sharedPreferences.getDouble('longitude')}%2C${sharedPreferences.getDouble('latitude')}';
String country = 'np';

Dio _dio = Dio();

Future getSearchResultsFromQueryUsingMapbox(String query) async {
  String url =
      '$baseUrl/$query.json?country=$country&limit=$searchResultsLimit&proximity=$proximity&types=$searchType&access_token=$accessToken';

  url = Uri.parse(url).toString();

  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
  }
}
