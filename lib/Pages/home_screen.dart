import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Component/tab_item.dart';
import 'package:quran_app/Pages/Tabs/doa_tab.dart';
import 'package:quran_app/Pages/Tabs/dzikir_tab.dart';
import 'package:quran_app/Pages/Tabs/surah_tab.dart';
import 'package:quran_app/Pages/detail_screen.dart';
import 'package:quran_app/model/surah_model.dart';
import 'package:quran_app/theme.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home_screen';
  final String? lastReadSurah;
  final String? lastReadAyat;
  const HomeScreen(
      {Key? key, required this.lastReadAyat, required this.lastReadSurah})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchValue = '';
  final List<Surah> _suggestions = [];

  Future<List<Surah>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    // Replace the below line with the actual path to your JSON file
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/list-surah.json');

    List<dynamic> jsonList = json.decode(jsonString);

    _suggestions.clear(); // Clear previous suggestions
    _suggestions.addAll(jsonList.map((json) => Surah.fromJson(json)));

    return _suggestions.where((element) {
      return element.nama_latin
          .toLowerCase()
          .contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  EasySearchBar _appBar() => EasySearchBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'QuranKu',
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w600, color: primary),
          ),
        ),
        onSearch: (value) => setState(() => searchValue = value),
        asyncSuggestions: (value) async {
          List<Surah> suggestions = await _fetchSuggestions(value);
          return suggestions.map((surah) => surah.nama_latin).toList();
        },
        onSuggestionTap: (value) async {
          Surah selectedSurah = (await _fetchSuggestions(value))
              .firstWhere((surah) => surah.nama_latin == value);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(
            context,
            DetailScreen.routeName,
            arguments: {
              'id_surah': selectedSurah.nomor.toString(),
              'nama_surah': selectedSurah.nama_latin.toString()
            },
          );
        },
      );

  DefaultTabController _body() => DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: _salam(),
            ),
            SliverAppBar(
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              shape: Border(
                  bottom: BorderSide(
                width: 3,
                color: Colors.grey.withOpacity(0.5),
              )),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: TabBar(
                    labelColor: primary,
                    indicatorColor: primary,
                    indicatorWeight: 3,
                    tabs: [
                      itemTab(label: "Surah"),
                      itemTab(label: "Dzikir"),
                      itemTab(label: "Doa")
                    ]),
              ),
            )
          ],
          body: TabBarView(children: [TabSurah(), TabDzikir(), TabDoa()]),
        ),
      ));
  Column _salam() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assalamualaikum",
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w600, color: secondary),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'RakRiz',
            style: GoogleFonts.poppins(
                fontSize: 28, fontWeight: FontWeight.bold, color: primary),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                height: 131,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffdf98fa), Color(0xff9055ff)],
                    )),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset('assets/svg/quran_banner.svg'),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/book.svg'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Last Read",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.lastReadSurah ?? 'Not Assigned',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      "Ayat: ${widget.lastReadAyat ?? 'Not Assigned'}",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      );
}
