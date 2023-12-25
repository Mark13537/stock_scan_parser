import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/components/base_widget.dart';
import 'package:stock_scan_parser/src/stock_feature/viewmodel/home_viewmodel.dart';
import 'package:stock_scan_parser/theme/app_theme.dart';
import 'package:stock_scan_parser/utils/constants.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider);
    final stockDetails = ref.watch(dataFutureProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).primary,
        body: stockDetails.when(
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => BaseWidget(
                title: data.elementAt(index).name,
                subTitle: Text(
                  data.elementAt(index).tag,
                  style: AppTheme.of(context).labelMedium.copyWith(
                        color: viewModel.getTagColor(
                            context, data.elementAt(index).color),
                      ),
                ),
                callback: () {
                  viewModel.goToNextPage(context, index);
                }),
          ),
          error: (error, stackTrace) => const Center(
            child: Text(Constants.genericErrorMsg),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
