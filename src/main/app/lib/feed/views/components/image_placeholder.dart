import 'package:material_ui/material_ui.dart';

class ImagePlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final IconData? icon;
  final double? iconSize;

  const ImagePlaceholder({super.key, this.height, this.width, this.icon, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: colors.secondaryContainer),
      child: Center(
        child: Icon(
          icon ?? Icons.image_outlined,
          size: iconSize,
          color: colors.onSecondaryContainer.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
