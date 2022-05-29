import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:welcome2/pages/login.dart';
import 'package:welcome2/widgets/app_largetext.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:welcome2/widgets/app_text.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({Key key}) : super(key: key);

  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  List<String> images = ["sharek.png", "fille2.png", "ordi.png"];

  List<String> text = [
    "L'initiative SHAREK-IT est au profil des élèves et étudiants défavorisés, et leur permettra de suivre l'enseignement à distance.",
    "Pensez à tout le bien que vous pouvez faire avec un simple don et soyez fier d'avoir contribué pour un meilleur futur au pays à travers une génération instruite et connectée.",
    "L'initiative Sharek,lancée en Tunisie en mars 2020, consiste à une collecte de dons en déchets électroniques non dangereux de la part de particuliers et entreprises responsables pour leur tri et reconditionnement au profit des causes sociales "
  ];
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Container(
            child: Column(children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: DrawClip(),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.69,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/" + images[index],
                          ),
                          fit: BoxFit.none,
                        ),
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 253, 232, 205),
                              Color.fromARGB(255, 250, 223, 188)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: SmoothPageIndicator(controller: _controller, count: 3),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  AppLargeText(
                    text: "Sharek",
                    size: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppText(
                      text: text[index],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 250),
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromARGB(255, 247, 149, 22),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Skip Step",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          );
        },
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 1.5, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
