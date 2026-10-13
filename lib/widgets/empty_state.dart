import 'package:flutter/material.dart';


class EmptyState extends StatelessWidget {

  final VoidCallback onCreate;


  const EmptyState({

    super.key,

    required this.onCreate,

  });



  @override
  Widget build(BuildContext context) {


    return Center(

      child: Padding(

        padding: const EdgeInsets.all(24),


        child: Column(


          mainAxisSize: MainAxisSize.min,


          children: [



            const Text(

              '📝',

              style: TextStyle(

                fontSize: 48,

              ),

            ),



            const SizedBox(height: 12),



            const Text(

              'No notes yet',

              style: TextStyle(

                fontSize: 20,

                fontWeight: FontWeight.bold,

              ),

            ),



            const SizedBox(height: 8),



            const Text(

              'Write your first note. It is private: only you can see it.',

              textAlign: TextAlign.center,

            ),



            const SizedBox(height: 20),



            ElevatedButton(


              onPressed: onCreate,


              child: const Text(

                'Create a note',

              ),


            )


          ],


        ),


      ),


    );


  }


}