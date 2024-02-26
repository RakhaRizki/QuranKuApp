import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Pages/dzikir_detail.dart';
import 'package:quran_app/model/dzikir_model.dart';
import 'package:quran_app/viewmodel/dzikir_viewmodel.dart';

class TabDzikir extends StatelessWidget {
  const TabDzikir({super.key});

  @override
  Widget build(BuildContext context) {
    final DzikirViewmodel _viewModel = DzikirViewmodel();

    return FutureBuilder<List<Dzikir>>(
        future: _viewModel.getListDzikir(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Tidak Ada Data"),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) => _dzikirCard(
                  context: context, dzikir: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(0.1),
                    height: 1,
                  ),
              itemCount: snapshot.data!.length);
        });
  }

  Widget _dzikirCard({required BuildContext context, required Dzikir dzikir}) =>
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, DzikirDetail.routeName,
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
