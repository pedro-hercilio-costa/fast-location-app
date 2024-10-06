import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fast_location/src/modules/home/page/result.dart';
import 'package:fast_location/src/modules/history/page/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightMedia = size.height;
    var widthMedia = size.width;

    return Scaffold(
        backgroundColor: AppColors.appPageBackground,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      size: 35,
                      color: Color.fromRGBO(62, 145, 67, 1),
                      Icons.multiple_stop,
                    ),
                    Text(
                      "Fast Location",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 35,
                        color: Color.fromRGBO(62, 145, 67, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: widthMedia * 0.90,
                  height: heightMedia * 0.3,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: AppColors.appBarContainer, blurRadius: 7)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 210, 210, 210),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                          size: 70,
                          color: Color.fromRGBO(62, 145, 67, 1),
                          Icons.directions),
                      Text("Faça uma busca para localizar seu destino",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 41, 41, 41),
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return widgetPesquisa(context, "Digite o CEP");
                        });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Color.fromRGBO(62, 145, 67, 1)),
                    minimumSize:
                        WidgetStateProperty.all(Size(widthMedia * 0.95, 15)),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(heightMedia * 0.01),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text("Localizar endereço",
                      style: TextStyle(
                          color: Colors.white, fontSize: heightMedia * 0.03))),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      size: 30,
                      color: Color.fromRGBO(62, 145, 67, 1),
                      Icons.place),
                  Text("Última localização",
                      style: TextStyle(
                          color: Color.fromRGBO(62, 145, 67, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryPage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(Size(widthMedia * 0.95, 15)),
                    backgroundColor:
                        WidgetStateProperty.all(Color.fromRGBO(62, 145, 67, 1)),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(heightMedia * 0.01),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text("Histórico de endereços",
                      style: TextStyle(
                          color: Colors.white, fontSize: heightMedia * 0.03)))
            ])),
        bottomNavigationBar: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(62, 145, 67, 1)),
            child: const IconButton(
                onPressed: null,
                icon: Icon(size: 50, color: Colors.white, Icons.alt_route))));
  }
}
