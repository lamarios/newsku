import 'package:app/feed/models/feed.dart';
import 'package:app/feed/views/components/image_placeholder.dart';
import 'package:app/identity/states/identity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedImage extends StatelessWidget {
  final double? width;
  final double? height;
  final Feed item;

  const FeedImage({super.key, required this.item, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if ((item.image ?? '').isEmpty) {
      return ImagePlaceholder(width: width, height: height, icon: Icons.rss_feed, iconSize: 10);
    }

    var cubit = context.read<IdentityCubit>();
    return CachedNetworkImage(
      imageUrl: '${cubit.state.serverUrl!}/images/feeds/${item.id}',
      width: width,
      height: height,
      fit: BoxFit.cover,
      imageRenderMethodForWeb: .HttpGet,
      placeholder: (context, url) => ImagePlaceholder(width: width, height: height, icon: Icons.rss_feed, iconSize: 10),
      errorWidget: (context, url, error) =>
          ImagePlaceholder(width: width, height: height, icon: Icons.rss_feed, iconSize: 10),
    );
  }
}
