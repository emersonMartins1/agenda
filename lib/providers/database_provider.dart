import 'package:sqflite/sqflite.dart';
import 'package:agenda/models/contact.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  Database? _db;

  factory DatabaseProvider() => _instance;

  DatabaseProvider._internal();

  Future<Database> get _database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await _initDb();
      return _db!;
    }
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    const sql = 'CREATE TABLE $contactTable('
        '$idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT)';

    return await openDatabase(path, version: 3,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await _database;

    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database dbContact = await _database;

    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.single);
    }

    return null;
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await _database;

    return await dbContact
        .delete(contactTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await _database;

    return await dbContact.update(contactTable, contact.toMap(),
        where: '$idColumn = ?', whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await _database;

    List listMap = await dbContact.rawQuery('SELECT * FROM $contactTable');
    List<Contact> listContact = [];
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }
}
