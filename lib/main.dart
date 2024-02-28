import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app_flutter/mesajlar_sayfasi.dart';
import 'package:ogrenci_app_flutter/ogrenciler_sayfasi.dart';
import 'package:ogrenci_app_flutter/ogretmenler_sayfasi.dart';
import 'package:ogrenci_app_flutter/repository/mesajlar_repository.dart';
import 'package:ogrenci_app_flutter/repository/ogrenciler_repository.dart';
import 'package:ogrenci_app_flutter/repository/ogretmenler_repository.dart';

void main() {
  runApp(const ProviderScope(child: OgrenciApp()));
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
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: const Center(child: CircularProgressIndicator() ,));
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    anasayfayaGit();
  }

  void anasayfayaGit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const AnaSayfa(title: "Ogrenci Sayfa"),));
  }
}






class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({Key? key, required this.title}) : super(key: key);

  final String title;



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
    var ogretmenlerRepository = ref.watch(ogretmenlerProvider);
    var mesajlarRepository = ref.watch(mesajlarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      return OgrencilerSayfasi();
    },));
  }

  void _ogretmenlereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OgretmenlerSayfasi();
    },));
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Mesajlar();
    },));

  }



}