import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/auth_provider.dart';
import '../services/notes_service.dart';
import '../widgets/note_input_dialog.dart';
import '../widgets/note_item.dart';
import '../widgets/empty_state.dart';



class NotesScreen extends StatefulWidget {

  const NotesScreen({super.key});


  @override
  State<NotesScreen> createState() => _NotesScreenState();

}



class _NotesScreenState extends State<NotesScreen> {


  List<Note> _notes = [];

  bool _loading = true;

  String? _error;



  @override
  void initState() {

    super.initState();

    _load();

  }





  Future<void> _load() async {


    setState(() {

      _loading = true;

      _error = null;

    });



    try {
      final userId = context.read<AuthProvider>().user?.$id;

      if (userId == null) {
        if (!mounted) return;
        setState(() {
          _error = 'Please log in to view your notes';
          _notes = [];
        });
        return;
      }

      final notes = await notesService.list(userId);

      if (!mounted) return;

      setState(() {
        _notes = notes;
      });
    } on AppwriteException catch (e) {

      if (!mounted) return;


      setState(() {

        _error =
            e.message ?? 'Could not load notes';

      });


    } finally {


      if (mounted) {


        setState(() {

          _loading = false;

        });


      }


    }


  }





  void _showError(String message) {


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(message),

      ),

    );


  }







  Future<void> _add() async {
    final auth = context.read<AuthProvider>();

    final draft =
        await showNoteInputDialog(context);

    if (draft == null) return;

    try {
      final userId = auth.user?.$id;

      if (userId == null) {
        _showError('Please log in first');
        return;
      }

      final created = await notesService.create(        userId,
        draft,
      );



      if (!mounted) return;



      setState(() {


        _notes.insert(
          0,
          created,
        );


      });



    } on AppwriteException catch(e) {


      _showError(
        e.message ?? 'Could not save note',
      );


    }


  }







  Future<void> _edit(Note note) async {


    final draft =
        await showNoteInputDialog(

          context,

          initial: note,

        );



    if (draft == null) return;



    try {


      final updated =
          await notesService.update(

        note.id,

        draft,

      );



      if (!mounted) return;



      setState(() {


        final index =
            _notes.indexWhere(
              (n) => n.id == note.id,
            );


        _notes[index] = updated;



      });



    } on AppwriteException catch(e) {


      _showError(
        e.message ?? 'Could not update note',
      );


    }


  }







  Future<void> _delete(Note note) async {


    final confirm =
        await showDialog<bool>(


      context: context,


      builder: (context) => AlertDialog(

        title:
            const Text('Delete note'),


        content:
            Text('Delete "${note.title}"?'),


        actions: [


          TextButton(

            onPressed: () =>
                Navigator.pop(context,false),


            child:
                const Text('Cancel'),

          ),



          FilledButton(

            onPressed: () =>
                Navigator.pop(context,true),


            child:
                const Text('Delete'),

          ),


        ],


      ),


    );



    if (confirm != true) return;



    try {


      await notesService.delete(
        note.id,
      );



      if (!mounted) return;



      setState(() {


        _notes.removeWhere(
          (n) => n.id == note.id,
        );


      });



    } on AppwriteException catch(e) {


      _showError(
        e.message ?? 'Could not delete note',
      );


    }


  }








  @override
  Widget build(BuildContext context) {



    Widget body;



    if (_loading && _notes.isEmpty) {


      body = const Center(

        child:
            CircularProgressIndicator(),

      );



    } else if (_error != null) {



      body = Center(


        child: Column(


          mainAxisSize:
              MainAxisSize.min,


          children: [


            Text(_error!),



            const SizedBox(height:12),



            FilledButton(

              onPressed: _load,


              child:
                  const Text('Retry'),

            )


          ],


        ),


      );



    } else {



      body = RefreshIndicator(


        onRefresh: _load,


        child:


        _notes.isEmpty


            ? ListView(

                children: [

                  EmptyState(

                    onCreate: _add,

                  ),

                ],

              )



            : ListView.builder(


                padding:
                    const EdgeInsets.all(8),


                itemCount:
                    _notes.length,


                itemBuilder:
                    (context,index) {


                  final note =
                      _notes[index];



                  return NoteItem(

                    key:
                        ValueKey(note.id),


                    note:
                        note,


                    onEdit:
                        () => _edit(note),


                    onDelete:
                        () => _delete(note),

                  );


                },


              ),


      );


    }




    return Scaffold(


      appBar:
          AppBar(

        title:
            const Text('My Notes'),

      ),



      body:
          body,



      floatingActionButton:


          FloatingActionButton(


        onPressed:
            _add,


        tooltip:
            'Add note',


        child:
            const Icon(Icons.add),


      ),



    );


  }


}