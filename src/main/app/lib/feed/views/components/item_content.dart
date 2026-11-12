import 'package:app/feed/models/feed_item.dart';
import 'package:material_ui/material_ui.dart';
import 'package:html_unescape/html_unescape.dart';

class ItemContent extends StatelessWidget {
  final int? maxLines;
  final TextStyle? style;
  final TextOverflow? overflow;
  final FeedItem item;

  const ItemContent({super.key, required this.item, this.maxLines, this.style, this.overflow});

  String stripHtmlTags(String html) {
    if (html.isEmpty) return html;

    // Remove script/style blocks
    html = html.replaceAll(RegExp(r'<script[^>]*>[\s\S]*?<\/script>', caseSensitive: false), '');
    html = html.replaceAll(RegExp(r'<style[^>]*>[\s\S]*?<\/style>', caseSensitive: false), '');

    // Remove all tags
    html = html.replaceAll(RegExp(r'<[^>]+>'), '');

    // Numeric decimal entities &#1234;
    html = html.replaceAllMapped(RegExp(r'&#(\d+);'), (m) => String.fromCharCode(int.parse(m.group(1)!)));

    // Numeric hex entities &#x1F600;
    html = html.replaceAllMapped(
      RegExp(r'&#x([A-Fa-f0-9]+);'),
      (m) => String.fromCharCode(int.parse(m.group(1)!, radix: 16)),
    );

    // Common named entities
    const entityMap = {
      '&nbsp;': ' ',
      '&amp;': '&',
      '&quot;': '"',
      '&apos;': "'",
      '&lt;': '<',
      '&gt;': '>',
      '&rsquo;': '’',
      '&lsquo;': '‘',
      '&rdquo;': '”',
      '&ldquo;': '“',
      '&ndash;': '–',
      '&mdash;': '—',
      '&hellip;': '…',
    };

    entityMap.forEach((key, value) {
      html = html.replaceAll(key, value);
    });

    return HtmlUnescape().convert(html.trim());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Text(
      stripHtmlTags(item.description ?? item.content ?? ''),
      maxLines: maxLines,
      style: (style ?? textTheme.bodyMedium)?.copyWith(color: colors.secondary, height: 1.3),
      overflow: overflow,
    )
    /* return ClipRect(
      child: HtmlWidget(

        item.description ?? item.content ?? '',
        enableCaching: true,
        buildAsync: true,
        onLoadingBuilder: (context, element, loadingProgress) => SizedBox.shrink(),
        customWidgetBuilder: (element) {
          if (element.localName == 'img' || element.localName == 'video') {
            return SizedBox.shrink();
          }
          return null;
        },
      ),
    )*/
    ;
  }
}
