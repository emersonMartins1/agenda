import 'package:flutter/material.dart';
import 'package:agenda/models/contact.dart';
import 'package:flutter/services.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  const ContactPage({required this.contact, Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();
  bool _userEdited = false;

  late Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = widget.contact!;

      _nameController.text = _editedContact.name!;
      _emailController.text = _editedContact.email ?? '';
      _phoneController.text = _editedContact.phone ?? '';
    }
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Descartar Alterações?'),
              content: const Text('Se sair as alterações serão perdidas.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Sim'),
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(_editedContact.name ?? 'Novo Contato'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedContact.name != null &&
                _editedContact.name!.isNotEmpty) {
              Navigator.pop(context, _editedContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: const Icon(Icons.save),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/person.png'),
                      fit: BoxFit.cover),
                ),
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.name = text;
                  });
                },
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.email = text;
                  });
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.phone = text;
                  });
                },
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
