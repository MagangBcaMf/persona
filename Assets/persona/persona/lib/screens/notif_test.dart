import 'dart:collection';

import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persona/model/database_instance.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/eventList.dart';
import 'package:persona/screens/util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:persona/widgets/bottom_navbar.dart';

class Notifi extends StatefulWidget {
  const Notifi({Key? key}) : super(key: key);

  @override
  _NotifiState createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  late final LinkedHashMap<DateTime, List<Event>> babi = kEvents;
  List<Event> selectedEvents = [];
  List<dynamic> temp = [];
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


  List<Map<String, dynamic>> rows = [];
  @override
  void initState() {
    // TODO: implement initState
    // dbHelper.deleteAll();
    super.initState();
    init();
  }
  Future <void> init()async{
    rows = await dbHelper.queryAllRows();
    rows.forEach((row) {
      print("${row['id']} ${row['id_event']} ${row['isClicked']}");
    });
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
              return FutureBuilder(
                future: dbHelper.queryRowById(int.parse(event.id)), 
                builder: ((context, snapshot) {
                  int? isClicked;
                  print("nano${snapshot.data}");
                  if(snapshot.hasData == false){
                    print("${dbHelper.checkID(int.parse(event.id)).toString()}");
                    
                    dbHelper.insert({
                        'id_event': '${event.id}',
                        'isClicked': 0,
                      });
                    
                  }else isClicked = snapshot.data;
                    
                  // isClicked = 0;
                  // }else{
                  //   isClicked = snapshot.data;
                  // }         
                  return GestureDetector(
                    onTap: () async{
                      // Panggil fungsi dbHelper.update() di sini
                      int? babi = await dbHelper.getIdByEvent(int.parse(event.id));
                      print(babi);
                      await dbHelper.update({
                        'id' : babi!,
                        'id_event' : event.id, 
                        'isClicked': 1
                      }); // Misalnya, menandai event sebagai sudah diklik
                      setState(() {
                        // print(dbHelper.getIdByEvent(int.parse(event.id)));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isClicked == 1 ? Colors.white : Colors.blue[100],
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
                                    text: event.title,
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
                    ),
                  );

                })
              );
            },
          ),
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

