import 'package:flutter/material.dart';
import 'package:iclima/services/clima_manager.dart';
import 'package:iclima/services/location.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'homeScreenId';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    if (weather != null) {
      switch (weather) {
        case 'Clouds':
          weather = 'Nublado';
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
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(now);
    day = formatted.substring(0, 2);
    var mount = formatted[4];
    mounth = int.parse(mount);
    switch (mounth) {
      case 1:
        mounthName = 'janeiro';
        break;
      case 2:
        mounthName = 'fevereiro';
        break;
      case 3:
        mounthName = 'março';
        break;
      case 4:
        mounthName = 'abril';
        break;
      case 5:
        mounthName = 'maio';
        break;
      case 6:
        mounthName = 'junho';
        break;
      case 7:
        mounthName = 'julho';
        break;
      case 8:
        mounthName = 'agosto';
        break;
      case 9:
        mounthName = 'setembro';
        break;
      case 10:
        mounthName = 'outubro';
        break;
      case 11:
        mounthName = 'novembro';
        break;
      case 12:
        mounthName = 'dezembro';
        break;
    }
    switch (dayWeek) {
      case 1:
        dayName = 'segunda-feira';
        break;
      case 2:
        dayName = 'terça-feira';
        break;
      case 3:
        dayName = 'quarta-feira';
        break;
      case 4:
        dayName = 'quinta-feira';
        break;
      case 5:
        dayName = 'sexta-feira';
        break;
      case 6:
        dayName = 'sábado';
        break;
      case 3:
        dayName = 'domingo';
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
                            style: TextStyle(fontSize: 32, color: Colors.white),
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
                                weather == null ? 'nublado' : weather,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
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
                  thickness: 2,
                  height: 2,
                ),
                Text(
                  '${time == null ? '0' : time} - ${dayName == null ? 'segunda-feira' : dayName} - $day de ${mounthName == null ? '0' : mounthName} de 2021',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                  height: 2,
                ),
                InfoRow('Sensação térmica',
                    feelsLike == null ? '0 º' : feelsLike.toString() + 'º'),
                InfoRow('Umidade',
                    humidity == null ? '0%' : humidity.toString() + '%'),
                InfoRow(
                    'Vento',
                    windSpeed == null
                        ? '0km/h'
                        : windSpeed.toString() + 'km/h'),
                InfoRow(
                    'Orientação do vento',
                    windDegree == null
                        ? '0 grau'
                        : windDegree.toString() + 'graus'),
                InfoRow('Nível do mar',
                    seaLevel == null ? '1000' : seaLevel.toString()),
                SizedBox(
                  height: _height / 40,
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_rounded),
                      (Text('buscar localização')),
                    ],
                  ),
                ),
                Text(
                  'iClima - version: 0.0.1',
                  style: TextStyle(
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
  InfoRow(this.title, this.info);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w300)),
        Text(info,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w200)),
      ],
    );
  }
}
