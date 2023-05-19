import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';
import 'package:weatherweather/theme/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Provider/city_provider.dart';

class FiveDayDetails extends StatefulWidget {
  bool isSecondCity;
  double lat, long;
  FiveDayDetails(
      {required this.lat, required this.long, required this.isSecondCity});

  @override
  State<FiveDayDetails> createState() => _FiveDayDetailsState();
}

class _FiveDayDetailsState extends State<FiveDayDetails> {
  Constants myColor = Constants();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<TempData> tempDataMin = [
      TempData(
          temp: !widget.isSecondCity
              ? Provider.of<CityProvider>(context, listen: false).minTemp[0]
              : Provider.of<CityProvider2>(context, listen: false).minTemp[0],
          day: 1.0),
      TempData(
          temp: !widget.isSecondCity
              ? Provider.of<CityProvider>(context, listen: false).minTemp[1]
              : Provider.of<CityProvider2>(context, listen: false).minTemp[1],
          day: 2.0),
      TempData(
          temp: !widget.isSecondCity
              ? Provider.of<CityProvider>(context, listen: false).minTemp[2]
              : Provider.of<CityProvider2>(context, listen: false).minTemp[2],
          day: 3.0),
      TempData(
          temp: !widget.isSecondCity
              ? Provider.of<CityProvider>(context, listen: false).minTemp[3]
              : Provider.of<CityProvider2>(context, listen: false).minTemp[3],
          day: 4.0),
      TempData(
          temp: !widget.isSecondCity
              ? Provider.of<CityProvider>(context, listen: false).minTemp[4]
              : Provider.of<CityProvider2>(context, listen: false).minTemp[4],
          day: 5.0),
    ];
    List<int> windDirection = !widget.isSecondCity
        ? Provider.of<CityProvider>(context, listen: false).windDirection(
            Provider.of<CityProvider>(context, listen: false).degreeofWind)
        : Provider.of<CityProvider2>(context, listen: false).windDirection(
            Provider.of<CityProvider2>(context, listen: false).degreeofWind);

    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: !widget.isSecondCity
                ? Provider.of<CityProvider>(context, listen: false)
                    .weatherInfo!
                    .settingBgPicture()
                : Provider.of<CityProvider2>(context, listen: false)
                    .weatherInfo!
                    .settingBgPicture(),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: !widget.isSecondCity
                    ? Provider.of<CityProvider>(context, listen: false)
                        .weatherInfo!
                        .settingBgPicture()
                    : Provider.of<CityProvider2>(context, listen: false)
                        .weatherInfo!
                        .settingBgPicture(),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    colorScheme.secondary.withOpacity(0.6), BlendMode.srcOver)),
          )),
      Positioned(
        left: 10,
        top: size.height * .14,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface.withOpacity(0.4),
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
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: !widget.isSecondCity
                      ? Consumer<CityProvider>(
                          builder: ((context, value, child) => Container(
                                color: Colors.transparent,
                                width: size.width,
                                height: 100,
                                child: ListView.separated(
                                  padding: EdgeInsets.all(10),
                                  separatorBuilder: (context, index) =>
                                      (SizedBox(
                                    width: 52,
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
                              )))
                      : Consumer<CityProvider2>(
                          builder: ((context, value, child) => Container(
                                color: Colors.transparent,
                                width: size.width,
                                height: 100,
                                child: ListView.separated(
                                  padding: EdgeInsets.all(10),
                                  separatorBuilder: (context, index) =>
                                      (SizedBox(
                                    width: 52,
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
                        color: colorScheme.secondary.withOpacity(0.7),
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
                  child: !widget.isSecondCity
                      ? Consumer<CityProvider>(
                          builder: ((context, value, child) => Container(
                                height: 200,
                                child: ListView.separated(
                                  padding: EdgeInsets.all(12),
                                  separatorBuilder: (context, index) =>
                                      (SizedBox(
                                    width: 26,
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
                              )))
                      : Consumer<CityProvider2>(
                          builder: ((context, value, child) => Container(
                                height: 200,
                                child: ListView.separated(
                                  padding: EdgeInsets.all(12),
                                  separatorBuilder: (context, index) =>
                                      (SizedBox(
                                    width: 26,
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

class TempData {
  double temp;
  double day;
  TempData({required this.temp, required this.day});
}
