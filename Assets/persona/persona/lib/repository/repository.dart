import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:persona/model/model.dart';
import 'package:crypto/crypto.dart';
class Event {
  String title;
  String time;
  String location;
  String reminder;
  String notes;
  DateTime date;

  Event({
    required this.title,
    required this.time,
    required this.location,
    required this.reminder,
    required this.notes,
    required this.date,
  });
}
class Repository {
  final baseUrl = 'http://10.10.6.35/api_pesona/api.php';

  Future<List<Event>> get() async {
    try{
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        print('2');
        final data = json.decode(response.body);
        List<Event> events = [];
        for (var item in data) {
          DateTime temp_date = DateTime.parse(item['eventDate']);

          DateTime eventDate = DateTime(
                  temp_date.year,
                  temp_date.month,
                  temp_date.day,
          );
          
          Event newEvent = Event(
            title: item['title'],
            time: item['time'],
            location: item['location'],
            reminder: item['reminder'],
            notes: item['notes'],
            date: eventDate,
          );
          events.add(newEvent);
        }
        return events;
      }else {
        throw Exception('Failed to load events');
      }
    }
    catch (e) {
      print('Error: $e');
      return []; // Return an empty list in case of an error
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

  Future<List<dynamic>> postUserData() async {
    print('postUserData called');
    final uri = Uri.parse(baseUrl);

    final Map<String, dynamic> requestBody = {
      'username': 'ichsan.surya',
      'password': 'P@ssw0rd',
      'signature': '5ca156437db03ceb85e802ada0d861a93f22971e',
    };
    final response = await http.post(
      uri,
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('POST request successful ${response.statusCode}');
      print('Response : ${response.body}');
      return jsonDecode(response.body);
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
    print('postUserData completed');
    throw Exception('Error');
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
