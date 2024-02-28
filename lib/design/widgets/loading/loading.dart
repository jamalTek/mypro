import '../../../general_exports.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(),
      padding: generalPadding,
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minWidth: kDeviceWidth,
        minHeight: kDeviceHeight * 0.2,
      ),
      child: const RawLoading(),
    ); //.animate().scale(curve: Curves.easeOutBack);
  }
}
