import 'dart:ui';

import 'package:flutter/material.dart';

final Future<FragmentProgram?> _program = ImageFilter.isShaderFilterSupported
    ? FragmentProgram.fromAsset('shaders/progressive_blur.frag').then<FragmentProgram?>((p) => p, onError: (_) => null)
    : Future.value(null);

/// Blurs what is behind it, strongest at the screen edge and smoothly fading to no blur away from it.
///
/// Must be placed against the top of the screen, or the bottom when [fromBottom] is set. Uses a shader based backdrop filter, which is only available on Impeller;
/// elsewhere it just renders [child].
class ProgressiveBlur extends StatelessWidget {
  const ProgressiveBlur({super.key, this.sigma = 12, this.fromBottom = false, this.child});

  /// blur radius at the top, in logical pixels
  final double sigma;
  final bool fromBottom;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return IgnorePointer(
      child: FutureBuilder(
        future: _program,
        builder: (context, snapshot) {
          final program = snapshot.data;
          if (program == null) {
            return child ?? const SizedBox.shrink();
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              // the first two floats are the texture size, set by the engine
              final shader = program.fragmentShader()
                ..setFloat(2, constraints.maxHeight * dpr)
                ..setFloat(3, sigma * dpr)
                ..setFloat(4, fromBottom ? 1 : 0);

              return ClipRect(
                child: BackdropFilter(filter: ImageFilter.shader(shader), child: child ?? const SizedBox.expand()),
              );
            },
          );
        },
      ),
    );
  }
}
