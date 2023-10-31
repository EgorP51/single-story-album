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
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(),
          backgroundColor: Colors.black45,
          body: state.controller != null
              ? AlbumContent(state: state)
              : const SizedBox(),
          floatingActionButton: ActionButtons(context: context, state: state),
        );
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}

class AlbumContent extends StatelessWidget {
  final AlbumState state;

  const AlbumContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetsToImage(
              controller: state.controller!,
              child: const AlbumTemplate(),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<AlbumBloc>(context).changeTitleDialog(
                  context,
                  state,
                );
              },
              child: AlbumInfo(text: 'Title: ${state.albumTitle}' ?? ''),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<AlbumBloc>(context).changeDescriptionDialog(
                  context,
                  state,
                );
              },
              child: AlbumInfo(text: 'Description: ${state.albumDescription}'),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumInfo extends StatelessWidget {
  final String text;

  const AlbumInfo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.merriweather(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final BuildContext context;
  final AlbumState state;

  const ActionButtons({super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  return PreviewPage(
                    state: state,
                  );
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
    );
  }
}
