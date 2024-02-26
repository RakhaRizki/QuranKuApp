import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/model/doa_detail_model.dart';
import 'package:quran_app/viewmodel/doa_detail_viewmodel.dart';

class DoaDetail extends StatelessWidget {
  static const routeName = 'doa_detail.dart';
  final String id_doa;
  const DoaDetail({Key? key, required this.id_doa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoaDetailViewmodel _viewModel = DoaDetailViewmodel();
    return Scaffold(
        appBar: AppBar(
        ),
        body: FutureBuilder(
          future: _viewModel.getListDoaDetail(id_doa),
          builder: (context, AsyncSnapshot<DoaDetailModel?> snapshot) {
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
                              itemBuilder: (context, index) => _doaDetail(
                                  context: context,
                                  doa:
                                      snapshot.data!.doa!.elementAt(index)),
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                    height: 1,
                                  ),
                              itemCount: snapshot.data!.doa!.length)
                          : Center(child: Text('No data available')),
            );
          },
        ));
  }

  Widget _doaDetail(
          {required BuildContext context, required Doa doa}) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doa.title.toString(),
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
                    doa.arabic.toString(),
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
                      doa.latin.toString(),
                      style: GoogleFonts.amiri(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      doa.translation.toString(),
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

