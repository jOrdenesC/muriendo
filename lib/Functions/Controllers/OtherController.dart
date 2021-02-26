import 'dart:async';
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/GifData.dart';
import 'package:movitronia/Database/Repository/GifDataRepository.dart';
import 'package:movitronia/Database/Test/data.dart';
import 'package:quiver/async.dart';

class OtherController extends GetxController {
  //Database Variables
  GifDataRepository _gifRepository = GetIt.I.get();
  List<GifData> giflistdb = [];
  ValueKey keyCountdown;
  ValueKey keyDemonstration;
  GifController controller;
  //Controller CountDown
  CountDownController controllerCountDown = CountDownController();
  CountDownController controllerDemostration = CountDownController();
  var index = 0.obs;
  List<int> gifID = [12, 14, 15, 16];
  // List<String> giflist = ['0.gif', '1.gif', '2.gif', '3.gif'];
  //List<String> giflist = ['0.gif', 'C1.gif', 'C2.gif', 'C3.gif'];
  List<int> giftime = [5, 10, 6, 5, 7, 8, 5, 4, 4, 4, 4, 4];
  List<int> giftimepause = [4, 4, 6, 5, 4, 3, 5, 5, 5, 6, 5, 4];
  List<String> tips = [
    'Tip1',
    'Tip2',
    'Tip3',
    'Tip4',
    'Tip5',
    'Tip6',
    'Tip7',
    'Tip8',
    'Tip9',
    'Tip10',
    'Tip11'
  ];

  List<String> tipsData = [
    "LOS CARTÍLAGOS SON MAS BLANDOS QUE LOS HUESOS",
    "SABÍAS QUE LOS HUESOS ESTÁN FORMADO POR CALCIO Y FÓSFORO",
    "SABÍAS QUE EL CUERPO HUMANO DE UN ADULTO ESTA FORMADO POR 206 HUESOS",
    "CON LA ACTIVIDAD FISICA ELEVAS TU AUTOESTIMA",
    "SABÍAS QUE EL SUDOR ESTÁ COMPUESTO POR AGUA Y SAL",
    "LAS CAPACIDADES FÍSICAS BÁSICAS SON LA RESISTENCIA, VELOCIDAD, FUERZA Y FLEXIBILIDAD",
    "SABIAS QUE MAS DE LA MITAD DEL PESO DE TU CUERPO ESTA FORMADO POR AGUA",
    "LAS CUALIDADES COORDINATIVAS SON 4: AGILIDAD, RITMO, ORIENTACIÓN Y EQUILIBRIO",
    "LA ACTIVIDAD FÍSICA COMBATE EL SEDENTARISMO, ENEMIGO DE UNA BUENA SALUD",
    "TEN UNA BOTELLA CON AGUA CERCA PARA HIDRATARTE",
    "TEN UNA BOTELLA CON AGUA CERCA PARA HIDRATARTE"
  ];
  int precacheindex = 0;
  double amountofLoops = 0;
  //List<double> gifframes = [0, 22, 42, 33];
  // List<double> gifframes = [0, 14, 45, 54];
  /* List<Duration> gifduration = [
    Duration(milliseconds: 200),
    Duration(milliseconds: 600),
    Duration(milliseconds: 2200),
    Duration(milliseconds: 2230)
  ]; */
  String gifName = "Assets/images/C12.gif";
  ConfettiController controllerCenter;
  var isPause = false.obs;
  var location = false;
  var startgif = false;
  //This micropause determines any kind of pause in the application be a normal pause, or preparing for the next excercise
  var microPause = false.obs;
  //  GifController controller4
  Timer _timer;
  var startcounter = 5.obs;
  var gif = false.obs;
  bool change = false;
  var start = false;
  var demonstration = true.obs;
  bool almostFinish = false;

  precache() {
    for (var i = 1; i < giflistdb.length; i++) {
      fetchGif(AssetImage('Assets/images/' + giflistdb[i].name));
    }
  }

  List gifDataList = [
    gifdata,
    gifdata2,
    gifdata3,
    gifdata4,
    gifdata5,
    gifdata6,
    gifdata7,
    gifdata8,
    gifdata9,
    gifdata10,
    gifdata11,
    gifdata12,
    gifdata13
  ];

