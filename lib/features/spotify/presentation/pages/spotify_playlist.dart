import 'package:flutter/material.dart';

import 'package:spotify_api/spotify_api.dart';

class SpotifyPlaylist extends StatefulWidget {
  final String playlistId;

  const SpotifyPlaylist({
    Key? key,
    required this.playlistId,
  }) : super(key: key);

  @override
  State<SpotifyPlaylist> createState() => _SpotifyPlaylistState();
}

class _SpotifyPlaylistState extends State<SpotifyPlaylist> {
  late Future<PlaylistDetails> playlistDetails;

  @override
  void initState() {
    super.initState();
    playlistDetails = SpotifyAPI.getPlaylistDetails(playlistId);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Name'),
      ),
      body: FutureBuilder(
        future: playlistDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              PlaylistDetails playlistDetails = snapshot.data;
              return ListView(
                children: [
                  Image.network(playlistDetails.imageUrl),
                  SizedBox(height: 8.0),
                  Text(playlistDetails.name),
                  SizedBox(height: 8.0),
                  Text(playlistDetails.description),
                  SizedBox(height: 8.0),
                  Text(
                    'Number of followers: ${playlistDetails.numberOfFollowers}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  TracksList(tracks: playlistDetails.tracks),
                  ArtistsList(artists: playlistDetails.artists),
                ],
              );
            } else {
              return Center(
                child: Text('No playlist found'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}