import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/stock_feature/model/stock.dart';

final paramsViewModelProvider = Provider.family.autoDispose(
    (ref, VariableValue variableValue) =>
        ParamsViewModel(variableValue: variableValue));

late FutureProvider<List<Stock>> dataFutureProvider;

class ParamsViewModel {
  final TextEditingController controller = TextEditingController();
  final VariableValue variableValue;

  ParamsViewModel({
    required this.variableValue,
  }) {
    controller.text = variableValue.defaultValue.toString();
  }

  String? getValidateInput(String value) {
    int? parsedValue = int.tryParse(value);
    if (parsedValue == null ||
        parsedValue < variableValue.minValue! ||
        parsedValue > variableValue.maxValue!) {
      return 'valid value between ${variableValue.minValue} - ${variableValue.maxValue}';
    }

    return null;
  }
}
