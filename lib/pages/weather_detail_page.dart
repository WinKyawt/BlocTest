import 'package:bloc_testing/bloc/bloc.dart';
import 'package:bloc_testing/pages/weather_search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/weather.dart';
import 'package:flutter/material.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;
  const WeatherDetailPage({Key key, @required this.masterWeather})
      : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Immediately trigger the event
    BlocProvider.of<WeatherBloc>(context)
      ..add(GetDetailedWeather(widget.masterWeather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context)
    ..add(GetDetailedWeather(widget.masterWeather.cityName));
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc,WeatherState> (builder: (context, state) {
          if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(context, state.weather);
          }
        },),
      ),
    );
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator(),);
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
          Text(
            "${weather.temperatureCelsius.toStringAsFixed(1)} C",
            style: TextStyle(fontSize: 80),
          ),
           Text(
            "${weather.temperatureFarenheit.toStringAsFixed(1)} F",
            style: TextStyle(fontSize: 80),
          ),
         
        ]);
  }
}

// class WeatherDetailPage extends StatefulWidget {
//   final Weather masterWeather;

//   const WeatherDetailPage({
//     Key key,
//     @required this.masterWeather,
//   }) : super(key: key);

//   @override
//   _WeatherDetailPageState createState() => _WeatherDetailPageState();
// }

// class _WeatherDetailPageState extends State<WeatherDetailPage> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Immediately trigger the event
//     BlocProvider.of<WeatherBloc>(context)
//       ..add(GetDetailedWeather(widget.masterWeather.cityName));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
