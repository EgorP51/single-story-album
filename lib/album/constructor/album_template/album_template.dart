import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:single_story_album/album/@manager/album_bloc.dart';
import 'package:single_story_album/album/constructor/album_template/album_cover.dart';
import 'package:single_story_album/album/constructor/album_template/album_page.dart';
import 'package:single_story_album/album/constructor/album_template/free_space_widget.dart';

class AlbumTemplate extends StatelessWidget {
  const AlbumTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    final double cm = MediaQuery.of(context).size.width * 0.95 / 21;

    double a4Width = cm * 21;
    double a4Height = cm * 29.7;

    return BlocConsumer<AlbumBloc, AlbumState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: a4Width,
          height: a4Height,
          color: Colors.white,
          child: Row(
            children: [
              Column(
                children: [
                  AlbumPage(
                    isRight: false,
                    id: 4,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                  AlbumPage(
                    isRight: false,
                    id: 5,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                  AlbumCover(
                    isFront: false,
                    id: 6,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                  AlbumCover(
                    isFront: true,
                    id: 7,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                ],
              ),
              Column(
                children: [
                  AlbumPage(
                    isRight: true,
                    id: 3,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                  AlbumPage(
                    isRight: true,
                    id: 2,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                  AlbumPage(
                    isRight: true,
                    id: 1,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                  AlbumPage(
                    isRight: true,
                    id: 0,
                    bloc: BlocProvider.of<AlbumBloc>(context),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              SizedBox(width: cm * 0.215),
              FreeSpaceWidget(images: state.images),
              SizedBox(width: cm * 0.215),
            ],
          ),
        );
      },
    );
  }
}
