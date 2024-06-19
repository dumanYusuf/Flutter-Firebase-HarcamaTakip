

import 'package:get_it/get_it.dart';
import 'package:harcama_takip/repo/database_repository.dart';
import 'package:harcama_takip/servis/base/authServis/auth_servis.dart';
import 'package:harcama_takip/servis/base/databaseServis/database_servis.dart';

GetIt locator=GetIt.instance;

setUpLocator(){
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => AuthServis());
  locator.registerLazySingleton(() => DatabaseServis());
}