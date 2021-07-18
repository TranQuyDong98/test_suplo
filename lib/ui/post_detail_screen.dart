import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_suplo/blocs/blocs.dart';
import 'package:test_suplo/data/model/model.dart';

class PostDetailScreen extends StatefulWidget {
  final String userId;
  final Post post;
  PostDetailScreen(this.userId, this.post);
  @override
  _PostDetailScreenState createState() =>
      _PostDetailScreenState(this.userId, this.post);
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final String userId;
  final Post post;
  _PostDetailScreenState(this.userId, this.post);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CommentBloc>(context)
        .add(GetCommentEvent(this.userId, this.post.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(this.post.title),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              detailPost(post),
              SizedBox(
                height: 20,
              ),
              commentPost(),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailPost(Post post) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              post.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Text(
          post.content,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget commentPost() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            'Comments',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Divider(
          indent: 1,
        ),
        Flexible(
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is InitCommentState || state is LoadingComment) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return commentItem(state.comments[index]);
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget commentItem(Comment comment) {
    return Container(
      padding: EdgeInsets.only(left: 6, top: 6,),
        child: Row(
      children: [
        Container(
          child: FittedBox(
            fit: BoxFit.fill,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/default_avatar.png"),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 10,),
        Container(
          padding: EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: Colors.black12
          ),
          child: Text(comment.content),)
      ],
    ));
  }
}
