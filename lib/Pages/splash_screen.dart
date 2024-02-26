import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Pages/home_screen.dart';
import 'package:quran_app/theme.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = 'splash_screen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "QuranKu",
                style: GoogleFonts.poppins(
                    fontSize: 28, color: primary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Text("Learn Quran And \nRecite once everyday",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: secondary,
                  )),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 450,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SvgPicture.asset("assets/svg/splash.svg"),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -20,
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 45, vertical: 12),
                          decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
