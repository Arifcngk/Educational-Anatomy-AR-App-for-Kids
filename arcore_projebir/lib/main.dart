import 'package:flutter/material.dart';
import 'organ_model.dart';
import 'organ_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Organ Bilgi Uygulaması',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      home: OrganListPage(),
    );
  }
}

class OrganListPage extends StatelessWidget {
  final List<Organ> organs = [
    Organ(
      modelKey:
          "https://firebasestorage.googleapis.com/v0/b/my-3-d-models.appspot.com/o/beyin.glb?alt=media&token=ec6fa91f-a4aa-43cb-837b-464d34fe4a56",
      name: "Beyin",
      description:
          "Beyin, vücudumuzun kontrol merkezidir.\n Duyguları, düşünce süreçlerini, hafızayı ve motor becerileri kontrol eder.",
      description2: "Duyu işleme: Gelen bilgileri algılar. \n"
          " Hafıza: Bilgileri saklar ve hatırlar.\n"
          " Düşünme: Mantık yürütme ve karar verme süreçlerini yönetme.\n"
          "  Motor kontrol: Kasları ve hareketi kontrol etme.\n",
      image: "image/beyin.jpg",
    ),
    Organ(
        modelKey:
            "https://firebasestorage.googleapis.com/v0/b/my-3-d-models.appspot.com/o/kalp.glb?alt=media&token=bf942095-a2b3-4e13-b320-d1302a5e1333",
        name: "Kalp",
        description:
            "Kalp, dolaşım sistemi içinde kanı pompalayarak vücuttaki hücrelere oksijen ve besin taşır.",
        description2: "Kanı vücut boyunca pompalamak.",
        image: "image/kalp.jpg"),
    Organ(
        modelKey:
            "https://firebasestorage.googleapis.com/v0/b/my-3-d-models.appspot.com/o/akci%C4%9Fer.glb?alt=media&token=f157c8ce-43f4-45e9-b4d2-c6e2ee5da6c0",
        name: "Akciğer",
        description:
            "Akciğerler, vücuda oksijen alımını sağlar ve karbon dioksiti dışarı atar.",
        description2: "Oksijenin vücuda alınması ve karbon dioksitin atılması.",
        image: "image/akciğer.jpg"),
    Organ(
        modelKey:
            "https://firebasestorage.googleapis.com/v0/b/my-3-d-models.appspot.com/o/b%C3%B6brek.glb?alt=media&token=e06dea76-5330-4f9f-9d2e-063eec93fded",
        name: "Böbrek",
        description:
            "Böbrekler, kanı temizleyerek atık maddeleri ve fazla sıvıyı idrar yoluyla dışarı atar.",
        image: "image/böbrek.jpg",
        description2: "Kanı süzme ve idrar oluşturma."),
    Organ(
        modelKey: "",
        name: "Bağırsak",
        description:
            "ağırsaklar, sindirim sistemine aittir ve besinleri parçalayarak vücuda enerji sağlar.",
        image: "image/bağırsak.jpg",
        description2:
            "Besinlerin emilmesi ve atık maddelerin dışarı atılması."),
    Organ(
        modelKey:
            "https://firebasestorage.googleapis.com/v0/b/my-3-d-models.appspot.com/o/mide.glb?alt=media&token=a56393c2-73a6-48d0-8b5e-ea943b559bcd",
        name: "Mide",
        description: "Mide, besinleri sindirir ve parçalar.",
        image: "image/mide.jpg",
        description2: "Besinleri kimyasal olarak parçalama ve sindirme."),
    Organ(
        modelKey:
            "https://firebasestorage.googleapis.com/v0/b/my-3-d-models.appspot.com/o/karaci%C4%9Fer.glb?alt=media&token=b028605b-c674-4921-8478-23d5497157ac",
        name: "Karaciğer",
        description:
            "Karaciğer, vücuttaki birçok kimyasal süreci düzenler ve detox görevi görür.",
        image: "image/karaciğer.jpg",
        description2:
            "Safra üretimi, kan şekerini düzenleme, detoxifikasyon, protein sentezi."),
    Organ(
        modelKey: "",
        name: "Cilt",
        description:
            "Böbrekler, kanı temizleyerek atık maddeleri ve fazla sıvıyı idrar yoluyla dışarı atar.",
        image: "image/cilt.jpg",
        description2: "Kanı süzme ve idrar oluşturma."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Anatomi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Yatayda 2 sütun
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: organs.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: ListTile(
                      title: Center(
                          child: Text(
                        organs[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrganDetailPage(organ: organs[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
