import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHandler{
  final String apiKey = 'fe740ea5d9d67c189b1b6cb99e15d340';
  final String city;
  String? apiLink;

  NetworkHandler({required this.city}){
    this.apiLink = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';
  }

  Future<double> getTemp() async {
    http.Response response = await http.get(Uri.parse(apiLink!));
    Map map = convert.jsonDecode(response.body);
    double temp = map['main']['temp'] - 273.0;
    return temp;
  }

}