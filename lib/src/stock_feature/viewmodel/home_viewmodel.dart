import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/stock_feature/model/stock.dart';
import 'package:stock_scan_parser/utils/utils.dart';

import '../service/stock_service.dart';
import '../view/criteria_view.dart';

final homeViewModelProvider = Provider.autoDispose((ref) => HomeViewModel());

late FutureProvider<List<Stock>> dataFutureProvider;

class HomeViewModel {
  HomeViewModel() {
    dataFutureProvider = FutureProvider(
        (ref) => ref.watch(stockServiceProvider).getStockService());
  }

  Color getTagColor(final BuildContext context, final String color) {
    return Utils.getTagColor(context, color);
  }

  goToNextPage(BuildContext context, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CriteriaView(
                  index: index,
                )));
  }
}
