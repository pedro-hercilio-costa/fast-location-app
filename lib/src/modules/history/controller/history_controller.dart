import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/history/page/history_page.dart';
import 'package:mobx/mobx.dart';
part 'history_controller.g.dart';

class HistoryController = _HistoryController with _$HistoryController;

abstract class _HistoryController with Store {
  @observable
  bool isLoading = false;

  @observable
  bool hasAddress = false;

  @observable
  ObservableList<AddressModel> addressHistoryList =
      ObservableList<AddressModel>();

  @action
  Future<void> loadData() async {
    isLoading = true;
    SearchHistory searchHistory = SearchHistory();
    List<AddressModel> history = await searchHistory.getSearchHistory();
    addressHistoryList.clear();
    addressHistoryList.addAll(history);
    hasAddress = addressHistoryList.isNotEmpty;
    isLoading = false;
  }

  @action
  void addToSearchHistory(AddressModel address) {
    addressHistoryList.insert(0, address);
  }
}
