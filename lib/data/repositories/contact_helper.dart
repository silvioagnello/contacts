import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact_model.dart';

const String contactTable = 'contactTable';
const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String emailColumn = 'emailColumn';
const String phoneColumn = 'phoneColumn';
const String imgColumn = 'imgColumn';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();

  Database? _db;

  Future<Database> get db async {
    var currentDb = _db;
    if (currentDb == null) {
      currentDb = await initDb();
      _db = currentDb;
    }
    return currentDb;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'contacts.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          'CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, '
          '$phoneColumn TEXT, $imgColumn TEXT)');
    });
  }

  Future<ContactModel> saveContact(ContactModel contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(
        contactTable, contact.toMap() as Map<String, dynamic>);
    return contact;
  }

  Future<ContactModel?> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ContactModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int?> updateContact(ContactModel contact) async {
    Database dbContact = await db;
    await dbContact.update(
        contactTable, contact.toMap() as Map<String, dynamic>,
        where: '$idColumn = ?', whereArgs: [contact.id]);
  }

  getAllContacts() async {
    Database dbContact = await db;
    List listmaps = await dbContact.rawQuery('SELECT * FROM $contactTable');
    List<ContactModel> listContacts = <ContactModel>[];
    for (Map m in listmaps) {
      listContacts.add(ContactModel.fromMap(m));
    }
    return listContacts;
  }

  Future<int?> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery('SELECT COUNT(*) FROM $contactTable'));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
