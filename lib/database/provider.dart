import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final String name = 'database.db';
  static final String tableStatement = 'Statement';
  static final String tableUser = 'User';
  static final String tablePortfolio = 'Portfolio';
  static final String tableProduct = 'Product';
  static Database? database;

  Future<Database?> createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, name);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  Future<void> clearDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, name);
    await database!.close();
    await deleteDatabase(path);
    await createDatabase();
  }

  Future<void> onCreate(
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
      "main INTEGER"
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
      "zipCode TEXT"
      ")",
    );
    await database.execute(
      "CREATE TABLE $tablePortfolio ("
      "id TEXT PRIMARY KEY,"
      "site TEXT,"
      "items INTEGER"
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
      "site TEXT"
      ")",
    );
  }

  Future<void> onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {}

  ///Singleton factory
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal();
}
