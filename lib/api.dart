import 'package:http/http.dart' as http;
import 'package:uri/uri.dart';
import 'dart:convert' as convert;
class ApiWrappers {

  final String mapBoxRootUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
  final String mapBoxApiKey = 'pk.eyJ1IjoiYm5haWsyNjExIiwiYSI6ImNqdDNsOTFpNDB2aW40OXBnamtlYnRzOGUifQ.wu8BxADFpu4VHpGsSJIAgg';

  final String darkSkyRootUrl = 'https://api.darksky.net/forecast';
  final String darkSkyApiKey = '08d457ee37d5910a6903c6e1235df388';
  final int LATITUDE_IDX = 0;
  final int LONGITUDE_IDX = 1;

  Future<List> getLocationCoordinates(String locationName) async {
    List urlTemplateElements = [
      mapBoxRootUrl,
      '{locationName}?access_token={apiKey}'
    ];
    var urlTemplate = new UriTemplate(urlTemplateElements.join("/"));
    String geolocResourceLink = urlTemplate.expand({
      'locationName' : Uri.encodeFull(locationName),
      'apiKey' : mapBoxApiKey
    });

    var latitude, longitude = -1;

    var apiResponse = await http.get(geolocResourceLink);
    if (apiResponse.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(apiResponse.body);
      latitude = jsonResponse['features'][0]['center'][LATITUDE_IDX];
      longitude = jsonResponse['features'][0]['center'][LONGITUDE_IDX];
    }
    return [latitude, longitude];
  }

  Future<Map> getWeatherInfo(String locationName) async {
    var geoCordinates = await this.getLocationCoordinates(locationName);

    if (geoCordinates[LATITUDE_IDX] == -1 && geoCordinates[LATITUDE_IDX] == -1) {
      return {};
    } else {
      List urlTemplateElements = [
        darkSkyRootUrl,
        '{apiKey}',
        '{latitude},{longitude}'
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
        return jsonResponse['currently'];
      } else {
        return {};
      }
    }
  }
}
