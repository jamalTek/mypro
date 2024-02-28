import '../../../general_exports.dart';

class ScrollWithExpanded extends StatelessWidget {
  const ScrollWithExpanded({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(hasScrollBody: false, child: child),
      ],
    );
  }
}
