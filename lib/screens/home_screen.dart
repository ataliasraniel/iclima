import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iclima/services/clima_manager.dart';
import 'package:iclima/services/location.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  static final String id = 'homeScreenId';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String languageCode;

  Location location = Location();
  var data;
  String weather;
  int temperature;
  int feelsLike;
  int humidity;
  int windSpeed;
  int windDegree;
  String icon;
  String cityName;
  int seaLevel;

  //DATA
  DateTime now;
  String day;
  int mounth;
  String mounthName;

  int dayWeek;
  String dayName;

  String time;
  ClimaManager _climaManager = ClimaManager();

  @override
  void initState() {
    print(window.locale.languageCode);
    languageCode = window.locale.languageCode;
    _getCurrentWeather();
    super.initState();
  }

  _getCurrentWeather() async {
    data = await _climaManager.getData();
    setState(() {
      _getCurrentTime();
      cityName = data['name'];
      weather = data['weather'][0]['main'];
      _setTranslation();
      var temp = data['main']['temp'];
      icon = data['weather'][0]['icon'];
      double feels = data['main']['feels_like'];
      humidity = data['main']['humidity'];
      double wind = data['wind']['speed'];
      seaLevel = data['main']['sea_level'];
      windDegree = data['wind']['deg'];
      windSpeed = wind.toInt();
      feelsLike = feels.toInt();
      temperature = temp.toInt();
    });
  }

  _setTranslation() {
    if (languageCode == 'en') {
      return;
    }
    if (weather != null) {
      switch (weather) {
        case 'Clouds':
          weather = 'Nublado';
          break;
        case 'Rain':
          weather = 'Chuva';
          break;
        case 'Thunderstorm':
          weather = 'Tempestade de Trovões';
          break;
        case 'Drizzle':
          weather = 'Nevasca';
          break;
        case 'Clear':
          weather = 'Céu Limpo';
          break;
        case 'Snow':
          weather = 'Neve';
          break;
      }
    }
  }

  _getCurrentTime() {
    now = DateTime.now();
    dayWeek = now.weekday;
    time = DateFormat.Hm().format(now);
    DateFormat formatter;
    languageCode == 'en'
        ? formatter = DateFormat('yyyy-MM-dd')
        : formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(now);
    day = formatted.substring(0, 2);
    var mounth;
    languageCode == 'en' ? mounth = formatted[6] : mounth = formatted[4];
    mounth = int.parse(mounth);
    switch (mounth) {
      case 1:
        languageCode == 'en' ? mounthName = 'january' : mounthName = 'janeiro';
        break;
      case 2:
        languageCode == 'en'
            ? mounthName = 'february'
            : mounthName = 'fevereiro';
        break;
      case 3:
        languageCode == 'en' ? mounthName = 'march' : mounthName = 'março';
        break;
      case 4:
        languageCode == 'en' ? mounthName = 'april' : mounthName = 'abril';
        break;
      case 5:
        languageCode == 'en' ? mounthName = 'may' : mounthName = 'maio';
        break;
      case 6:
        languageCode == 'en' ? mounthName = 'june' : mounthName = 'junho';
        break;
      case 7:
        languageCode == 'en' ? mounthName = 'july' : mounthName = 'julho';
        break;
      case 8:
        languageCode == 'en' ? mounthName = 'august' : mounthName = 'agosto';
        break;
      case 9:
        languageCode == 'en'
            ? mounthName = 'september'
            : mounthName = 'setembro';
        break;
      case 10:
        languageCode == 'en' ? mounthName = 'october' : mounthName = 'outubro';
        break;
      case 11:
        languageCode == 'en'
            ? mounthName = 'november'
            : mounthName = 'novembro';
        break;
      case 12:
        languageCode == 'en'
            ? mounthName = 'december'
            : mounthName = 'dezembro';
        break;
    }
    switch (dayWeek) {
      case 1:
        languageCode == 'en' ? dayName = 'monday' : dayName = 'segunda-feira';
        break;
      case 2:
        languageCode == 'en' ? dayName = 'tuesday' : dayName = 'terça-feira';
        break;
      case 3:
        languageCode == 'en' ? dayName = 'wednesday' : dayName = 'quarta-feira';
        break;
      case 4:
        languageCode == 'en' ? dayName = 'thursday' : dayName = 'quinta-feira';
        break;
      case 5:
        languageCode == 'en' ? dayName = 'friday' : dayName = 'sexta-feira';
        break;
      case 6:
        languageCode == 'en' ? dayName = 'saturday' : dayName = 'sábado';
        break;
      case 3:
        languageCode == 'en' ? dayName = 'sunday' : dayName = 'domingo';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF485460)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: _height / 1.2,
            width: _width / 1.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data == null ? 'awating' : cityName,
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                          ),
                          Text(
                            temperature == null
                                ? '0'
                                : temperature.toString() + 'º',
                            style: TextStyle(
                                fontSize: 86,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            icon == null
                                ? CircularProgressIndicator.adaptive()
                                : SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Image.network(icon == null
                                        ? null
                                        : 'http://openweathermap.org/img/wn/$icon@2x.png'),
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: _width / 4,
                              child: Text(
                                weather == null
                                    ? 'awating'
                                    : weather.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w300),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 1,
                ),
                Text(
                  languageCode == 'en'
                      ? '${time == null ? '0' : time} - 2021 - ${mounthName == null ? '' : mounthName} - $day, ${dayName == null ? '0' : dayName}'
                      : '${time == null ? '0' : time} - ${dayName == null ? 'segunda-feira' : dayName} - $day de ${mounthName == null ? '0' : mounthName} de 2021',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
                Divider(
                  color: Colors.white,
                  height: 1,
                ),
                weather == null
                    ? CircularProgressIndicator.adaptive()
                    : InfoRow(
                        languageCode == 'en'
                            ? 'Feels like'
                            : 'Sensação térmica',
                        feelsLike == null ? '0 º' : feelsLike.toString() + 'º',
                        FontAwesomeIcons.temperatureHigh),
                humidity == null
                    ? CircularProgressIndicator.adaptive()
                    : InfoRow(
                        languageCode == 'en' ? 'Humidity' : 'Umidade',
                        humidity == null ? '0%' : humidity.toString() + '%',
                        FontAwesomeIcons.tint),
                windSpeed == null
                    ? CircularProgressIndicator.adaptive()
                    : InfoRow(
                        languageCode == 'en' ? 'Wind' : 'Vento',
                        windSpeed == null
                            ? '0km/h'
                            : windSpeed.toString() + 'km/h',
                        FontAwesomeIcons.wind),
                windDegree == null
                    ? CircularProgressIndicator.adaptive()
                    : InfoRow(
                        languageCode == 'en'
                            ? 'Wind orientation'
                            : 'Orientação do vento',
                        windDegree == null
                            ? '0 graus'
                            : windDegree.toString() + 'º',
                        FontAwesomeIcons.compass),
                seaLevel == null
                    ? CircularProgressIndicator.adaptive()
                    : InfoRow(
                        languageCode == 'en' ? 'Sealevel' : 'Nível do mar',
                        seaLevel == null ? '1000' : seaLevel.toString(),
                        FontAwesomeIcons.water,
                      ),
                SizedBox(
                  height: _height / 60,
                ),
                TextButton(
                  onPressed: () {
                    _getCurrentWeather();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_rounded),
                      (Text(languageCode == 'en' ? 'locate' : 'localizar')),
                    ],
                  ),
                ),
                Text(
                  'iClima - version: 0.0.1',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(100),
                  ),
                ),
              ],
            ),
          ),
        ),
        color: Color(0xFF1e272e),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String info;
  InfoRow(this.title, this.info, this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FaIcon(
              icon,
              size: 19,
              color: Colors.white,
            ),
            SizedBox(width: 20),
            Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300)),
          ],
        ),
        Text(info,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w200)),
      ],
    );
  }
}
