class FiveDayForcastData {
  double temp_min;

  int date;
  String description;
  String icon;
  double wind;
  int degreeofWind;

  FiveDayForcastData(
      {required this.temp_min,
      required this.date,
      required this.description,
      required this.icon,
      required this.degreeofWind,
      required this.wind});
}
//json['list'][index] as we can see unlike in other cases, here an index  is needed to loop through each day..so we implement this in service page(fivedayservice)