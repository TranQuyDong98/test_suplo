import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_suplo/blocs/blocs.dart';
import 'package:test_suplo/data/model/model.dart';

class CustomDialog extends StatefulWidget {
  final String userId;
  final Post post;

  CustomDialog({this.userId, this.post});
  @override
  _CustomDialogState createState() =>
      _CustomDialogState(userId: userId ?? null, post: post ?? null);
}

class _CustomDialogState extends State<CustomDialog> {
  final String userId;
  final Post post;

  _CustomDialogState({this.userId, this.post});

  final title = TextEditingController();
  final content = TextEditingController();
  double radius = 10.0;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (post != null) {
      if (title.text == "" && post.title != null)
        title.text = post.title.toString();
      if (content.text == "" && post.content != null)
        content.text = post.content.toString();
    }

    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentDialog(context),
    );
  }

  Widget contentDialog(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Title...',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: content,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Content...',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      userId != null
                          ? BlocProvider.of<PostBloc>(context)
                              .add(CreatePostEvent(
                              title: title.text,
                              content: content.text,
                              userId: userId,
                            ))
                          : BlocProvider.of<PostBloc>(context)
                              .add(UpdatePostEvent(
                              title: title.text,
                              content: content.text,
                              userId: post.userId,
                              postId: post.id,
                            ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(userId != null ? 'Add' : 'Update'),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
