import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double MAIN_CONTAINER_COLUMN_PADDING = 10.0;

  void createWeatherInfo() async {

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
              createSearchBar()
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
    
  }
}