import 'package:flutter/material.dart';
import 'test_puan.dart';

class Oyun extends StatefulWidget {
  const Oyun({Key? key}) : super(key: key);

  @override
  State<Oyun> createState() => _OyunState();
}

class _OyunState extends State<Oyun> {
  List<Widget> secimler = [];
  List<String> sorular = [
    'Kelebeklerin ömrü bir gündür.',
    'Titanik gelmiş geçmiş en büyük gemidir.',
    'Gaz halden sıvı hale geçen bir madde yoğuşmuş olur.',
    'Güneybatıdan esen ve baş ağrısı yaptığına inanılan rüzgarla, kuzeydoğudan esen soğuk rüzgar Lodos ve Poyrazdır.',
    'Su periyodik tabloda bulunan bir element değildir.',
    'Bir trilyonda 10 adet sıfır vardır.',
    "Türkiye'de Barış ismini ilk olarak Barış Manço almıştır.",
    "Güney Afrika'nın üç başkenti vardır.",
    "Evli çiftlerin evliliklerinin 25 ve 50 yılları 'gümüş yıl ve 'altın yıl olarak adlandırılır.",
    "Bugün hayatta olan 100 yaş ve üstü insanların yüzde 19'u erkektir.",
    "Küba ülkesinde bir evin kapısını tıklatıp kaçmak yasal olarak suçtur.",
    "Bordo, karina ve sintine gemi taşıtının bölümlerine verilen addır.",
  ];
  List<bool> yanitlar = [
    false,
    false,
    true,
    true,
    false,
    false,
    true,
    false,
    true,

    true,
    false,
    true
  ];
  int soruIndex = 0;

  static const Icon kDogruIconu = Icon(Icons.mood, color: Colors.green);
  static const Icon kYanlisIconu = Icon(Icons.mood_bad, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text(
          "Test Et Kendini",
          style: TextStyle(
                color: Colors.white,
            ),
         ),
       ),
                    body: Container(
                      decoration: BoxDecoration(
                      gradient: LinearGradient(
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                         colors: [
                         Colors.purple[100]!,
                         Colors.orange[200]!,
                         ],
                        ),
                      ),
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                 Expanded(
                 flex: 4,
                 child: Padding(
                 padding: EdgeInsets.all(10.0),
                 child: Center(
                  child: Text(
                    sorular[soruIndex],
                    textAlign: TextAlign.center,
                     style: TextStyle(
                      fontWeight: FontWeight.bold,
                       fontSize: 20.0,
                        color: Colors.deepOrange[800],
                     ),
                    ),
                   ),
                  ),
                ),
                 Wrap(
                 alignment: WrapAlignment.center,
                   runSpacing: 3,
                   spacing: 3,
                   children: secimler,
               ),
                 Expanded(
                 flex: 1,
                  child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Row(
                       children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                onPressed: () {
                setState(() {
                if (soruIndex < sorular.length - 1) {
                yanitlar[soruIndex] == true
                ? secimler.add(kDogruIconu)
                : secimler.add(kYanlisIconu);

                    soruIndex++;
                    } else {
                  Navigator.push(
                        context,MaterialPageRoute( builder: (context) => TestPuan( dogruSayisi: secimler
                    .where((icon) => icon == kDogruIconu).length,
                     yanlisSayisi: secimler.where((icon) => icon == kYanlisIconu).length,
               ),
             ),
            );
           }
         });
        },
                 style: ElevatedButton.styleFrom(
                   padding: EdgeInsets.all(12),
                   backgroundColor: Colors.deepOrange[300],),
                       child: Icon(color: Colors.white, Icons.thumb_up, size: 30.0,),
    ),
    ),
                        SizedBox(width: 6.0),
                         Expanded(
                         child: ElevatedButton(onPressed: () { setState(() {
                          if (soruIndex < sorular.length - 1) {
                           yanitlar[soruIndex] == false ? secimler.add(kDogruIconu) : secimler.add(kYanlisIconu);soruIndex++;
                            } else {
                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                               TestPuan(
                             dogruSayisi: secimler.where((icon) => icon == kDogruIconu).length,
                             yanlisSayisi: secimler.where((icon) => icon == kYanlisIconu).length,
                ),
               ),
              );
             }
            });
            },
                             style: ElevatedButton.styleFrom(
                             padding: EdgeInsets.all(12),
                             backgroundColor: Colors.deepOrange[300],), child : Icon(color: Colors.white, Icons.thumb_down, size: 30.0,
             ),
             ),
            ),],
            ),
           ),
          ),
         ],
        ),
      ),
    );
  }
}

