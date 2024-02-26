import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/model/dzikir_detail_model.dart';
import 'package:quran_app/viewmodel/dzikir_detail_viewmodel.dart';

class DzikirDetail extends StatelessWidget {
  static const routeName = 'dzikir_detail';
  final String id_dzikir;
  const DzikirDetail({Key? key, required this.id_dzikir}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DzikirDetailViewModel _viewModel = DzikirDetailViewModel();
    return Scaffold(
        appBar: AppBar(
        ),
        body: FutureBuilder(
          future: _viewModel.getListDzikirDetail(id_dzikir),
          builder: (context, AsyncSnapshot<DzikirDetailModel?> snapshot) {
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
                              itemBuilder: (context, index) => _dzikirDetail(
                                  context: context,
                                  dzikir:
                                      snapshot.data!.dzikir!.elementAt(index)),
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                    height: 1,
                                  ),
                              itemCount: snapshot.data!.dzikir!.length)
                          : Center(child: Text('No data available')),
            );
          },
        ));
  }

  Widget _dzikirDetail(
          {required BuildContext context, required DzikirModelDetail dzikir}) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dzikir.title.toString(),
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    dzikir.arabic.toString(),
                    style: GoogleFonts.amiriQuran(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 2.4,
                        color: Colors.black),
                    textAlign: TextAlign.end,
                  ),
                ),
                SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dzikir.latin.toString(),
                      style: GoogleFonts.amiri(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      dzikir.translation.toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      );
}
