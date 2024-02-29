import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/home_screen.dart';

class ApprovalListScreen extends StatefulWidget {
  const ApprovalListScreen({Key? key}) : super(key: key);

  @override
  _ConnectionCheckScreenState createState() => _ConnectionCheckScreenState();
}

class _ConnectionCheckScreenState extends State<ApprovalListScreen> {
  List<dynamic> approvalData = [];
  Repository repository = Repository();

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Data'),
          content: Column(
            children: [
              TextField(
                controller: _startDateController,
                decoration:
                    InputDecoration(labelText: 'Start Date (dd-mm-yyyy)'),
              ),
              TextField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date (dd-mm-yyyy)'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi filterDataByDateRange dengan input dari TextField
                setState(() {
                  if (_startDateController.text.isNotEmpty &&
                      _endDateController.text.isNotEmpty) {
                    approvalData = filterDataByDateRange(
                      approvalData,
                      _startDateController.text,
                      _endDateController.text,
                    );
                  } else {
                    // Jika kedua field kosong, tampilkan semua data
                    postUserData();
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Filter'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    postUserData();
    // fetchData();
  }

  Future<void> postUserData() async {
    const url = 'http://10.10.12.47/persona-api-pub/Bmia/log';
    final uri = Uri.parse(url);

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

    // if (response.statusCode == 200) {
    //   setState(() {
    //     approvalData = jsonDecode(response.body);
    //     if (_startDateController.text.isNotEmpty && _endDateController.text.isNotEmpty) {
    //       approvalData = filterDataByDateRange(approvalData, _startDateController.text, _endDateController.text);
    //     }
    //   });
    //   print('POST request successful ${response.statusCode}');
    // } else {
    //   print('POST request failed with status: ${response.statusCode}');
    //   print('Error message: ${response.body}');
    // }
    if (response.statusCode == 200) {
      setState(() {
        approvalData = jsonDecode(response.body);
      });
      print('POST request successful ${response.statusCode}');
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

  List<dynamic> filterDataByDateRange(
      List<dynamic> data, String startDate, String endDate) {
    final dateFormatter = DateFormat("dd-MM-yyyy");

    return data.where((item) {
      final itemDate = dateFormatter.parse(item['dateCreated']);
      final startDateTime = dateFormatter.parse(startDate);
      final endDateTime = dateFormatter.parse(endDate);

      return itemDate.isAfter(startDateTime.subtract(Duration(days: 1))) &&
          itemDate.isBefore(endDateTime.add(Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bghome.png"), fit: BoxFit.cover),
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  icon: Icon(CupertinoIcons.arrow_left),
                ),
                backgroundColor: Colors.transparent,
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Text('personA'),
                ),
                titleTextStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(CupertinoIcons.slider_horizontal_3),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      _showDialog();
                    },
                  ),
                ],
                leadingWidth: 50,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final screenHeight = MediaQuery.of(context).size.height;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (approvalData != null)
                          Container(
                            height: screenHeight,
                            child: ListView.builder(
                              itemCount: approvalData.length,
                              itemBuilder: (context, index) {
                                final user = approvalData[index];
                                final approval = user['activityId'];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  height: 50,
                                  child: ListTile(
                                    title: Text(approval),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
