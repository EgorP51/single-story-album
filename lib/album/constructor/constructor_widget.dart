import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:single_story_album/album/@manager/album_bloc.dart';
import 'package:single_story_album/album/constructor/album_template/album_template.dart';
import 'package:single_story_album/album/preview/preview_page.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ConstructorWidget extends StatelessWidget {
  const ConstructorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumBloc, AlbumState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Single story album'.toUpperCase(),
              style: GoogleFonts.merriweather(
                color: Colors.amber,
                fontWeight: FontWeight.w800,
                fontSize: 21,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.black45,
          body: state.controller != null
              ? SingleChildScrollView(
                  child: Align(
                    alignment: const Alignment(0, -0.7),
                    child: WidgetsToImage(
                      controller: state.controller!,
                      child: const AlbumTemplate(),
                    ),
                  ),
                )
              : const SizedBox(),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'tag 1',
                child: const Icon(Icons.preview),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PreviewPage(state: state,);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'tag 2',
                child: const Icon(Icons.share),
                onPressed: () {
                  BlocProvider.of<AlbumBloc>(context).add(ShareAlbum());
                },
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'tag 3',
                child: const Icon(Icons.image_outlined),
                onPressed: () {
                  BlocProvider.of<AlbumBloc>(context).add(SaveAlbum());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
