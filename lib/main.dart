import 'package:flutter/material.dart';
import 'package:quran_app/Pages/detail_screen.dart';
import 'package:quran_app/Pages/doa_detail.dart';
import 'package:quran_app/Pages/dzikir_detail.dart';
import 'package:quran_app/Pages/home_screen.dart';
import 'package:quran_app/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      initialRoute: HomeScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is Map<String, String>) {
            final surah = arguments['surah'];
            final nomor = arguments['nomor'];
            return HomeScreen(lastReadAyat: nomor, lastReadSurah: surah);
          } else {
            // Handle the case when arguments is not a Map
            return HomeScreen(lastReadAyat: "1", lastReadSurah: "Al-Fatihah");
          }
        },
        DetailScreen.routeName: (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is Map<String, String>) {
            final idSurah = arguments['id_surah']!;
            final namaSurah = arguments['nama_surah']!;
            return DetailScreen(id_surah: idSurah, nama_surah: namaSurah);
          } else {
            // Handle the case when arguments is not a Map
            return DetailScreen(id_surah: "1", nama_surah: "Al-Fatihah");
          }
        },
        DzikirDetail.routeName: (context) => DzikirDetail(
              id_dzikir: ModalRoute.of(context)?.settings.arguments as String,
            ),
        DoaDetail.routeName: (context) => DoaDetail(
            id_doa: ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}
