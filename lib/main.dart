import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Executando Sons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache _audioCache = AudioCache(prefix: "audios/");
  bool _primaryPlayer = true;
  double _volume = 0.5;

  _playAudio() async {
    _audioPlayer.setVolume(_volume);
    if(_primaryPlayer){
      _audioPlayer = await _audioCache.play("La_Chica.mp3");
      _primaryPlayer = false;
    }
    else{
      _audioPlayer.resume();
    }
  }

  _pausarAudio() async {
    int result = await _audioPlayer.pause();
    if(result == 1){
      //Secesso
    }
  }

  _pararAudio() async {
    int result = await _audioPlayer.stop();
    if(result == 1){
      //Secesso
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Executando Som"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Slider(
              value: _volume,
              min: 0,
              max: 1,
              onChanged: (novoVolume){
                setState(() {
                  _volume = novoVolume;
                });
                _audioPlayer.setVolume(novoVolume);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    child: Image.asset("assets/images/executar.png"),
                    onTap: _playAudio,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    child: Image.asset("assets/images/pausar.png"),
                    onTap: _pausarAudio,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    child: Image.asset("assets/images/parar.png"),
                    onTap: _pararAudio,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
