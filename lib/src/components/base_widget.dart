import 'package:flutter/material.dart';
import 'package:stock_scan_parser/theme/app_theme.dart';

class BaseWidget extends StatelessWidget {
  final String title;
  final Widget? subTitle;
  final VoidCallback callback;
  const BaseWidget(
      {super.key, required this.title, this.subTitle, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(title, style: AppTheme.of(context).labelLarge),
                    subTitle ?? const SizedBox.shrink(),
                  ]),
            ),
            Divider(
              color: AppTheme.of(context).onPrimary,
            ),
          ],
        ));
  }
}
