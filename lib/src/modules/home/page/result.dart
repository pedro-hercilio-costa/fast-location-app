import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fast_location/src/modules/history/controller/history_controller.dart';
import 'package:fast_location/src/modules/history/page/history_page.dart';

var cepController = TextEditingController();

class ApiCall {
  final Dio _dio = Dio();

  Future<AddressModel> fetchAPI(String numCep) async {
    try {
      final response = await _dio.get('https://viacep.com.br/ws/$numCep/json/');
      if (response.statusCode == 200) {
        return AddressModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao pesquisar CEP');
      }
    } catch (e) {
      throw Exception('Erro interno');
    }
  }
}

widgetPesquisa(BuildContext context, String titulo) {
  return AlertDialog(
    title: Text(titulo),
    content: Form(
      child: TextFormField(
        controller: cepController,
        keyboardType: TextInputType.number,
      ),
    ),
    actions: [
      Center(
        child: ElevatedButton(
          onPressed: () async {
            ApiCall apiCall = ApiCall();
            try {
              AddressModel result = await apiCall.fetchAPI(cepController.text);
              SearchHistory searchHistory = SearchHistory();
              await searchHistory.addToSearchHistory(result);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressDetailPage(result),
                ),
              );
            } catch (e) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text('Erro: $e'),
                  );
                },
              );
            }
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            backgroundColor:
                WidgetStateProperty.all(Color.fromRGBO(62, 145, 67, 1)),
            minimumSize: WidgetStateProperty.all(Size(230, 50)),
            padding: WidgetStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          child: const Text(
            "Consultar",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      )
    ],
  );
}

class AddressDetailPage extends StatelessWidget {
  final AddressModel endereco;
  final HistoryController historyController = HistoryController();

  AddressDetailPage(this.endereco, {super.key});

  _openGoogleMaps() async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=${endereco.cep}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Erro ao acessar $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightMedia = size.height;
    var widthMedia = size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
            const SizedBox(height: 40),
            Text('Dados da Localização',
                style: const TextStyle(
                    color: Color.fromRGBO(62, 145, 67, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Logradouro/Rua: ${endereco.logradouro}',
                      style: const TextStyle(fontSize: 20)),
                  Text('Bairro/Distrito: ${endereco.bairro}',
                      style: const TextStyle(fontSize: 20)),
                  Text('Complemento: ${endereco.complemento}',
                      style: const TextStyle(fontSize: 20)),
                  Text('Cidade: ${endereco.localidade}',
                      style: const TextStyle(fontSize: 20)),
                  Text('UF/Estado: ${endereco.uf}',
                      style: const TextStyle(fontSize: 20)),
                  Text('CEP: ${endereco.cep}',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openGoogleMaps,
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                backgroundColor:
                    WidgetStateProperty.all(Color.fromRGBO(62, 145, 67, 1)),
                minimumSize:
                    WidgetStateProperty.all(Size(widthMedia * 0.95, 50)),
                padding: WidgetStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: heightMedia * 0.02),
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: Text(
                'Consultar no Maps',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: heightMedia * 0.03,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
