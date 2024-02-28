import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class PickFromPicker extends StatelessWidget {
  const PickFromPicker({
    super.key,
    required this.onChange,
    required this.list,
    this.initialIndex,
  });
  final void Function(int index) onChange;
  final List<String> list;
  final int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(),
      padding: generalPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                TranslatedText(
                  'Close',
                  style: textStyles['primary14mid'],
                ),
              ],
            ),
          ),
          SizedBox(
            height: kDeviceHeight * 0.2,
            child: CupertinoPicker(
              itemExtent: verticalSpacing * 2,
              onSelectedItemChanged: onChange,
              scrollController: FixedExtentScrollController(
                initialItem: initialIndex ?? 0,
              ),
              children: list.map((e) => Text(e)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
