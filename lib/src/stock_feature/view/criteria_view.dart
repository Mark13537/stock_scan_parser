import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/components/criteria_widget.dart';
import 'package:stock_scan_parser/src/components/view_title_widget.dart';
import 'package:stock_scan_parser/src/stock_feature/viewmodel/criteria_viewmodel.dart';
import 'package:stock_scan_parser/theme/app_theme.dart';

import '../viewmodel/home_viewmodel.dart';

class CriteriaView extends ConsumerWidget {
  final int index;
  const CriteriaView({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(criteriaViewModelProvider);
    final stockList = ref.watch(dataFutureProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).primary,
        body: stockList.when(
          data: (data) {
            final currentStock = data.elementAt(index);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: ViewTitleWidget(
                      title: data.elementAt(index).name,
                      subTitle: Text(
                        currentStock.tag,
                        style: AppTheme.of(context).labelMedium.copyWith(
                              color: viewModel.getTagColor(
                                  context, currentStock.color),
                            ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: currentStock.criteria.length,
                    itemBuilder: (context, criteriaIndex) => CriteriaWidget(
                      title: viewModel.getRichTextWidget(
                          currentStock.criteria.elementAt(criteriaIndex),
                          context),
                      index: criteriaIndex,
                      length: currentStock.criteria.length,
                      callback: () {},
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => const Placeholder(),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
