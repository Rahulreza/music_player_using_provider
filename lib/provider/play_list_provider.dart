
import '../import_path/import_path.dart';
class PlayListProvider extends ChangeNotifier {
  //playList of songs
  final List<Song> _playList = [
    Song(
      songName: "Surat Al-Ikhlas",
      artistName: "Abdullah Basfer",
      albumArtImagePath: "assets/images/surat-al-Ikhlas.jpg",
      audioPath: "audio/112.mp3",
    ),
    Song(
      songName: "Surat Al-Falaq",
      artistName: "Abdullah Basfer",
      albumArtImagePath: "assets/images/surat-al-falaq.jpg",
      audioPath: "audio/113.mp3",
    ),
    Song(
      songName: "Surat An-Nas",
      artistName: "Abdullah Basfer",
      albumArtImagePath: "assets/images/surat-al-Ikhlas.jpg",
      audioPath: "audio/114.mp3",
    ),
  ];

  //current song playing index
  int? _currentSongIndex;

//AUDIO PLAYER
  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  //constructor
  PlayListProvider() {
    listenToDuration();
  }
  //initially not playing
  bool _isPlaying = false;
  //play the song
  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop previous play
    await _audioPlayer.play(AssetSource(path)); //play new
    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //resume or pause
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        //go to next song if it is not last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //if last then play first
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async {
    //if more than 2 seconds then restart the song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    //if it is within 2 sec then go previous
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it is the first song ,loop back
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  //listen to duration
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    //listen for complete duration
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
  //dispose audio player

//getters
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

//setters

  set currentSongIndex(int? newIndex) {
    //update current song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(); //play the new index
    }
  }

  //ui update
  notifyListeners();
}
