

import '../import_path/import_path.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;
  @override
  void initState() {
    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
    super.initState();
  }

  void goToSong(int songIndex) {
    //update current song index
    playlistProvider.currentSongIndex = songIndex;

    //navigate Next Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("P L A Y I N G"),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(builder: (context, value, child) {
        //get the playList
        final List<Song> playlist = value.playList;
        return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              //get the individual song
              final Song song = playlist[index];

              //return to UI
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image(
                  image: AssetImage(
                    song.albumArtImagePath,
                  ),
                ),
                onTap: () => goToSong(index),
              );
            });
      }),
    );
  }
}
