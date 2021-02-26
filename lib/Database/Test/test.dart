import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';

class HomePageTest extends StatefulWidget {
  @override
  _HomePageTestState createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  ExcerciseDataRepository _gifRepository = GetIt.I.get();
  List<ExcerciseData> _gif = [];

  @override
  void initState() {
    super.initState();
    _loadGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorite Gif"),
      ),
      body: ListView.builder(
        itemCount: _gif.length,
        itemBuilder: (context, index) {
          final gif = _gif[index];
          return ListTile(
            title: Text(gif.nameExcercise),
            subtitle: Text("LimitLoop: ${gif.videoName}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteCake(gif),
            ),
            leading: IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () => _editCake(gif),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addGif,
      ),
    );
  }

  _loadGifs() async {
    final gifs = await _gifRepository.getAllExcercise();
    setState(() => _gif = gifs);
  }

  _addGif() async {
    // final list = ["apple", "orange", "chocolate"]..shuffle();
    // final name = "My amazing ${list.first} gif";
    // final nameexercise = 'Some Name';
    // final duration = Duration(milliseconds: 600);
    final newGif = ExcerciseData(
        videoName: 'C1.gif',
        mets: 12,
        nameExcercise: 'SKIPPING',
        recommendation: 'NO Explotes');
    final response = await _gifRepository.insertExcercise(newGif);
    print(response);
    _loadGifs();
  }

  _deleteCake(ExcerciseData gifData) async {
    await _gifRepository.deleteExcercise(gifData.id);
    _loadGifs();
  }

  _editCake(ExcerciseData gifData) async {
    final updatedCake =
        gifData.copyWith(nameExcercise: gifData.nameExcercise + ' something');
    await _gifRepository.updateExcercise(updatedCake);
    _loadGifs();
  }
}
