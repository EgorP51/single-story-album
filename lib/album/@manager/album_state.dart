part of 'album_bloc.dart';

class AlbumState extends Equatable {
  const AlbumState({
    this.images,
    this.controller,
    this.albumTitle = '{title}',
    this.albumDescription = '{description}',
  });

  final WidgetsToImageController? controller;
  final List<Image?>? images;
  final String? albumTitle;
  final String? albumDescription;

  AlbumState copyWith({
    WidgetsToImageController? controller,
    List<Image?>? images,
    String? albumTitle,
    String? albumDescription,
  }) {
    return AlbumState(
      controller: controller ?? this.controller,
      images: images ?? this.images,
      albumTitle: albumTitle ?? this.albumTitle,
      albumDescription: albumDescription ?? this.albumDescription,
    );
  }

  @override
  List<Object?> get props {
    return [
      controller,
      images,
      albumTitle,
      albumDescription,
    ];
  }
}
