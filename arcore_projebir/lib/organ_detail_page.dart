import 'package:arcore_projebir/custon_3d_objects_screen.dart';
import 'package:flutter/material.dart';
import 'organ_model.dart';

class OrganDetailPage extends StatefulWidget {
  final Organ organ;

  OrganDetailPage({Key? key, required this.organ}) : super(key: key);

  @override
  State<OrganDetailPage> createState() => _OrganDetailPageState();
}

class _OrganDetailPageState extends State<OrganDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.organ.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.organ.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Ne İşe Yarar?",
                      style: TextStyle(fontSize: 26, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.organ.description,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Temel İşlevi:",
                      style: TextStyle(fontSize: 26, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.organ.description2,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 80),
                    Text(
                      widget.organ.name + " Nasıl Gözükür ? ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Custom3dObjectsScreen(
                                    organObject: Organ(
                                        name: "",
                                        description: "",
                                        image: "",
                                        description2: "",
                                        modelKey: widget.organ.modelKey)),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
