import 'package:material_ui/material_ui.dart';

class PreviewContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? child;
  final Color? color;

  const PreviewContainer({super.key, this.width, this.height, this.borderRadius, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color ?? colors.primaryContainer, borderRadius: borderRadius),
      child: child,
    );
  }
}
