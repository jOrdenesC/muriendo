import 'dart:async';
import 'dart:developer';
import 'dart:io';

//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:movitronia/Database/Repository/TipsDataRepository/TipsDataRepository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/async.dart';
import 'package:video_player/video_player.dart';
import '../../Design/All/SessionPage/ShowCalories.dart';

class Mp4Controller extends GetxController {
  //Video Controllers

  VideoPlayerController videoPlayerController1;

  //AUdio Controller
  //final assetsAudioPlayer = AssetsAudioPlayer();
  //Database Variables
  ExcerciseDataRepository _excerciseRepository = GetIt.I.get();
  ClassDataRepository _classRepository = GetIt.I.get();
  TipsDataRepository _tipsDataRepository = GetIt.I.get();
  List<ExcerciseData> giflistdb =
      []; //Remove this and make 4 list for each step
  var step = 0.obs;
  var percentage = 0.0.obs;
  List<dynamic> excerciseCalentamientoList = [];
  List<dynamic> excerciseFlexibilidadList = [];
  List<dynamic> excerciseDesarrolloList = [];
  List<dynamic> excerciseVcalmaList = [];
  List<dynamic> recordingList = [];
  List<dynamic> documentIds = [];

  List<String> exercisesAudio = [];
  List<String> macroTipsAudio = [];

  List<dynamic> metsList = [];
  //List of Times MicroPause and MacroPause
  List<dynamic> pauses = [];
  List<dynamic> times = [];
  List<dynamic> microTime = [];
  List<dynamic> macroTime = [];

  List exercisesCalentamiento = [].obs;
  List exercisesDesarrollo = [].obs;
  List exercisesVueltaCalma = [].obs;

  String classID;

  List<List<dynamic>> macroList = [];

  List<dynamic> excerciseNames = [];

  var macroTip = "SOme Text".obs;
  //Name of Video
  var videoName = "".obs;
  //Audio Controller
  //omoi ga omoi omoi-san   / bite marks / sekimen shinaide sekime-san/ 329748 / takane no hana wa usotsuki desu/ dont cry maou chan /
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  //final assetsAudioPlayer = AssetsAudioPlayer.withId("music");

  //Controller CountDown
  CountDownController controllerCountDown = CountDownController();
  CountDownController controllerDemostration = CountDownController();
  var globalindex = 0.obs;
  var index = 0.obs;
  var dir;

  int giftime = 5;
  int giftimepause = 5;

  var tip = "".obs;

  List<String> tips = [];

  List<String> tipsData = [];
  List<String> tipIDs = [];

  var isPause = false.obs;
  var location = false;
  var startgif = false;
  //This micropause determines any kind of pause in the application be a normal pause, or preparing for the next excercise
  var microPause = false.obs;
  var macroPause = false.obs;
  //  GifController controller4
  Timer _timer;

  Timer timer;
  var startcounter = 5.obs;
  var macrocounter = 0.obs;
  var gif = false.obs;
  bool change = false;
  var start = false;
  var demonstration = true.obs;
  bool firstCicle = false;

  Future<void> initializePlayer() async {
    var dirinit = await getApplicationDocumentsDirectory();
    dir = dirinit;
    if (Platform.isAndroid) {
      videoPlayerController1 = VideoPlayerController.file(
          File('${dir.path}/videos/${videoName.value}.webm'));

      await videoPlayerController1
        ..initialize().then((value) => null)
        ..setLooping(true)
        ..play();
    } else if (Platform.isIOS) {
      videoPlayerController1 = VideoPlayerController.file(File(
          '${dir.path}/videos/${videoName.value.replaceAll(" ", "")}.mp4'));

      await videoPlayerController1
        ..initialize().then((value) => null)
        ..setLooping(true)
        ..play();
    }

    videoPlayerController1.obs;
  }

  togglepause() {
    isPause.value = !isPause.value;
  }

