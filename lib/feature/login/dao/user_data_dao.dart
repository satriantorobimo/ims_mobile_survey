import 'package:floor/floor.dart';

import '../data/user_data_model.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM User WHERE id = :id')
  Future<User?> findUserById(int id);

  @Query('DELETE FROM User WHERE id = :id')
  Future<void> deleteUserById(int id);

  @insert
  Future<void> insertUser(User user);
}
