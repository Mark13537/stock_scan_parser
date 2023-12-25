import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class ViewTitleWidget extends StatelessWidget {
  final String title;
  final Widget subTitle;
  const ViewTitleWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: AppTheme.of(context).tertiary,
      constraints: const BoxConstraints(
        minHeight: 80.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          subTitle
        ],
      ),
    );
  }
}
