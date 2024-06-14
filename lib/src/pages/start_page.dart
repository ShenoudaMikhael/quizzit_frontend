import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        toolbarHeight: 300,
        centerTitle: true,
        title: ListTile(
          title: Text(
            textAlign: TextAlign.center,
            "QUIZZIT",
            style: GoogleFonts.roboto(
              fontSize: 70,
              color: const Color(0xFF4257b2),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            textAlign: TextAlign.center,
            "Where every question is an adventure!",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(50)),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 50),
            height: 300,
            child: const Text(
              "<LOGOIMAGEHERE>",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: MaterialButton(
              minWidth: 250,
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: const Color(0xFF4257b2),
              onPressed: () {},
              child: Text("Start Playing!",
                  style: GoogleFonts.roboto(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    ));
  }
}
