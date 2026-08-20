import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/image_placeholder.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedItemImage extends StatelessWidget {
  final double? width;
  final double? height;
  final FeedItem item;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;

  const FeedItemImage({super.key, required this.item, this.width, this.height, this.borderRadius, this.border});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<IdentityCubit>();
    return ConditionalWrap(
      wrapIf: border != null,
      wrapper: (child) => Container(
        decoration: BoxDecoration(border: border, borderRadius: borderRadius),
        child: child,
      ),
      child: ConditionalWrap(
        wrapIf: borderRadius != null,
        wrapper: (child) => ClipRRect(borderRadius: borderRadius!, child: child),
        child: (item.imageUrl ?? '').isEmpty
            ? ImagePlaceholder(width: width, height: height)
            : CachedNetworkImage(
                imageUrl: '${cubit.state.serverUrl!}/images/feeds/items/${item.id}',
                width: width,
                height: height,
                fit: BoxFit.cover,
                imageRenderMethodForWeb: .HttpGet,
                placeholder: (context, url) => ImagePlaceholder(width: width, height: height),
                errorWidget: (context, url, error) => ImagePlaceholder(width: width, height: height),
              ),
      ),
    );
  }
}
