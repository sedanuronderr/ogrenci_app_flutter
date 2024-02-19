import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogrenci_app_flutter/repository/ogretmenler_repository.dart';

class OgretmenlerSayfasi extends StatefulWidget {
  final OgretmenlerRepository ogretmenlerRepository;

   OgretmenlerSayfasi( this.ogretmenlerRepository, {super.key});

  @override
  State<OgretmenlerSayfasi> createState() => _OgretmenlerSayfasiState();
}

class _OgretmenlerSayfasiState extends State<OgretmenlerSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ögretmenler"),
      ),
      body: Column(
        children: [
           PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                child: Text(

                    "${widget.ogretmenlerRepository.ogretmenler.length} Öğretmen"
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => OgretmenSatiri(widget.ogretmenlerRepository.ogretmenler[index],
                widget.ogretmenlerRepository,),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: widget.ogretmenlerRepository.ogretmenler.length,
            ),
          ),
        ],
      ),
    );
  }
}

class OgretmenSatiri extends StatefulWidget {
  Ogretmen ogretmen;
  OgretmenlerRepository ogretmenlerRepository;
 OgretmenSatiri(this.ogretmen, this.ogretmenlerRepository, {
    super.key,
  });

  @override
  State<OgretmenSatiri> createState() => _OgretmenSatiriState();
}

class _OgretmenSatiriState extends State<OgretmenSatiri> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(widget.ogretmen.ad + ' ' + widget.ogretmen.soyad),
      leading: IntrinsicWidth(child: Center(child: Text(widget.ogretmen.cinsiyet == 'Kadın' ? '👩‍🦰' : '👨‍🦰'))), //👨‍🦰
    );
  }
}