  insertData() async {
    for (var i = 0; i < gifDataList.length; i++) {
      var res = await _gifRepository.getGifID(gifDataList[i].id);
      if (res.isEmpty) {
        await _gifRepository.insertGif(gifDataList[i]);
      } else {
        print("Ya existe");
      }
    }
    // await _gifRepository.insertGif(gifdata);
    // await _gifRepository.insertGif(gifdata2);
    // await _gifRepository.insertGif(gifdata3);
    // await _gifRepository.insertGif(gifdata4);
    // await _gifRepository.insertGif(gifdata5);
    // await _gifRepository.insertGif(gifdata6);
    // await _gifRepository.insertGif(gifdata7);
    // await _gifRepository.insertGif(gifdata8);
    // await _gifRepository.insertGif(gifdata9);
    // await _gifRepository.insertGif(gifdata10);
    // await _gifRepository.insertGif(gifdata11);
    // await _gifRepository.insertGif(gifdata12);
    // await _gifRepository.insertGif(gifdata13);
  }

  precacheTest() {
    for (var i = 1; i <= 3; i++) {
      if (precacheindex < giflistdb.length) {
        PaintingBinding.instance.imageCache.clear();
        PaintingBinding.instance.imageCache.clearLiveImages();
        fetchGif(AssetImage('Assets/images/' + giflistdb[precacheindex].name));

        precacheindex++;
      }
    }
  }

  togglepause() {
    isPause.value = !isPause.value;
  }

  toggleGifbool() {
    gif.value = !gif.value;
  }

  void startTimer() {
    log('Start Timer Started');
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer _timer) => () {
              log('Inside Timer');
              if (startcounter.value.toInt() < 1) {
                _timer.cancel();
                start = true;
                startgif = true;
              } else {
                log(startcounter.toString());
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
        log('finished');
        start = true;
        startgif = true;
      }
    });
  }

  //Database Controller Actions
  getData() async {
    log('getting data');

    //await _gifRepository.updateGif(gifdata11);
    //await _gifRepository.insertGif(gifdata);
    //await _gifRepository.insertGif(gifdata2);
    //await _gifRepository.insertGif(gifdata13);
    await _loadGifs();
    amountofLoops = giflistdb.length / 3;
    //precache();
    precacheTest();
  }

  _loadGifs() async {
    final gifs = await _gifRepository.loopSearch([
      12,
      7,
      9,
      6,
      8,
      5,
      4,
      8,
      10,
      13,
      11
    ]); //1-2  calentamiento 3-8 desarrollo 9-10 vuelta a la calma
    //print(gifs[0].name);
    giflistdb = gifs;
    //print(giflistdb[0].name);
  }

  controllTimer() {
    //Check Precache TESTING
    if (index.value == precacheindex - 1) {
      precacheTest();
    }
    if (microPause.value == true) {
      print('micropause off');
      microPause.value = false;
    } else {
      print('microspause on');

      if (almostFinish == true) {
        print('finished');
        gif.value = true;
        // goToShowCalories();
      } else {
        microPause.value = true;
        print('MicroPause State ' + microPause.value.toString());
        index++;
        if (index.value == giflistdb.length - 1) {
          print('almost finished');
          almostFinish = true;
        }
        if (index > giflistdb.length) {
          //Move this garbage inside micropause on when index is changing
          controllerCenter.play();
          gif.value = true;

          update();
          controllerCountDown.pause();
          Future.delayed(Duration(seconds: 3), () {
            controllerCenter.stop();
          });
        } else {
          gifName = "Assets/images/${giflistdb[index.value].name}";
          controller.repeat(
              min: 0,
              max: giflistdb[index.value].maxFrames.toDouble(),
              period: Duration(
                  milliseconds: giflistdb[index.toInt()].gifduration.toInt()),
              reverse: false);
        }
      }
    }

    if (gif.value != true) {
      controllerCountDown.restart(duration: returnTimer());
    }
    //controller3.stop();
  }

  pauseController() {
    controller.repeat(
        min: 0,
        max: giflistdb[index.value]
            .maxFrames
            .toDouble(), //_.gifframes[_.index.toInt()],
        period: Duration(
            milliseconds: giflistdb[index.toInt()].gifduration.toInt()),
        reverse: false);
    if (isPause.value) {
      controllerCountDown.resume();
      togglepause();
    } else {
      controllerCountDown.pause();
      togglepause();
    }
  }

  int returnTimer() {
    List<int> returned;
    if (microPause.value == true) {
      returned = giftimepause;
    } else {
      returned = giftime;
    }
    print('Value of Returned ' + returned[index.value].toString());
    return returned[index.value].toInt();
  }
}
