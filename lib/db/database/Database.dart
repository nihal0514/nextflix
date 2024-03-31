import 'dart:async';

import 'package:floor/floor.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/UserDao.dart';
import '../entity/User.dart';

part 'Database.g.dart';

@Database(version: 1, entities: [User])
abstract class MyAppDatabase extends FloorDatabase {
  UserDao get userDao;
}
