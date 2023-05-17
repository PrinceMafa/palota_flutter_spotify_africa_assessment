class SpotifyAPI {
  static const String apiKey = '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ==';

  static Future<List<Playlist>> getPlaylists(String category) async {
    // Create the URL for the API request.
    Uri url = Uri.parse('https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/$category/playlists');

    // Add the API key to the request headers.
    Map<String, String> headers = {
      'Authorization': 'Bearer $apiKey',
    };

    // Make the API request.
    var response = await http.get(url, headers: headers);

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Request failed with status code ${response.statusCode}');
    }

    // Parse the response body into a list of playlists.
    var playlists = await json.decode(response.body)['items'];

    // Return the list of playlists.
    return playlists;
  }

  static Future<PlaylistDetails> getPlaylistDetails(String playlistId) async {
    // Create the URL for the API request.
    Uri url = Uri.parse('https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/$playlistId');

    // Add the API key to the request headers.
    Map<String, String> headers = {
      'Authorization': 'Bearer $apiKey',
    };

    // Make the API request.
    var response = await http.get(url, headers: headers);

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Request failed with status code ${response.statusCode}');
    }

    // Parse the response body into a playlist details object.
    var playlistDetails = await json.decode(response.body);

    // Return the playlist details object.
    return playlistDetails;
  }
}