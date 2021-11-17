import 'package:webapi/data/web_api_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Service {
  Future<WebApiModel> getWebApi(dynamic link) async {
    String url = link == null
        ? "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=201bb53c584140af889730bdfb3c9001"
        : link;
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      print(jsonResponse);
      print("đổ thanh công");
      return WebApiModel.fromJson(jsonResponse);
    } else {
      print('EEEEE');
      throw Exception();
    }
  }
}
   
  // Future<WebApiModel> fetchDataTesla(dynamic s) async {
  //   String url = s == null
  //       ? "https://newsapi.org/v2/everything?q=tesla&from=2021-10-14&sortBy=publishedAt&apiKey=f650a93f63634105a75a352e57de91ec"
  //       : s;
  //   var reponse = await http.get(Uri.parse(url));
  //   if (reponse.statusCode == 200) {
  //     var jsonData = json.decode(reponse.body);
  //     print(jsonData);
  //     WebApiModel tl = WebApiModel.fromJson(reponse.body);
  //     print(tl);
  //     return tl;
  //   } else {
  //     return throw Exception('Không có dữ liệu');
  //   }
  // }


