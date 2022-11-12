class PollutionInfo {
  double airQuality;
  // double pm10;
  // double pm2_5;
  // double co;
  // double no;
  // double o3;
  // double so2;
  List<dynamic> pollutants;
  List<String> pollutantsName = ['PM10', 'PM2.5', 'CO', 'NO', 'O3', 'SO2'];

  PollutionInfo.fromJson(Map<String, dynamic> json)
      : airQuality = json['list'][0]['main']['aqi'].toDouble(),
        // pm10 = json['list'][0]['components']['pm10'].toDouble(),
        // pm2_5 = json['list'][0]['components']['pm2_5'].toDouble(),
        // co = json['list'][0]['components']['co'].toDouble(),
        // no = json['list'][0]['components']['no'].toDouble(),
        // o3 = json['list'][0]['components']['o3'].toDouble(),
        // so2 = json['list'][0]['components']['so2'].toDouble();

        pollutants = [
          json['list'][0]['components']['pm10'],
          json['list'][0]['components']['pm2_5'],
          json['list'][0]['components']['co'],
          json['list'][0]['components']['no'],
          json['list'][0]['components']['o3'],
          json['list'][0]['components']['so2']
        ];
}
