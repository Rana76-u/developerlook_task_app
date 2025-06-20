import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatefulWidget {
  final String contentToShare;
  const ShareButton({super.key, required this.contentToShare});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void toggleShareOptions() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void shareContent(String platform) {
    final content = widget.contentToShare;
    switch (platform) {
      case 'facebook':
        Share.share('https://www.facebook.com/sharer/sharer.php?u=$content');
        break;
      case 'x':
        Share.share('https://twitter.com/intent/tweet?url=$content');
        break;
      case 'linkedin':
        Share.share('https://www.linkedin.com/sharing/share-offsite/?url=$content');
        break;
      case 'copy':
        Share.share(content);
        break;
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: 170,
        top: position.dy - 70,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _iconButton('facebook', Icons.facebook, Colors.black),
                _iconButton('x', Icons.clear, Colors.black),
                _iconButton('linkedin', Bootstrap.linkedin, Colors.black),
                _iconButton('copy', Icons.link, Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleShareOptions,
        child: Row(
          children: const [
            Icon(BoxIcons.bx_share),
            SizedBox(width: 8),
            Text('Share', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(String platform, IconData icon, Color color) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: () => shareContent(platform),
    );
  }
}