import 'package:contacts/data/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final ContactModel? contact;

  ContactPage({this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late ContactModel _editContact;
  bool _userEdited = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editContact = ContactModel();
    } else {
      _editContact = ContactModel.fromMap(widget.contact!.toMap());
      _nameController.text = _editContact.name!;
      _emailController.text = _editContact.email!;
      _phoneController.text = _editContact.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var imagem = (_editContact.img != null)
        ? FileImage(File(_editContact.img!))
        : Image.asset('assets/images/man.png') as ImageProvider<Object>;

    return PopScope(
      onPopInvoked: (_) async {
        _requestPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_editContact.name ?? 'Novo contato'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ImagePicker.platform
                      .getImageFromSource(source: ImageSource.gallery)
                      .then((value) {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        _editContact.img = value.path;
                      });
                    }
                  });
                },
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imagem,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editContact.name = text;
                  });
                },
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _emailController,
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Fone'),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.phone = text;
                },
              ),
              Text(_editContact.img.toString()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editContact.name != null && _editContact.name!.isNotEmpty) {
                Navigator.pop(context, _editContact);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            child: const Icon(Icons.save)),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCELAR')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('SIM')),
            ],
            content: Text('Perderá as alterações!!!'),
            title: Text('Descartar'),
          );
        },
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
