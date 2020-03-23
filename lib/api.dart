import 'package:http/http.dart' as http;
import 'package:uri/uri.dart';
import 'dart:io';
import 'dart:convert' as convert;

class ApiWrappers {

  final String mapBoxRootUrl = Platform.environment['MAP_BOX_ROOT_URL'];
  final String mapBoxApiKey = Platform.environment['MAP_BOX_API_KEY'];

  final String darkSkyRootUrl = Platform.environment['DARK_SKY_ROOT_URL'];
  final String darkSkyApiKey = Platform.environment['DARK_SKY_API_KEY'];

  final int LATITUDE_IDX = 0;
  final int LONGITUDE_IDX = 1;
  final int PLACE_NAME_IDX = 2;

  Future<List> getLocationCoordinates(String locationName) async {
    List urlTemplateElements = [
      mapBoxRootUrl,
      '{locationName}.json?access_token={apiKey}'
    ];
    var urlTemplate = new UriTemplate(urlTemplateElements.join("/"));
    String geolocResourceLink = urlTemplate.expand({
      'locationName' : Uri.encodeQueryComponent(locationName),
      'apiKey' : mapBoxApiKey
    });

    double latitude, longitude = -1;
    String placeName = '';

    var apiResponse = await http.get(geolocResourceLink);

    if (apiResponse.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(apiResponse.body);
      latitude = jsonResponse['features'][0]['center'][LATITUDE_IDX];
      longitude = jsonResponse['features'][0]['center'][LONGITUDE_IDX];
      placeName = jsonResponse['features'][0]['place_name'];
    }
    return [latitude, longitude, placeName];
  }

  Future<Map> getWeatherInfo(String locationName) async {
    List geoCordinates =  await this.getLocationCoordinates(locationName);
    if (geoCordinates[LATITUDE_IDX] == -1 && geoCordinates[LATITUDE_IDX] == -1) {
      return {};
    } else {
      List urlTemplateElements = [
        darkSkyRootUrl,
        '{apiKey}',
        '{longitude},{latitude}'
      ];

      var urlTemplate = new UriTemplate(urlTemplateElements.join("/"));

      String weatherInfoResourceLink = urlTemplate.expand({
        'latitude' : geoCordinates[LATITUDE_IDX],
        'longitude' : geoCordinates[LONGITUDE_IDX],
        'apiKey' : darkSkyApiKey
      });

      var apiResponse = await http.get(weatherInfoResourceLink);
      if (apiResponse.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(apiResponse.body);
        Map weatherInfo = jsonResponse['currently'];
        weatherInfo['placeName'] = geoCordinates[PLACE_NAME_IDX];
        return weatherInfo;
      } else {
        return {};
      }
    }
  }
}
