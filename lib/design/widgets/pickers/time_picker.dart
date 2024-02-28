import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class TimeSelector extends StatelessWidget {
  const TimeSelector({
    super.key,
    required this.onChange,
    this.initialTime,
  });
  final void Function(DateTime time) onChange;
  final DateTime? initialTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(horizontalSpacing),
        ),
        color: MerathColors.background,
      ),
      padding: generalPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: TranslatedText(
                  'Close',
                  style: textStyles['primary14mid'],
                ),
              ),
            ],
          ),
          SizedBox(
            height: kDeviceHeight * 0.3,
            child: CupertinoDatePicker(
              onDateTimeChanged: onChange,
              mode: CupertinoDatePickerMode.time,
              initialDateTime: initialTime,
            ),
          ),
        ],
      ),
    );
  }
}
