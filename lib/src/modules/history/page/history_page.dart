import 'package:fast_location/src/modules/history/controller/history_controller.dart';
import 'package:fast_location/src/modules/home/components/address_list.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/components/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fast_location/src/modules/home/model/address_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class SearchHistory {
  static const _key = 'historicoPesq';
  Future<List<AddressModel>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_key);
    if (jsonList == null) {
      return [];
    }
    return jsonList
        .map((json) => AddressModel.fromJsonLocal(jsonDecode(json)))
        .toList();
  }

  Future<void> addToSearchHistory(AddressModel address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<AddressModel> history = await getSearchHistory();
    history.insert(0, address);
    List<String> jsonList =
        history.map((address) => jsonEncode(address.toJson())).toList();
    prefs.setStringList(_key, jsonList);
  }

  Future<void> clearSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _controller = HistoryController();

  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _controller.isLoading
          ? const AppLoading()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.appPageBackground,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(62, 145, 67, 1),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              backgroundColor: AppColors.appPageBackground,
              body: SingleChildScrollView(
                child: SafeArea(
                    child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 25,
                        right: 25,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share_location,
                                size: 30,
                                color: Color.fromRGBO(62, 145, 67, 1),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Endereços Pesquisados",
                                  style: TextStyle(
                                      color: Color.fromRGBO(62, 145, 67, 1),
                                      fontSize: 25,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: AddressList(
                              addressList: _controller.addressHistoryList,
                            ),
                          ),
                        ],
                      )),
                )),
              ));
    });
  }
}
