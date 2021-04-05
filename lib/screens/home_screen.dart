import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'homeScreenId';
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
                            'Cidade',
                            style: TextStyle(fontSize: 64, color: Colors.white),
                          ),
                          Text(
                            '20º',
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
                            FaIcon(FontAwesomeIcons.cloud,
                                color: Colors.white, size: 84),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Nublado',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w300),
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
                  '10:40 - Segunda-feira - 06 de Abril',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                  height: 2,
                ),
                InfoRow('Sensação térmica', '22º'),
                InfoRow('Umidade', '22%'),
                InfoRow('Vento', '25km/h'),
                InfoRow('Orientação do vento', '14graus'),
                SizedBox(
                  height: _height / 40,
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
                fontSize: 24,
                fontWeight: FontWeight.w300)),
        Text(info,
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w200)),
      ],
    );
  }
}
