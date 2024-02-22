import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/domain/models/artist_model.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';

class ArtistDetailPage extends StatefulWidget {
  final ArtistModel artist;

  const ArtistDetailPage({super.key, required this.artist});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: widget.artist.id,
            child: Container(
              color: Colors.blue[200],
              child: Image(
                image: CachedNetworkImageProvider(widget.artist.avatar),
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.blue[200],
                ),
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.8),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.mediumMargin),
                child: Text(
                  widget.artist.name,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
