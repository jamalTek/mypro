import '../../../general_exports.dart';

class CCloseButton extends StatelessWidget {
  const CCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        decoration: circleDecoration(color: MerathColors.shapeBackground),
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.close,
          size: horizontalSpacing,
        ),
      ),
    );
  }
}
