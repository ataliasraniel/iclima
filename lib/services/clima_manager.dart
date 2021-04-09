import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iclima/services/location.dart';

class ClimaManager {
  Location location = Location();
  String icon;
  String city;
  String temperature;
  String weather;
  var decoded;

  Future<dynamic> getData() async {
    var loc = await location.getCurrentLocation();

    double lat = loc.latitude;
    double long = loc.longitude;
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=1f7598d1203487d8d13ba417fa8af09d&units=metric'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      city = data['name'];
      icon = data['weather'][0]['icon'];
      return data;
    } else {
      print('response is: ${response.statusCode}');
    }
  }
}
