import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/utils.dart';
import '../model/stock.dart';

final stockServiceProvider =
    Provider<StockService>((ref) => StockServiceImpl());

abstract class StockService {
  Future<List<Stock>> getStockService();
}

class StockServiceImpl extends StockService {
  final url = 'http://coding-assignment.bombayrunning.com/data.json';

  @override
  Future<List<Stock>> getStockService() async {
    List<Stock> stockList = [];
    Response? response;
    try {
      response = await Utils.dioInstance.get(url);
    } on DioException catch (e) {
      debugPrint('Analytics log about exception with ${e.toString()}');
    }

    var list = response != null ? response.data as List : [];
    stockList =
        list.map((e) => Stock.fromJson(e as Map<String, dynamic>)).toList();
    return stockList;
  }
}
