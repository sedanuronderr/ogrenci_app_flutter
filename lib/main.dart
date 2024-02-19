import 'package:flutter/material.dart';
import 'package:ogrenci_app_flutter/mesajlar_sayfasi.dart';
import 'package:ogrenci_app_flutter/ogrenciler_sayfasi.dart';
import 'package:ogrenci_app_flutter/ogretmenler_sayfasi.dart';
import 'package:ogrenci_app_flutter/repository/mesajlar_repository.dart';
import 'package:ogrenci_app_flutter/repository/ogrenciler_repository.dart';
import 'package:ogrenci_app_flutter/repository/ogretmenler_repository.dart';

void main() {
  runApp(const OgrenciApp());
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ogrenci Uygulaması',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnaSayfa(title: "Ogrenci Sayfa"),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  MesajlarRepository mesajlarRepository = MesajlarRepository();
  OgrencilerRepository ogrencilerRepository = OgrencilerRepository();
  OgretmenlerRepository ogretmenlerRepository = OgretmenlerRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: Text('${mesajlarRepository.mesajlar.length} yeni mesaj'),
              onPressed: () {
                _mesajlaraGit(context);
              },
            ),
            TextButton(
              child: Text('${ogrencilerRepository.ogrenciler.length} öğrenci'),
              onPressed: () {
                _ogrencilereGit(context);
              },
            ),
            TextButton(
              child: Text('${ogretmenlerRepository.ogretmenler.length} öğretmen'),
              onPressed: () {
                _ogretmenlereGit(context);
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Öğrenci adı'),
            ),
            ListTile(
              title: const Text('Öğrenciler'),
              onTap: () {
                _ogrencilereGit(context);
              },
            ),
            ListTile(
              title: const Text('Öğretmenler'),
              onTap: () {
                _ogretmenlereGit(context);
              },
            ),
            ListTile(
              title: const Text('Mesajlar'),
              onTap: () {
                _mesajlaraGit(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _ogrencilereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OgrencilerSayfasi(ogrencilerRepository);
    },));
  }

  void _ogretmenlereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OgretmenlerSayfasi(ogretmenlerRepository);
    },));
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Mesajlar(mesajlarRepository);
    },));
    setState(() {
    });
  }

}