import 'package:flutter/material.dart';
import 'package:single_story_album/album/@manager/album_bloc.dart';
import 'package:widget_zoom/widget_zoom.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.state});

  final AlbumState state;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  Widget? child;

  @override
  void initState() {
    getAlbumFromState();
    super.initState();
  }

  void getAlbumFromState() async {
    final bytes = await widget.state.controller!.capture();

    if (bytes != null) {
      child = Image.memory(bytes);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: WidgetZoom(
            heroAnimationTag: 'album',
            zoomWidget: child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}
