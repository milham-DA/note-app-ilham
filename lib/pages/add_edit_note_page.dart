import 'package:flutter/material.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/widgets/note_form_widgets.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;
  const AddEditNotePage({super.key, this.note});

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _fromkey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [_buildButtonSave()],
      ),
      body: Form(
        key: _fromkey,
        child: NoteFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangeIsImportant: (value) {
              setState(() {
                isImportant = value;
              });
            },
            onChangeNumber: (value) {
              setState(() {
                number = value;
              });
            },
            onChangeTitle: (value) {
              title = value;
            },
            onChangeDescription: (value) {
              description = value;
            }),
      ),
    );
  }

  _buildButtonSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _fromkey.currentState!.validate();
          if (isValid) {
            if (widget.note != null) {
              await updateNote();
            } else {
              // TAMBAH DATA
              await addNote();
            }

            //KEMBALI KE HALAMAN SEBELUMNYA
            Navigator.pop(context);
          }
        },
        child: const Text("Save"),
      ),
    );
  }

  Future addNote() async {
    final note = Note(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description,
        createdTime: DateTime.now());
    await NoteDatabase.instance.create(note);
  }

  Future updateNote() async {
    final updatedNote = widget.note?.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );
    await NoteDatabase.instance.updateNote(updatedNote!);
  }
}
