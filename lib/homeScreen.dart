import 'package:castform/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double MAIN_CONTAINER_COLUMN_PADDING = 10.0;
  final double WEATHER_ICON_HEIGHT = 200;
  final String WEATHER_ICON_ROOT_URL = 'https://darksky.net/images/weather-icons/';

  final locationQueryFieldController = TextEditingController();

  final String SUMMARY = 'Summary';
  final String WIND_SPEED = 'Wind Speed';
  final String PRESSURE = 'Pressue';
  final String HUMIDITY = 'Humidity';
  final String TEMPERATURE = 'Temperature';
  final String VISIBILITY = 'Visibility';

  Map weatherInfo = null;

  void createWeatherInfo() async {
    var apiCallerObject = new ApiWrappers();
    await apiCallerObject.getWeatherInfo(locationQueryFieldController.text).then((Map value) {
      setState(() {
        this.weatherInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.lightBlueAccent),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.cloud_queue, size: 35, color: Colors.lightBlueAccent,),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MAIN_CONTAINER_COLUMN_PADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              createSearchBar(),
              createWeatherView()
            ],
          ))
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget createSearchBar() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:<Widget>[
          Expanded(
              child: TextField(
                controller: locationQueryFieldController,
                decoration: InputDecoration(
                    labelText: 'Enter name of Place'
                ),
              )
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: createWeatherInfo,
          )
        ]
    );
  }

  Widget createWeatherView() {
    if (this.weatherInfo == null) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          createIcon(),
          Text("What's it like?", style: TextStyle(fontSize: 15, color: Colors.black38, fontStyle: FontStyle.italic)),
          createInfoTitle(),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 25, 5, 25),
            child: Column(
              children: <Widget>[
                createSummary(),
                createWindSpeed(),
                createHumidity(),
                createTemperature(),
                createVisibility()
              ],
            ),
          )
        ],
      );
    }
  }

  Widget createIcon() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.network(WEATHER_ICON_ROOT_URL+ weatherInfo['icon'] +'.png', height: WEATHER_ICON_HEIGHT,),
        )
      ],
    );
  }

  Widget createInfoTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(weatherInfo['placeName'], style: TextStyle(fontSize: 20,),)
      ],
    );
  }

  Widget createSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(SUMMARY, style: TextStyle(fontSize: 16, color: Colors.black54)),
        Text(weatherInfo['summary'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ],
    );
  }

  Widget createWindSpeed() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(WIND_SPEED, style: TextStyle(fontSize: 16, color: Colors.black54)),
        Text(weatherInfo['windSpeed'].toString(), style: TextStyle(fontSize: 16))
      ],
    );
  }

  Widget createHumidity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(HUMIDITY, style: TextStyle(fontSize: 16, color: Colors.black54)),
        Text(weatherInfo['humidity'].toString(), style: TextStyle(fontSize: 16))
      ],
    );
  }

//  final String TEMPERATURE = 'Temperature';
//  final String VISIBILITY = 'Visibility';

  Widget createTemperature() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(TEMPERATURE, style: TextStyle(fontSize: 16, color: Colors.black54)),
        Text(weatherInfo['temperature'].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ],
    );
  }

  Widget createVisibility() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(VISIBILITY, style: TextStyle(fontSize: 16, color: Colors.black54)),
        Text(weatherInfo['visibility'].toString(), style: TextStyle(fontSize: 16))
      ],
    );
  }
}