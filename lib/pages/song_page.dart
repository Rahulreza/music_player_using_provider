
import '../import_path/import_path.dart';
class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  //convert duration min:sec
  String formatDurationTime(Duration duration){
    String twoDigitSeconds=duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formatedTime="${duration.inMinutes}:$twoDigitSeconds";
    return formatedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playList;
      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];
      //return scafold
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              bottom: 25.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //iconbutton
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    //title
                    const Text("P L A Y L I S T"),
                    //menu button
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                NewBox(
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                              image:
                                  AssetImage(currentSong.albumArtImagePath))),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),
                            //heart icon
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //song duration progress
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //start  time
                          Text(formatDurationTime(value.currentDuration),),
                          //shuffle icon
                          const Icon(Icons.shuffle),
                          //repeat icon
                          const Icon(Icons.repeat),
                          // end time
                          Text(formatDurationTime(value.totalDuration),),
                        ],
                      ),
                    ),
                    //song duration progress
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 0,
                        ),
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double double) {
                          //during when the user is sliding around
                        },
                        onChangeEnd: (double double){
                          //sliding has finished ,go to that position in song duration
                          value.seek(Duration(seconds: double.toInt(),),);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                //playback controls
                Row(
                  children: [
                    //skip previous

                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: const NewBox(
                          child: Icon(
                            Icons.skip_previous,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //play
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child: NewBox(
                          child: Icon(
                            value.isPlaying?Icons.pause:Icons.play_arrow,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //skip forward
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: const NewBox(
                          child: Icon(
                            Icons.skip_next,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
