import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final artist = 'Coldplay';
  final response = await fetchArtistData(artist);
  if (response != null) {
    displayArtistInfo(response);
  } else {
    print('Error fetching artist data.');
  }
}

Future<Map<String, dynamic>?> fetchArtistData(String artistName) async {
  final url = Uri.parse('https://api.deezer.com/search/artist?q=$artistName');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

void displayArtistInfo(Map<String, dynamic> data) {
  final artist = data['data'][0];
  final name = artist['name'];
  final picture = artist['picture_medium'];
  final listeners = artist['nb_fan'];
  final albums = artist['nb_album'];

  print('Artist: $name');
  print('Picture: $picture');
  print('Listeners: $listeners');
  print('Albums: $albums');
}