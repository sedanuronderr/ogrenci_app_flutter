import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app_flutter/repository/ogretmenler_repository.dart';

import 'model/ogretmen.dart';

class OgretmenlerSayfasi extends ConsumerWidget {

   OgretmenlerSayfasi( {super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Ögretmenler"),
      ),
      body: Column(
        children: [
           PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                    child: Text(

                        "${ogretmenlerRepository.ogretmenler.length} Öğretmen"
                    ),
                  ),
                ),


                Align(
                  alignment: Alignment.centerRight,
                  child: OgretmenIndirmeButon(),
                ),

              ],
            ),




          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => OgretmenSatiri(ogretmenlerRepository.ogretmenler[index],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: ogretmenlerRepository.ogretmenler.length,
            ),
          ),
        ],
      ),
    );
  }
}

class OgretmenIndirmeButon extends StatefulWidget {
  const OgretmenIndirmeButon({
    super.key,
  });

  @override
  State<OgretmenIndirmeButon> createState() => _OgretmenIndirmeButonState();
}

class _OgretmenIndirmeButonState extends State<OgretmenIndirmeButon> {

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context, ref, child) {
        return isLoading? CircularProgressIndicator(): IconButton(
          icon:  Icon(Icons.download),
          onPressed: () async {

            try {
              setState(() {
                isLoading = true;
              });
              await ref.read(ogretmenlerProvider).download();
            }finally{
              setState(() {
                isLoading = false;
              });
            }
          },
        );
      }
    );
  }
}

class OgretmenSatiri extends ConsumerWidget {
  Ogretmen ogretmen;

 OgretmenSatiri(this.ogretmen ,{
    super.key,
  });


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  ListTile(
      title: Text(ogretmen.ad + ' ' + ogretmen.soyad),
      leading: IntrinsicWidth(child: Center(child: Text(ogretmen.cinsiyet == 'Kadın' ? '👩‍🦰' : '👨‍🦰'))), //👨‍🦰
    );
  }
}
