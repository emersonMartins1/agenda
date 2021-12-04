const String contactTable = 'contactTable';
const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String emailColumn = 'emailColumn';
const String phoneColumn = 'phoneColumn';

class Contact {
  int? id;
  String? name;
  String? email;
  String? phone;

  Contact();

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }
}
