import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String name = 'database.db';
  static const String tableStatement = 'Statement';
  static const String tableUser = 'User';
  static const String tablePortfolio = 'Portfolio';
  static const String tableProduct = 'Product';

  static Database? database;

  static Future<Database?> createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, name);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (
        Database database,
        int version,
      ) async {
        await database.execute(
          "CREATE TABLE $tableUser ("
          "id TEXT PRIMARY KEY,"
          "image TEXT,"
          "banner TEXT,"
          "username TEXT,"
          "firstName TEXT,"
          "surname TEXT,"
          "availableEarnings REAL,"
          "totalDeposits REAL,"
          "totalSale INTEGER,"
          "balance REAL,"
          "country TEXT,"
          "token TEXT,"
          "envatoToken TEXT,"
          "followers INTEGER,"
          "configs TEXT,"
          "permissions TEXT,"
          "lastUsed INTEGER,"
          "active INTEGER"
          ")",
        );
        await database.execute(
          "CREATE TABLE $tableStatement ("
          "id TEXT PRIMARY KEY,"
          "date INTEGER,"
          "orderID INTEGER,"
          "type TEXT,"
          "detail TEXT,"
          "itemID INTEGER,"
          "document TEXT,"
          "price REAL,"
          "auGTS REAL,"
          "euVAT REAL,"
          "usRWT REAL,"
          "usBWT REAL,"
          "amount REAL,"
          "site TEXT,"
          "country TEXT,"
          "region TEXT,"
          "city TEXT,"
          "zipCode TEXT,"
          "userID TEXT"
          ")",
        );
        await database.execute(
          "CREATE TABLE $tablePortfolio ("
          "id TEXT PRIMARY KEY,"
          "site TEXT,"
          "items INTEGER,"
          "userID TEXT"
          ")",
        );
        await database.execute(
          "CREATE TABLE $tableProduct ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "user TEXT,"
          "thumbnail TEXT,"
          "numberOfSale INTEGER,"
          "rating REAL,"
          "price REAL,"
          "uploadedOn INTEGER,"
          "lastUpdate INTEGER,"
          "tags TEXT,"
          "category TEXT,"
          "url TEXT,"
          "site TEXT,"
          "userID TEXT"
          ")",
        );
      },
      onUpgrade: (
        Database database,
        int oldVersion,
        int newVersion,
      ) {},
    );
    return database;
  }

  static Future<void> clearDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, name);
    await database!.close();
    await deleteDatabase(path);
    await createDatabase();
  }

  ///Singleton factory
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal();
}
