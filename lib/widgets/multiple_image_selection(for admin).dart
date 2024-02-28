    
import 'package:flutter/material.dart';
import 'package:movieticket/models/moviedata.dart';

class MovieCastField extends StatelessWidget {
  final Actor actor;
  final VoidCallback onDelete;
  
  MovieCastField({required this.actor, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
                backgroundImage: MemoryImage(actor.image),

      ),
      title: Text(actor.name),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
