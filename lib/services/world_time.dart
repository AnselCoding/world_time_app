import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {
    try{
      var uri =
      Uri.http('worldtimeapi.org', '/api/timezone/$url');

      Response response = await get(uri);
      // make the request
      // Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      print(now);

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      print(isDaytime);
      // time = now.toString();
      time = DateFormat.jm().format(now);
      print(time);
    }
    catch (e) {
      print(e);
      time = 'could not get time';
    }
  }

  Future <void> getCertificate() async {
    var url = Uri.parse('http://10.0.2.2:8059/api/Document/GetCertificate?certId=001');
    // Uri.http('zh16.zhtech.com.tw', '/api/Document/GetCertificate',{'certId':'001'});
    // Uri.http('10.0.2.2:8059', '/api/Document/GetCertificate',{'certId':'001'});

    print(url);

    Response response = await get(url);
    Map data = jsonDecode(response.body);
    print(data);
    print(data['message']);
  }

  Future <void> setPersonAppScore() async {
    var url = Uri.parse('http://10.0.2.2:8059/api/ExamPerson/SetPersonAppScore');
    print(url);
    var para = [{
      "outId": 0,
      "pId": "string",
      "quesSerial": 0,
      "appScoreSingle": 0
    }];
    var body = json.encode(para);

    Response response = await post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body);

    Map data = jsonDecode(response.body);
    print(data);
    print(data['message']);
  }
}


