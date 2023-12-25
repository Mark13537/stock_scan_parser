import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/stock_feature/model/stock.dart';
import 'package:stock_scan_parser/src/stock_feature/service/stock_service.dart';
import 'package:stock_scan_parser/src/stock_feature/view/params_view.dart';
import 'package:stock_scan_parser/theme/app_theme.dart';
import 'package:stock_scan_parser/utils/utils.dart';

final criteriaViewModelProvider =
    Provider.autoDispose((ref) => CritiaViewModel());

final criteriaViewFutureProvider =
    FutureProvider((ref) => ref.watch(stockServiceProvider));

class CritiaViewModel {
  Color getTagColor(final BuildContext context, final String color) {
    return Utils.getTagColor(context, color);
  }

  RichText getRichTextWidget(
      final Criteria criteria, final BuildContext context) {
    int currentPos = 0;
    List<TextSpan> textSpans = [];

    final RegExp regex = RegExp(r'\$[0-9]+');
    Iterable<Match> matches = regex.allMatches(criteria.text);

    for (Match match in matches) {
      final String matchText = match.group(0)!;
      textSpans.add(TextSpan(
        text: criteria.text.substring(currentPos, match.start),
        style: AppTheme.of(context).labelLarge,
      ));

      textSpans.add(TextSpan(
        // text: matchText,
        text: getVariableValue(criteria.variable!, matchText),
        style: AppTheme.of(context)
            .labelLarge
            .copyWith(color: AppTheme.of(context).link),
        recognizer: TapGestureRecognizer()
          ..onTap = () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParamsView(
                    variableValue: criteria.variable![matchText]!,
                  ),
                ),
              ),
      ));
      currentPos = match.end;
    }
    textSpans.add(TextSpan(
      text: criteria.text.substring(currentPos),
      style: AppTheme.of(context).labelLarge,
    ));

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }

  String getVariableValue(Map<String, VariableValue> map, String varKey) {
    if (map[varKey] != null && map[varKey]!.type == 'value') {
      return '(${map[varKey]!.values!.first})';
    } else {
      return '(${map[varKey]!.defaultValue})';
    }
  }
}
