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
  final double WEATHER_ICON_HEIGHT = 100;
  Map weatherInfo = null;

  void createWeatherInfo() async {
    var apiCallerObject = new ApiWrappers();
    await apiCallerObject.getWeatherInfo('Los Angeles').then((Map value) {
      print('this is the problem');
      print(value);
      setState(() {
        this.weatherInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          Row(
            children: <Widget>[
              Expanded(
                child: Image.network('https://darksky.net/images/weather-icons/'+ weatherInfo['icon'] +'.png', height: WEATHER_ICON_HEIGHT,),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Description'),
              Text('this is the description')
            ],
          )
        ],
      );
    }
  }
}