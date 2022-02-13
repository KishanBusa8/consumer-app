import 'package:flutter/material.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';

class LoanListProvider extends ChangeNotifier {
  List<AllLoans> _list = [];

  List<AllLoans> get list => _list;

  changewholelist(List<AllLoans> fromlist) {
    _list = fromlist;
    notifyListeners();
  }

  addsinglelist(AllLoans loan) {
    _list.add(loan);
    notifyListeners();
  }
}
