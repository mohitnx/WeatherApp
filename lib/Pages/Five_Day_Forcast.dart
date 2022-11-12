import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/model.dart/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Provider/city_provider.dart';

class FiveDayDetails extends StatefulWidget {
  double lat, long;
  FiveDayDetails({required this.lat, required this.long});

  @override
  State<FiveDayDetails> createState() => _FiveDayDetailsState();
}

class _FiveDayDetailsState extends State<FiveDayDetails> {
  Constants myColor = Constants();

  @override
  Widget build(BuildContext context) {
    List<TempData> tempDataMin = [
      TempData(
          temp: Provider.of<CityProvider>(context, listen: false).minTemp[0],
          day: 1.0),
      TempData(
          temp: Provider.of<CityProvider>(context, listen: false).minTemp[1],
          day: 2.0),
      TempData(
          temp: Provider.of<CityProvider>(context, listen: false).minTemp[2],
          day: 3.0),
      TempData(
          temp: Provider.of<CityProvider>(context, listen: false).minTemp[3],
          day: 4.0),
      TempData(
          temp: Provider.of<CityProvider>(context, listen: false).minTemp[4],
          day: 5.0)
    ];
    List<int> windDirection = Provider.of<CityProvider>(context, listen: false)
        .windDirection(
            Provider.of<CityProvider>(context, listen: false).degreeofWind);

    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Provider.of<CityProvider>(context, listen: false)
                .weatherInfo!
                .settingBgPicture(),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        left: 10,
        top: size.height * .14,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(31, 146, 86, 158),
              borderRadius: BorderRadius.circular(8),
            ),
            // color: Color.fromARGB(133, 176, 131, 128),
            height: 350,
            width: 67,
          ),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '5 day forcast',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Consumer<CityProvider>(
                      builder: ((context, value, child) => Container(
                            color: Colors.transparent,
                            width: size.width,
                            height: 100,
                            child: ListView.separated(
                              padding: EdgeInsets.all(10),
                              separatorBuilder: (context, index) => (SizedBox(
                                width: 41,
                              )),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) =>
                                  Column(children: [
                                Text(
                                  value.day[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                                Text(
                                  value.date[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                              ]),
                            ),
                          )))),
              Container(
                height: 100,
                width: 400,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  enableAxisAnimation: true,
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                  ),
                  primaryYAxis: CategoryAxis(
                    isVisible: false,
                  ),
                  series: <ChartSeries>[
                    LineSeries<TempData, double>(
                      dataSource: tempDataMin,
                      xValueMapper: (TempData tempData, _) => tempData.day,
                      yValueMapper: (TempData tempData, _) => tempData.temp,
                      markerSettings: MarkerSettings(
                        borderWidth: 10,
                        isVisible: true,
                        color: myColor.secondaryColor.withOpacity(0.7),
                      ),
                      name: 'Data',
                      dataLabelSettings: DataLabelSettings(
                        labelAlignment: ChartDataLabelAlignment.bottom,
                        isVisible: true,
                        color: Colors.white,
                        opacity: 0.6,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  // width: size.width * 0.95,
                  child: Consumer<CityProvider>(
                      builder: ((context, value, child) => Container(
                            height: 200,
                            child: ListView.separated(
                              padding: EdgeInsets.all(12),
                              separatorBuilder: (context, index) => (SizedBox(
                                width: 22,
                              )),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) =>
                                  Column(children: [
                                Image.network(
                                  'http://openweathermap.org/img/wn/${value.iconString[index]}.png',
                                ),
                                Text(
                                  value.fiveDayData[index].description
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                          .withOpacity(0.7)
                                          .withOpacity(0.7)),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    '${value.fiveDayData[index].wind.toString()}km/h'),
                                Transform.rotate(
                                  //-ve sign as Transform rotaes clockwise..so to make it counterclockwise
                                  //changing degree to radian
                                  angle: windDirection[index] * 0.01745,

                                  child: Icon(
                                    Icons.arrow_circle_right,
                                    color: Color.fromARGB(255, 120, 84, 159)
                                        .withOpacity(0.7),
                                  ),
                                )
                              ]),
                            ),
                          )))),
            ]),
          ]))
    ]);
  }
}

/*<ChartSeries<TempModel, String>>[
            LineSeries<TempModel, String>(
              dataSource: chartData,
              xValueMapper: (TempModel chartData, _) => chartData.day,
              yValueMapper: (TempModel chartData, _) => chartData.date,
              name: 'Data',
              markerSettings: MarkerSettings(
                borderWidth: 0,
                isVisible: true,
              ),
              dataLabelSettings: DataLabelSettings(isVisible: true),
            )
          ],*/

class TempData {
  double temp;
  double day;
  TempData({required this.temp, required this.day});
}
