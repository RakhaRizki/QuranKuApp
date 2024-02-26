import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Pages/home_screen.dart';
import 'package:quran_app/model/ayah_model.dart';
import 'package:quran_app/viewmodel/ayah_viewmodel.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail_screen';
  final String id_surah;
  final String nama_surah;
  const DetailScreen({Key? key, required this.id_surah, required this.nama_surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AyahViewModel _viewModel = AyahViewModel();
    return Scaffold(
        appBar: AppBar(title: Text(nama_surah)),
        body: FutureBuilder(
          future: _viewModel.getListAyah(id_surah),
          builder: (context, AsyncSnapshot<AyahModel?> snapshot) {
            return Container(
              color: Colors.white,
              child: snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : snapshot.hasError
                      ? Center(
                          child: Text('Error: ${snapshot.error}'),
                        )
                      : snapshot.hasData
                          ? ListView.separated(
                              itemBuilder: (context, index) => _ayahList(
                                  context: context,
                                  ayatModel: snapshot.data!,
                                  ayat: snapshot.data!.ayat!.elementAt(index)),
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey.withOpacity(0.1),
                                    height: 1,
                                  ),
                              itemCount: snapshot.data!.ayat!.length)
                          : Center(child: Text('No data available')),
            );
          },
        ));
  }

  Widget _ayahList(
          {required BuildContext context,
          required AyahModel ayatModel,
          required Ayat ayat}) =>
      InkWell(
        onTap: () {
          _showLastReadDialog(context, ayatModel, ayat);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Row(children: [
            Stack(
              children: [
                SvgPicture.asset('assets/svg/nomor_surah.svg'),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Center(
                    child: Text(
                      ayat.nomor.toString(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ayat.ar.toString(),
                      style: GoogleFonts.amiriQuran(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ayat.tr.toString(),
                    style: GoogleFonts.amiri(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        color: Colors.grey),
                  ),
                  Text(
                    ayat.idn.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          ]),
        ),
      );

  Future<void> _showLastReadDialog(
      BuildContext context, AyahModel ayatModel, Ayat ayat) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Options"),
          content: Text("Do you want to mark this Ayah as the last read?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName, arguments: {
                  'surah': ayatModel.namaLatin.toString(),
                  'nomor': ayat.nomor.toString()
                });
              },
              child: Text("Mark as Last Read"),
            ),
          ],
        );
      },
    );
  }
}
