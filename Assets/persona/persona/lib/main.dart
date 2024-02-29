import 'package:flutter/material.dart';
import 'package:persona/screens/change_password_screen.dart';
import 'package:persona/screens/home_screen.dart';
import 'package:persona/screens/approval_screen.dart';
import 'package:persona/screens/news_detail_screen.dart';
import 'package:persona/screens/notification_screen.dart';
import 'package:persona/screens/onboarding_screen.dart';
import 'package:persona/screens/splash_screen.dart';
import 'package:persona/screens/login_screen.dart';
import 'package:persona/screens/learning_screen.dart';
import 'package:persona/screens/learning_keuangan_screen.dart';
import 'package:persona/screens/kamus_keuangan_screen.dart';
import 'package:persona/screens/produk_keuangan_screen.dart';
import 'package:persona/screens/profile_screen.dart';
import 'package:persona/screens/instruksi_keuangan_screen.dart';
import 'package:persona/screens/introduction_keuangan.dart';
import 'package:persona/screens/reminder_screen.dart';
import 'package:persona/screens/add_event_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/home',
      routes: {
        '/': (context) => HomeScreen(), 
        // '/': (context) => ApprovalListScreen(),
        '/home': (context) => HomeScreen(),
        '/intro': (context) => OnBoardingScreen(),
        '/approval': (context) => ApprovalListScreen(),
        '/news_detail': (context) => NewsDetailsScreen(),
        '/login': (context) => LoginScreen(),
        // '/reminder': (context) => ReminderScreen(),
        '/learning': (context) => LearningScreen(),
        '/keuangan': (context) => LearningKeuanganScreen(),
        // '/operasional': (context) => LearningOperasionalScreen(),
        // '/penagihan': (context) => LearningPenagihanScreen(),
        // '/risiko': (context) => LearningRisikoScreen(),
        // '/penjualan': (context) => LearningPenjualanScreen(),
        // '/bispro': (context) => LearningBisproScreen(),
        '/produkKeuangan': (context) => ProdukKeuanganScreen(),
        '/kamusKeuangan': (context) => KamusKeuanganScreen(),
        '/pelatihanKeuangan': (context) => InstruksiKeuanganScreen(),
        '/instruksiKeuangan': (context) => InstruksiKeuanganScreen(),
        '/introductionKeuangan': (context) => IntroductionKeuanganScreen(),
        '/profile': (context) => ProfileScreen(),
        '/reminder': (context) => CalendarScreen(),
        // '/reminderAdd': (context) => AddEventScreen(selectedDay: DateTime.now()),
        '/notification': (context) => NotificationScreen(),
        '/change_password': (context) => ChangePasswordScreen(),
      },
    );
  }
}
