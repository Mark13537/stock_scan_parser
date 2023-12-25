import 'package:flutter/material.dart';
import 'package:stock_scan_parser/theme/app_theme.dart';

class CriteriaWidget extends StatelessWidget {
  final RichText title;
  final int index;
  final int length;
  final VoidCallback callback;
  const CriteriaWidget(
      {super.key,
      required this.title,
      required this.index,
      required this.length,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
      child: GestureDetector(
        onTap: callback,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            title,
            const SizedBox(
              height: 5,
            ),
            index != length - 1
                ? Text(
                    'and',
                    style: AppTheme.of(context).labelMedium,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
