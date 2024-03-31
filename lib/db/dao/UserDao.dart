import 'package:floor/floor.dart';

import '../entity/User.dart';

@dao
abstract class UserDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(User user);

  @Query('SELECT * FROM User')
  Future<List<User>> showAllUsers();
}
