import 'package:flutter/material.dart';
import 'package:tempo_template/services/location.dart';
import 'package:tempo_template/services/networking.dart';
import 'package:tempo_template/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '7a2ef7b63d58dc9c539554094a6890ba';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/'
        'data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    pushToLocationScreen(weatherData);
  }

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }
  @override
  void initState() {
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
