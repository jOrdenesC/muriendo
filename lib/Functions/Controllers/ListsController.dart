import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class ListController {
  List<String> exercisesCalentamiento = [];
  List<String> exercisesFlexibilidad = [];
  List<String> exercisesDesarrollo = [];
  List<String> exercisesVueltaCalma = [];

  //CALENTAMIENTO-------------------------------------------------------------------->>>>

  addCalentamiento(String item) async {
    log("item for add $item");
    var prefs = await SharedPreferences.getInstance();
    var listCalentamiento = prefs.getStringList("exercisesCalentamiento");
    log("antes de add $listCalentamiento");
    log("exercises cal $exercisesCalentamiento");
    if (listCalentamiento.toString() == "[]" || listCalentamiento == null) {
      log("list vacía, add exercisesCalentamiento");
      exercisesCalentamiento.add(item);
      prefs.setStringList("exercisesCalentamiento", exercisesCalentamiento);
      var max = prefs.getInt("maxcalentamiento");
      prefs.setInt("maxcalentamiento", max - 1);
    } else {
      log("list no vacía");
      exercisesCalentamiento.clear();
      listCalentamiento.add(item);
      prefs.setStringList("exercisesCalentamiento", listCalentamiento);
      var max = prefs.getInt("maxcalentamiento");
      prefs.setInt("maxcalentamiento", max - 1);
    }
    var act = prefs.getStringList("exercisesCalentamiento");
    log("actual " + act.toString());
  }

  removeCalentamiento(var item) async {
    print("Entra a remove calentamiento");
    var prefs = await SharedPreferences.getInstance();
    var listCalentamiento = prefs.getStringList("exercisesCalentamiento");
    log("antes de remove $listCalentamiento");
    if (listCalentamiento.toString() == "[]" || listCalentamiento == null) {
      exercisesCalentamiento.remove(item);
      prefs.setStringList("exercisesCalentamiento", exercisesCalentamiento);
      var max = prefs.getInt("maxcalentamiento");
      prefs.setInt("maxcalentamiento", max + 1);
    } else {
      listCalentamiento.remove(item);
      prefs.setStringList("exercisesCalentamiento", listCalentamiento);
      var max = prefs.getInt("maxcalentamiento");
      prefs.setInt("maxcalentamiento", max + 1);
    }
    var listCalentamiento1 = prefs.getStringList("exercisesCalentamiento");
    log("actual remove " + listCalentamiento1.toString());
  }

  Future<List<dynamic>> getExercisesCalentamiento() async {
    var prefs = await SharedPreferences.getInstance();
    var listCalentamiento = prefs.getStringList("exercisesCalentamiento");
    return listCalentamiento;
  }

  Future setMaxCalentamiento(int max, int maxTotal) async {
    var prefs = await SharedPreferences.getInstance();
    log("Ingresa a setMax CALENTAMIENTO con $max");
    prefs.setInt("maxcalentamiento", max);
    prefs.setInt("maxStaticCalentamiento", max);
    prefs.setInt("maxTotalCalentamiento", maxTotal);
    return null;
  }

  Future<int> getMaxCalentamiento() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxcalentamiento");
    log(max.toString());
    return max;
  }

  Future<int> getMaxStaticCalentamiento() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxStaticCalentamiento");
    log(max.toString());
    return max;
  }

  //FLEXIBILIDAD-------------------------------------------------------------------->>>>

  addFlexibilidad(String item) async {
    print("Entra a add flexibilidad");
    var prefs = await SharedPreferences.getInstance();
    var listFlexibilidad = prefs.getStringList("exercisesFlexibilidad");
    if (listFlexibilidad.toString() == "[]" || listFlexibilidad == null) {
      exercisesFlexibilidad.add(item);
      prefs.setStringList("exercisesFlexibilidad", exercisesFlexibilidad);
      var max = prefs.getInt("maxflexibilidad");
      prefs.setInt("maxflexibilidad", max - 1);
    } else {
      exercisesFlexibilidad.clear();
      listFlexibilidad.add(item);
      prefs.setStringList("exercisesFlexibilidad", listFlexibilidad);
      var max = prefs.getInt("maxflexibilidad");
      prefs.setInt("maxflexibilidad", max - 1);
    }

    print(listFlexibilidad);
  }

  removeFlexibilidad(var item) async {
    print("Entra a remove flexibilidad");
    var prefs = await SharedPreferences.getInstance();
    var listFlexibilidad = prefs.getStringList("exercisesFlexibilidad");
    if (listFlexibilidad.toString() == "[]" || listFlexibilidad == null) {
      exercisesFlexibilidad.remove(item);
      prefs.setStringList("exercisesFlexibilidad", exercisesFlexibilidad);
      var max = prefs.getInt("maxflexibilidad");
      prefs.setInt("maxflexibilidad", max + 1);
    } else {
      listFlexibilidad.remove(item);
      prefs.setStringList("exercisesFlexibilidad", listFlexibilidad);
      var max = prefs.getInt("maxflexibilidad");
      prefs.setInt("maxflexibilidad", max + 1);
    }
    var listFlexibilidad1 = prefs.getStringList("exercisesFlexibilidad");
    print(listFlexibilidad1);
  }

  Future<List<dynamic>> getExercisesFlexibilidad() async {
    var prefs = await SharedPreferences.getInstance();
    var listFlexibilidad = prefs.getStringList("exercisesFlexibilidad");
    return listFlexibilidad;
  }

  Future setMaxFlexibilidad(int max, int maxTotal) async {
    var prefs = await SharedPreferences.getInstance();
    log("Ingresa a setMax CALENTAMIENTO con $max");
    prefs.setInt("maxflexibilidad", max);
    prefs.setInt("maxStaticFlexibilidad", max);
    prefs.setInt("maxTotalFlexibilidad", maxTotal);
    return null;
  }

  Future<int> getMaxFlexibilidad() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxflexibilidad");
    log(max.toString());
    return max;
  }

  Future<int> getMaxStaticFlexibilidad() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxStaticFlexibilidad");
    log(max.toString());
    return max;
  }

  //DESAROLLO-------------------------------------------------------------------->>>>

  addDesarrollo(String item) async {
    print("Entra a add des");
    var prefs = await SharedPreferences.getInstance();
    var listDesarrollo = prefs.getStringList("exercisesDesarrollo");
    if (listDesarrollo.toString() == "[]" || listDesarrollo == null) {
      exercisesDesarrollo.add(item);
      prefs.setStringList("exercisesDesarrollo", exercisesDesarrollo);
      var max = prefs.getInt("maxdesarrollo");
      prefs.setInt("maxdesarrollo", max - 1);
    } else {
      exercisesDesarrollo.clear();
      listDesarrollo.add(item);
      prefs.setStringList("exercisesDesarrollo", listDesarrollo);
      var max = prefs.getInt("maxdesarrollo");
      prefs.setInt("maxdesarrollo", max - 1);
    }

    print(listDesarrollo);
  }

  removeDesarrollo(var item) async {
    print("Entra a remove des");
    var prefs = await SharedPreferences.getInstance();
    var listDesarrollo = prefs.getStringList("exercisesDesarrollo");
    if (listDesarrollo.toString() == "[]" || listDesarrollo == null) {
      exercisesDesarrollo.remove(item);
      prefs.setStringList("exercisesDesarrollo", exercisesDesarrollo);
      var max = prefs.getInt("maxdesarrollo");
      prefs.setInt("maxdesarrollo", max + 1);
    } else {
      listDesarrollo.remove(item);
      prefs.setStringList("exercisesDesarrollo", listDesarrollo);
      var max = prefs.getInt("maxdesarrollo");
      prefs.setInt("maxdesarrollo", max + 1);
    }
    var listDesarrollo1 = prefs.getStringList("exercisesDesarrollo");
    print(listDesarrollo1);
  }

  Future<List<dynamic>> getExercisesDesarrollo() async {
    var prefs = await SharedPreferences.getInstance();
    var listDesarrollo = prefs.getStringList("exercisesDesarrollo");
    return listDesarrollo;
  }

  Future setMaxDesarrollo(int max, int maxTotal) async {
    var prefs = await SharedPreferences.getInstance();
    log("Ingresa a setMax DESARROOLLO con $max");

    prefs.setInt("maxdesarrollo", max);
    prefs.setInt("maxStaticDesarrollo", max);
    prefs.setInt("maxTotalDesarrollo", maxTotal);
    print("a");
    var res = prefs.getInt("maxdesarrollo");
    print(res);
    return null;
  }

  Future<int> getMaxDesarrollo() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxdesarrollo");
    log(max.toString());
    return max;
  }

  Future<int> getMaxStaticDesarrollo() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxStaticDesarrollo");
    log(max.toString());
    return max;
  }

  //VUELTA A LA CALMA-------------------------------------------------------------------->>>>

  addVueltaCalma(String item) async {
    print("Entra a add vuelta");
    var prefs = await SharedPreferences.getInstance();
    var listVueltaCalma = prefs.getStringList("exercisesVueltaCalma");
    if (listVueltaCalma.toString() == "[]" || listVueltaCalma == null) {
      exercisesVueltaCalma.add(item);
      prefs.setStringList("exercisesVueltaCalma", exercisesVueltaCalma);
      var max = prefs.getInt("maxvueltacalma");
      prefs.setInt("maxvueltacalma", max - 1);
    } else {
      exercisesVueltaCalma.clear();
      listVueltaCalma.add(item);
      prefs.setStringList("exercisesVueltaCalma", listVueltaCalma);
      var max = prefs.getInt("maxvueltacalma");
      prefs.setInt("maxvueltacalma", max - 1);
    }

    print(listVueltaCalma);
  }

  removeVueltaCalma(var item) async {
    print("Entra a remove vuelta");
    var prefs = await SharedPreferences.getInstance();
    var listVueltaCalma = prefs.getStringList("exercisesVueltaCalma");
    if (listVueltaCalma.toString() == "[]" || listVueltaCalma == null) {
      exercisesVueltaCalma.remove(item);
      prefs.setStringList("exercisesVueltaCalma", exercisesVueltaCalma);
      var max = prefs.getInt("maxvueltacalma");
      prefs.setInt("maxvueltacalma", max + 1);
    } else {
      listVueltaCalma.remove(item);
      prefs.setStringList("exercisesVueltaCalma", listVueltaCalma);
      var max = prefs.getInt("maxvueltacalma");
      prefs.setInt("maxvueltacalma", max + 1);
    }
    var listVueltaCalma1 = prefs.getStringList("exercisesVueltaCalma");
    print(listVueltaCalma1);
  }

  Future<List<dynamic>> getExercisesVueltaCalma() async {
    var prefs = await SharedPreferences.getInstance();
    var listVueltaCalma = prefs.getStringList("exercisesVueltaCalma");
    return listVueltaCalma;
  }

  Future setMaxVueltaCalma(int max, int maxTotal) async {
    var prefs = await SharedPreferences.getInstance();
    log("Ingresa a setMax VUELTACALMA con $max");

    prefs.setInt("maxvueltacalma", max);
    prefs.setInt("maxStaticVueltaCalma", max);
    prefs.setInt("maxTotalVueltaCalma", maxTotal);
    print("a");
    var res = prefs.getInt("maxvueltacalma");
    print(res);
    return null;
  }

  Future<int> getMaxVueltaCalma() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxvueltacalma");
    log(max.toString());
    return max;
  }

  Future<int> getMaxStaticVueltaCalma() async {
    var prefs = await SharedPreferences.getInstance();
    var max = prefs.getInt("maxStaticVueltaCalma");
    log(max.toString());
    return max;
  }

  finishCreateClass() async {
    var prefs = await SharedPreferences.getInstance();

    prefs.remove("maxcalentamiento");
    prefs.remove("maxStaticCalentamiento");
    prefs.remove("exercisesCalentamiento");

    prefs.remove("maxflexibilidad");
    prefs.remove("maxStaticFlexibilidad");
    prefs.remove("exercisesFlexibilidad");

    prefs.remove("maxdesarrollo");
    prefs.remove("maxStaticDesarrollo");
    prefs.remove("exercisesDesarrollo");

    prefs.remove("maxvueltacalma");
    prefs.remove("maxStaticVueltaCalma");
    prefs.remove("exercisesVueltaCalma");
  }
}
