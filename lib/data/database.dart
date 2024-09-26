abstract class Database {
  Future<void> open();

  Future<void> close();

  Future<void> delete();
}
