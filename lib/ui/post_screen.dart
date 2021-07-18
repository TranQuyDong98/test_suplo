import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_suplo/blocs/blocs.dart';
import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/ui/screens.dart';

import '../routes.dart';

class PostScreen extends StatefulWidget {
  final String userId;

  PostScreen(this.userId);
  @override
  _PostScreenState createState() => _PostScreenState(userId);
}

class _PostScreenState extends State<PostScreen> {
  String userId;

  _PostScreenState(this.userId);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostBloc>(context).add(GetPostEvent(userId));
  }

  _addPost() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            userId: userId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Posts'),
        ),
        // leading: IconBt,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is InitPostState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.posts.length == 0) {
            return Center(child: Text('Post Empty!'),);
          }
          else {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return postItem(state.posts[index], userId);
              },
            );
          }

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPost,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget postItem(Post post, String userId) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.postDetailScreen,
              arguments: [post, userId]);
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4,),
                        Text(
                          post.content,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  post: post,
                                );
                              });
                        },
                      ),
                      // SizedBox(width: ,),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<PostBloc>(context)
                              .add(DeletePostEvent(
                            postId: post.id,
                            userId: post.userId,
                          ));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              indent: 1,
            )
          ],
        ));
  }
}
