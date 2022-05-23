import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:githive/model/currency_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  static Box<CurrencyModel>? box;
  List<CurrencyModel>? data = [];

  Future<List<CurrencyModel>?> getData() async {
    emit(HomeLoadingState());
    try {
      await openBox();
      Response res = await Dio().get('https://nbu.uz/en/exchange-rates/json/');
      if (res.statusCode == 200) {
        List<CurrencyModel> resData =
            (res.data as List).map((e) => CurrencyModel.fromJson(e)).toList();
        emit(HomeComplateState(resData));
        await putData(resData);
        return resData;
      } else {
        emit(HomeErrorState("Check your Internet !!!"));
      }
    } catch (e) {
      emit(HomeErrorState("The Error could not be detected"));
    }
  }

  static openBox() async {
    box = await Hive.openBox("currency");
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  putData(var data) async {
    box!.clear();
    for (var item in data) {
      box!.add(item);
    }
  }
}
