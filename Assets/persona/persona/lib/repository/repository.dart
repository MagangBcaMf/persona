import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:persona/model/model.dart';
import 'package:crypto/crypto.dart';

class Repository {
  final baseUrl = 'https://10.10.12.47/persona-api-pub/Bmia/log';

  Future<List<Approval>> getData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      List<Approval> approvals =
          data.map((json) => Approval.fromJson(json)).toList();
      print(response.body);
      return approvals;
    } else {
      throw Exception('Failed to load data');
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
