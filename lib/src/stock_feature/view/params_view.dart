import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/components/base_widget.dart';
import 'package:stock_scan_parser/src/stock_feature/model/stock.dart';
import 'package:stock_scan_parser/theme/app_theme.dart';

import '../viewmodel/params_viewmodel.dart';

class ParamsView extends ConsumerWidget {
  final VariableValue variableValue;
  const ParamsView({super.key, required this.variableValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(paramsViewModelProvider(variableValue));
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppTheme.of(context).primary,
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: variableValue.type == 'value'
                ? getArrayWidget()
                : getParamsWidget(context, viewModel),
          )),
    );
  }

  ListView getArrayWidget() {
    return ListView.builder(
      itemCount: variableValue.values!.length,
      itemBuilder: (context, index) => BaseWidget(
        title: variableValue.values!.elementAt(index).toString(),
        callback: () {},
      ),
    );
  }

  Widget getParamsWidget(BuildContext context, ParamsViewModel viewModel) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              variableValue.studyType.toString().toUpperCase(),
              style: AppTheme.of(context)
                  .labelLarge
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Set Parameters',
              style: AppTheme.of(context).labelMedium.copyWith(fontSize: 13),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: AppTheme.of(context).secondary,
              padding: const EdgeInsets.all(10.0),
              constraints: const BoxConstraints(minHeight: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      variableValue.parameterName!,
                      style: AppTheme.of(context).labelMedium.copyWith(
                          color: AppTheme.of(context).onSecondary,
                          fontSize: 13),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: viewModel.controller,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          if (formKey.currentState != null) {
                            formKey.currentState!.validate();
                          }
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return viewModel.getValidateInput(value!);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
