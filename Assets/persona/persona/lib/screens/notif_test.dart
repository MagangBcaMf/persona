import 'dart:collection';

import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persona/controller/notify.dart';
import 'package:persona/model/database_instance.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/eventList.dart';
import 'package:persona/controller/util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:persona/widgets/bottom_navbar.dart';

class Notifi extends StatefulWidget {
  const Notifi({Key? key}) : super(key: key);

  @override
  _NotifiState createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  List<Map<String, dynamic>> rows = [] ;
  late final LinkedHashMap<DateTime, List<Event>> babi = kEvents;
  List<Event> selectedEvents = [];
  List<dynamic> temp = [];
  int? isCLicked;
  final dbHelper = DatabaseHelper();
   int _selectedIndex = 5;
    void _onItemTapped(int index) {
      if (index != _selectedIndex) {
        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/reminder');
            break;
          case 2:
            Navigator.pushNamed(context, '/learning');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      }
    }

  Future <void> init()async{
    await dbHelper.initDb();
    rows = await dbHelper.queryAllRows();
    print("dari rows $rows");

    // List<int> babi = await dbHelper.getallID(73);
    // print(babi);
    // print("${babi[1]} ${babi[0]}");
    // print(babi.length);
  }
  @override
  void initState() {
    // TODO: implement initState
    // dbHelper.deleteAll();
    // init();
    Notify().initState();
    super.initState();
  }
  
  DateTime mergeDateandTime (DateTime date, String time){
    List<String> splitTime = time.split(':');
    int hour = int.parse(splitTime[0]);
    int minute = int.parse(splitTime[1]);

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<Event> upcomingEvents = [];

    babi.values.forEach((events) {
      events.forEach((event) {
        List<String> time = event.time.split(':');
        List<String> parts = event.reminder.split(' ');
        // Ambil angka dari string dan ubah menjadi integer
        int minute = int.parse(parts[0]);
        DateTime temp = DateTime(event.date.year, event.date.month, event.date.day, int.parse(time[0]),(int.parse(time[1])-minute));
        if (temp.isBefore(now)) {
          upcomingEvents.add(event);
        }
      });
    });
    upcomingEvents.sort((a, b) => -(a.time.compareTo(b.time)));
    upcomingEvents.sort((a, b) => -(a.date.compareTo(b.date)));
    Widget BottomNavBar() {
      return CustomLineIndicatorBottomNavbar(
        selectedColor: Color(0xff7da0ca),
        unSelectedColor: Colors.black54,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,
        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Beranda',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Jadwal',
            icon: CupertinoIcons.bell_fill,
          ),
          CustomBottomBarItems(
              label: 'Pembelajaran', icon: CupertinoIcons.book_solid),
          CustomBottomBarItems(
            label: 'Profil',
            icon: Icons.person_rounded,
          ),
        ],
      );
    }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notification Screen'),
        backgroundColor: Color(0xff7da0ca),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bghome.png"), fit: BoxFit.fill),
          ),
          child: Padding(
          padding: EdgeInsets.only(top: 10),
          child:  ListView.builder (
            itemCount: upcomingEvents.length,
            itemBuilder: (context, index) {
              Event event = upcomingEvents[index];
              int test = int.parse(event.id);
              return FutureBuilder(
                future: dbHelper.checkData(test), 
                builder: (context, snapshot) {
                  // dbHelper.queryRowById(int.parse(event.id)).then((existingData) {
                  //   if(existingData == null) {
                  //     // Jika tidak ada data dengan ID event yang sama, masukkan ke dalam database

                  //     print('babi');
                  //   } else {
                  //     // Jika data sudah ada, tidak perlu melakukan apa-apa
                  //   }
                  // });
                  // print(event.id);
                  // print("${event.date} ${event.time}");
                  if(snapshot.data == false ){
                    DateTime now = DateTime.now();
                    DateTime tempTime = mergeDateandTime(event.date, event.time);
                    if(now.isAtSameMomentAs(tempTime) || now.isAfter(tempTime)){
                      dbHelper.insert({
                        'id_event' : int.parse(event.id),
                        'isClicked' : 0
                      });
                    }
                    
                  }else if(snapshot.data == null){
                    // return CircularProgressIndicator();
                  }
                  return FutureBuilder(
                    future: dbHelper.queryRowById(test), 
                    builder: (context, isClick) {
                      if(isClick.data == null){
                        // return CircularProgressIndicator();
                      }else{
                        isCLicked = isClick.data;
                      }

                      return GestureDetector(
                        onTap: () async {
                          // Panggil fungsi dbHelper.update() di sini
                          List<int> temp = await dbHelper.getallID(int.parse(event.id));
                          if(temp.length == 2){
                            dbHelper.delete(temp[1]);
                          }
                          await dbHelper.update({
                            'id' : await dbHelper.getIdByEvent(int.parse(event.id)),
                            'id_event': event.id,
                            'isClicked': 1,
                          }); // Misalnya, menandai event sebagai sudah diklik
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: isCLicked == 1 ? Colors.white : Colors.blue[100],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: ('${event.title} ${event.id}'),
                                        style: TextStyle(
                                          color: Colors.black, // warna teks
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5), // Spacer
                              Container(
                                height: 1, // Tinggi garis bawah
                                color: Colors.black, // Warna garis bawah
                              ),
                              SizedBox(height: 10), // Spacer
                              Text(
                                '${event.notes}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10), // Spacer
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${event.date.day}/${event.date.month}/${event.date.year} ${event.time}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          )
                        )
                      );
                      
                      
                    }
                  );
                }
              );
              
            })
          )
        )
      ),
    bottomNavigationBar: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomNavBar(),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
      ],
    ),
    );
  }

}

