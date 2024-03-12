import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:persona/model/local_notifications.dart';
import 'package:persona/model/model.dart';
import 'package:crypto/crypto.dart';
class Event {
  String id;
  String title;
  String time;
  String location;
  String reminder;
  String notes;
  DateTime date;

  Event({
    required this.id,
    required this.title,
    required this.time,
    required this.location,
    required this.reminder,
    required this.notes,
    required this.date,
  });
}

class Repository {
  static const String baseUrl = 'http://10.10.6.78/api_pesona/api.php';
  static Future<Map<DateTime, List<Event>>> fetchEvents() async {
    // listenToNotifications(){
    //   print("Listening to notification");
    //   LocalNotifications.onClickNotification.stream.listen((event) {
    //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> AnotherPage(payload : event)));
    //   });
    // }
    try {
      final response = await http.get(Uri.parse(baseUrl));
      StringtoDate (DateTime Date, String time){
        List<String> timeParts = time.split(':');

        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

          DateTime eventTime = DateTime(Date.year, Date.month, Date.day, hour, minute);
          return eventTime;
      }
      ReminderPicker (String reminder){
        List<String> parts = reminder.split(' ');
        // Ambil angka dari string dan ubah menjadi integer
        int minutesBefore = int.parse(parts[0]);
        return minutesBefore;
      }
      if (response.statusCode == 200) {
        Map<DateTime, List<Event>> events = {};

        final data = json.decode(response.body);

        for (var item in data) {
          DateTime tempDate = DateTime.parse(item['eventDate']);
          DateTime eventDate = DateTime(
            tempDate.year,
            tempDate.month,
            tempDate.day,
          );
          
          Event newEvent = Event(
            id : item['id'],
            title: item['title'],
            time: item['time'],
            location: item['location'],
            reminder: item['reminder'],
            notes: item['notes'],
            date: eventDate,
          );
          
          if (events.containsKey(eventDate)) {
            bool eventExists = events[eventDate]!.any((event) =>
                event.time == newEvent.time &&
                event.title == newEvent.title &&
                event.location == newEvent.location &&
                event.reminder == newEvent.reminder &&
                event.notes == newEvent.notes);

            if (!eventExists) {
              events[eventDate]!.add(newEvent);
            }
          } else {
            events[eventDate] = [newEvent];
          }
          DateTime temp = StringtoDate(newEvent.date, newEvent.time);
          DateTime now = DateTime.now();
          int remin = ReminderPicker(newEvent.reminder);
          if(now.isBefore(temp)){
            if(remin == 0){
              LocalNotifications.showSchedulledNotification(
                title: newEvent.title, 
                body: "${newEvent.title}dimulai $remin menit lagi", 
                payload: "abc", 
                time: temp);
            }else{
              LocalNotifications.showSchedulledNotification(
                title: newEvent.title, 
                body: "${newEvent.title} dimulai $remin menit lagi", 
                payload: "abc", 
                time: temp.subtract(Duration(minutes:remin))
              );
              
              LocalNotifications.showSchedulledNotification(
                title: newEvent.title, 
                body: "${newEvent.title} dimulai", 
                payload: "abc", 
                time: temp
              );
            };
              
          }

        }

        return events;
      } else {
        throw Exception('Failed to fetch events');
      }
    } catch (e) {
      print('Error fetching events: $e');
      rethrow; // Rethrow the exception to handle it in the calling code
    }
  }
  // Future getData() async {
  //   try {
  //     final response = await http.get(Uri.parse(baseUrl));

  //     if (response.statusCode == 200) {
  //       // print(response.body);
  //       Iterable it = jsonDecode(response.body);
  //       List<Approval> approval = it.map((e) => Approval.fromJson(e)).toList();
  //       return approval;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   // throw Exception('Failed to load data');
  // }

  // Future<Approval> postData(
  //     String username, String password, String signature) async {
  //   final response = await http.post(Uri.parse(baseUrl), body: {
  //     "username": "ichsan.surya",
  //     "password": "P@ssw0rd",
  //     "signature": "5ca156437db03ceb85e802ada0d861a93f22971e"
  //   });

  //   return Approval.fromJson(
  //     jsonDecode(response.body),
  //   );
  // try {
  //   if (response.statusCode == 200) {
  //     // await getData();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // } catch (e) {
  //   print(e.toString());
  // }
  // }

  Future<void> addEvent(Map<String, String> data) async {
    final response = await http.post(Uri.parse(baseUrl), body: data);

    if (response.statusCode == 200) {
      print('Event successfully added!');
    } else {
      print('Failed to add event. Please try again.');
    }
  }
}

// usercode : A0001
// password : testing1

class LoginRepository {
  final loginBaseUrl = 'http://10.10.12.88/um_srvc_pub/Auth/login';
  final String applicationId = '15';
  final String uniqueCode = 'U5312MGMT';
  static String? username;
  static String? nik;

  String generateSHA1Hash(String usercode) {
    List<int> bytes = utf8.encode(usercode);
    Digest sha1Hash = sha1.convert(bytes);

    return sha1Hash.toString();
  }

  Future<bool> login(String usercode, String password) async {
    String paramRequest = base64Encode(utf8.encode('''
{
    "user_code" : "$usercode",
    "application_id" : "$applicationId",
    "password" : "$password"
}'''));

    String signature = generateSHA1Hash(usercode + uniqueCode);

    final Map<String, dynamic> requestBody = {
      "signature": "$signature",
      "paramRequest": "$paramRequest",
    };

    final response = await http.post(
      Uri.parse(loginBaseUrl),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // successful login

      print(response.body);
      Map<String, dynamic> obj = json.decode(response.body);
      username = obj["DATA"]["user_name"];
      nik = obj["DATA"]["user_code"];
      // print(username);
      // print(nik);
      return true;
    } else {
      // failed login
      return false;
    }
  }

  Future<void> logout() async {
    // logout logic (clear authentication tokens, etc.)
    print('Logout successful');
  }
}