  toggleGifbool() {
    gif.value = !gif.value;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer _timer) => () {
              if (startcounter.value.toInt() < 1) {
                _timer.cancel();
                start = true;
                startgif = true;
              } else {
                startcounter.value = -1;
              }
            });
  }

  void startTimer2() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: 5),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen((null));
    sub.onData((duration) {
      startcounter.value = 5 - duration.elapsed.inSeconds;
      if (startcounter.value == 0) {
   
        start = true;
        startgif = true;
      }
    });
  }

  macroTimer(List<dynamic> tips, int loops, int time, List<dynamic> audioName) {
    int i = 0;
    macroTip.value = tips[i];
    playAudio(audioName[i], true);
    update();
    timer = Timer.periodic(Duration(seconds: time), (Timer _) {
      if (i != loops) {
        i++;
        macroTip.value = tips[i];
        playAudio(audioName[i], true);
        update();
      } else {
        timer.cancel();
      } // Update something...
    });
  }

  void macroTipMethod(int index) async {
    List<dynamic> tips = [];
    List<dynamic> audioTip = [];
    if (macroList[index].length != 1) {
      for (int i = 0; i < macroList[index].length; i++) {
        final result = await _tipsDataRepository.getTips(macroList[index][i]);
        tips.add(result[0].tip);
        audioTip.add(result[0].audioTips);
      }
      /**Setting Counter for MacroTimer */
      double getTime = macroTime[index] / macroList[index].length;
      macrocounter.value = getTime.floor();
      int loops = macroList[index].length;
      macroTimer(tips, loops, getTime.floor(), audioTip);
      print(tips);
    } else {
      macroTip.value = "Prepárate para el Siguiente Ejercicio";
    }
  }

  playTip(String documentID) async {
    final result = await _tipsDataRepository.getTips(documentID);
    if (result.isNotEmpty) {
      playAudio(result[0].audioTips, true);
    }
  }

  playAudio(String audioName, bool tip) async {
    print("Play Audio");
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
    }
    //Testing Out a List with audio Names
    //audioPlayer = await audioCache.play('audio/${exercisesAudio[index.value]}');
    if (tip == true) {
      await audioPlayer.play("${dir.path}/audios/$audioName");
    } else {
      await audioPlayer.play("${dir.path}/audios/$audioName.mp3");
    }
  }

  //Database Controller Actions
  getData(String id) async {
    // playAudio();
    await gettingdatabase(id);

    initializePlayer();
  }

  gettingdatabase(String id) async {
    //Obtain ID from external page when selecting class
    excerciseCalentamientoList.clear();
    excerciseFlexibilidadList.clear();
    excerciseDesarrolloList.clear();
    excerciseVcalmaList.clear();
    var obj = {};
    final responseclass =
        await _classRepository.getClassID(id); //Get Class Index
    pauses = responseclass[0].pauses;
    times = responseclass[0].macropause;
    excerciseCalentamientoList = responseclass[0].excerciseCalentamiento;
    for (int i = 0; i < responseclass[0].excerciseCalentamiento.length; i++) {
      //Loop through class excercises by category
      final responseDB = await _excerciseRepository
          .getExcerciseName(responseclass[0].excerciseCalentamiento[i]);
      String value = responseDB[0].excerciseNameAudioId;
      exercisesAudio.add(value);
      obj = {
        "time": responseclass[0].timeCalentamiento,
        "mets": responseDB[0].mets
      };
      metsList.add(obj);
      excerciseNames
          .add(responseDB[0].nameExcercise); //Creating list of categories name
    }
    excerciseFlexibilidadList = responseclass[0].excerciseFlexibilidad;
    for (int i = 0; i < responseclass[0].excerciseFlexibilidad.length; i++) {
      //Loop through class excercises by category
      final responseDB = await _excerciseRepository
          .getExcerciseName(responseclass[0].excerciseFlexibilidad[i]);
      //print("Excercise ID $i :  ${responseDB[0].nameExcercise}");
      String value = responseDB[0].excerciseNameAudioId;
      exercisesAudio.add(value); //Creating list of categories name
      obj = {
        "time": responseclass[0].timeFlexibilidad,
        "mets": responseDB[0].mets
      };
      metsList.add(obj);
      excerciseNames.add(responseDB[0].nameExcercise);
    }
    excerciseDesarrolloList = responseclass[0].excerciseDesarrollo;
    recordingList.add(excerciseDesarrolloList[0]);
    recordingList
        .add(excerciseDesarrolloList[excerciseDesarrolloList.length - 1]);
    for (int i = 0; i < responseclass[0].excerciseDesarrollo.length; i++) {
      //Loop through class excercises by category
      final responseDB = await _excerciseRepository
          .getExcerciseName(responseclass[0].excerciseDesarrollo[i]);
      String value = responseDB[0].excerciseNameAudioId;
      exercisesAudio.add(value); //Creating list of categories name
      obj = {
        "time": responseclass[0].timeDesarrollo,
        "mets": responseDB[0].mets
      };
      metsList.add(obj);
      excerciseNames.add(responseDB[0].nameExcercise);
    }
    excerciseVcalmaList = responseclass[0].excerciseVueltaCalma;
    for (int i = 0; i < responseclass[0].excerciseVueltaCalma.length; i++) {
      //Loop through class excercises by category
      final responseDB = await _excerciseRepository
          .getExcerciseName(responseclass[0].excerciseVueltaCalma[i]);
      //print("Excercise ID $i :  ${responseDB[0].nameExcercise}");
      String value = responseDB[0].excerciseNameAudioId;
      exercisesAudio.add(value); //Creating list of categories name
      obj = {"time": responseclass[0].timeVcalma, "mets": responseDB[0].mets};
      metsList.add(obj);
      excerciseNames.add(responseDB[0].nameExcercise);
    }
    List<dynamic> gettimes = [];
    for (int i = 0; i <= 3; i++) {
      if (i == 0) {
        gettimes.add(responseclass[0].timeCalentamiento);
      } else if (i == 1) {
        gettimes.add(responseclass[0].timeFlexibilidad);
      } else if (i == 2) {
        gettimes.add(responseclass[0].timeDesarrollo);
      } else if (i == 3) {
        gettimes.add(responseclass[0].timeVcalma);
      }
      times = gettimes;
    }
    List<String> tipsList = [];
    List<String> tipsID = [];
    List<dynamic> empty = ["   Prepárate para el \nsiguiente ejercicio"];

    /**Values for each macro index */
    int macro1 = excerciseCalentamientoList.length - 1;
    int macro2 = excerciseCalentamientoList.length +
        excerciseFlexibilidadList.length -
        1;
    int macro3 = excerciseCalentamientoList.length +
        excerciseFlexibilidadList.length +
        excerciseDesarrolloList.length -
        1;
    for (int i = 0; i < responseclass[0].tips.length; i++) {
      if (responseclass[0].tips[i].toString() == "[]") {
        tipsList.add("    Prepárate para el \nsiguiente ejercicio");
        tipsID.add("[]");
        if (i == macro1 || i == macro2 || i == macro3) {
          macroList.add(empty);
        }
      } else {
        if (i == macro1 || i == macro2 || i == macro3) {
          print("TIP Into Macro");
          tipsList.add("   Prepárate para el \nsiguiente ejercicio");
          macroList.add(responseclass[0].tips[i]);
          for (int i = 0; i < responseclass[0].tips[i].length; i++) {
            print("Result : ${responseclass[0].tips[i][0].toString()}");
          }
          tipsID.add("[]");
          macroTipsAudio.add("[]");
        } else {
          final result =
              await _tipsDataRepository.getTips(responseclass[0].tips[i][0]);
          tipsList.add(result[0].tip);
          tipsID.add(result[0].documentID);
        }
      }
    }
    documentIds = responseclass[0].tips;
    //Making MicroTimes
    macroTime.add(pauses[excerciseCalentamientoList.length - 1]);
    macroTime.add(pauses[excerciseFlexibilidadList.length +
        excerciseCalentamientoList.length -
        1]);
    macroTime.add(pauses[excerciseDesarrolloList.length +
        excerciseFlexibilidadList.length +
        excerciseCalentamientoList.length -
        1]);
    /**Finishing it */
    //Making MicroTimes
    microTime.add(pauses[excerciseCalentamientoList.length - 2]);
    microTime.add(pauses[excerciseFlexibilidadList.length +
        excerciseCalentamientoList.length -
        2]);
    microTime.add(pauses[excerciseDesarrolloList.length +
        excerciseFlexibilidadList.length +
        excerciseCalentamientoList.length -
        2]);
    microTime.add(pauses[excerciseDesarrolloList.length +
        excerciseFlexibilidadList.length +
        excerciseCalentamientoList.length +
        excerciseVcalmaList.length -
        2]);
    /**Finishing it */
    tipsData = tipsList;
    tipIDs = tipsID; //Document ID to general TipID
    videoName.value = excerciseCalentamientoList[0];
  }

  controllTimer(String idClass, List questionnaire, int number, String phase,
      bool isCustom) {
    if (step <= 3) {
      if (microPause.value != true) {
        microPause.value = true;
        index.value++;
        globalindex++;
        if (firstCicle == true) {}

        if (step.value == 0) {
          if (index.value != excerciseCalentamientoList.length) {
            playTip(tipIDs[globalindex.value - 1]);
            videoName.value = excerciseCalentamientoList[index.value];
          } else {
            macroTipMethod(0);
            index.value = 0;
            step.value++;
            videoName.value = excerciseFlexibilidadList[index.value];
            macroPause.value = true;
          }
          print("On Step Updating Controller");
          updateController();
        } else if (step.value == 1) {

          if (index.value != excerciseFlexibilidadList.length) {
            playTip(tipIDs[globalindex.value - 1]);
            videoName.value = excerciseFlexibilidadList[index.value];
          } else {
            macroTipMethod(1);
            update();
            index.value = 0;
            step.value++;
            videoName.value = excerciseDesarrolloList[index.value];
            macroPause.value = true;
          }
          updateController();
        } else if (step.value == 2) {

          if (index.value != excerciseDesarrolloList.length) {
            playTip(tipIDs[globalindex.value - 1]);
            videoName.value = excerciseDesarrolloList[index.value];
          } else {
            macroTipMethod(2);
            index.value = 0;
            step.value++;
            videoName.value = excerciseVcalmaList[index.value];
            macroPause.value = true;
          }
          updateController();
        } else if (step.value == 3) {

          if (index.value != excerciseVcalmaList.length) {
            playTip(tipIDs[globalindex.value - 1]);
            videoName.value = excerciseVcalmaList[index.value];
          } else {
            Get.to(ShowCalories(
              mets: metsList,
              exercises: recordingList,
              idClass: idClass,
              questionnaire: questionnaire,
              number: number,
              phase: phase,
              isCustom: isCustom,
            ));
            index.value = 0;
          }
          updateController();
        }

      } else {
        playAudio(exercisesAudio[globalindex.value], false);
        microPause.value = false;
        //MacroPause Must be under here deactivated
        macroPause.value = false;
      }
    }

    if (gif.value != true) {
      controllerCountDown.restart(duration: returnTimer());
    }
  }

  updateController() async {
    //Remove Video Controller and reload video
    if (Platform.isIOS) {
      videoPlayerController1.dispose();
      videoPlayerController1 = VideoPlayerController.file(
          File('${dir.path}/videos/${videoName.value.replaceAll(" ", "")}.mp4'))
        ..setLooping(true)
        ..initialize().then((value) => null)
        ..play();

      update();
    } else if (Platform.isAndroid) {
      videoPlayerController1.dispose();
      videoPlayerController1 = VideoPlayerController.file(
          File('${dir.path}/videos/${videoName.value}.webm'));

      await videoPlayerController1
        ..initialize().then((value) => null)
        ..setLooping(true)
        ..play();

      update();
    }
  }

  pauseController() {
    if (isPause.value) {
      controllerCountDown.resume();
      togglepause();
    } else {
      controllerCountDown.pause();
      togglepause();
    }
  }

  int returnTimer() {
    int returned;
    if (microPause.value == true && macroPause.value == false) {
      returned = microTime[step.value];
    } else if (macroPause.value == true) {
      returned = macroTime[step.value - 1];
    } else {
      returned = times[step.value];
    }
    return returned;
  }
}
