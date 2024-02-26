import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Pages/doa_detail.dart';
import 'package:quran_app/model/doa_model.dart';
import 'package:quran_app/viewmodel/doa_viewmodel.dart';

class TabDoa extends StatelessWidget {
  const TabDoa({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final DoaViewmodel _viewModel = DoaViewmodel();

    return FutureBuilder<List<ListDoa>>(
        future: _viewModel.getListDoa(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Tidak Ada Data"),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) => _doaCard(
                  context: context, dzikir: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(0.1),
                    height: 1,
                  ),
              itemCount: snapshot.data!.length);
        });
  }

  Widget _doaCard({required BuildContext context, required ListDoa dzikir}) => InkWell(
        onTap: () {
         Navigator.pushNamed(context, DoaDetail.routeName,
              arguments: dzikir.nomor.toString());
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffdf98fa), Color(0xFF9055FF)],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  dzikir.nama.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        
      );
}
