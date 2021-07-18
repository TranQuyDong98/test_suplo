import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/data/repositories/post_repository.dart';
import 'package:test_suplo/data/repositories/repositories.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository _postRepository = new PostRepository();
  PostBloc() : super(InitPostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is GetPostEvent) {
      yield LoadingPost.fromOldState(state);
      try {
        final List<Post> posts = await _postRepository.getPosts(event.userId);
        yield LoadSuccessPost.fromOldState(state, posts: posts);
      } catch (e) {
        print(e.toString());
      }
    }

    if (event is CreatePostEvent) {
      yield LoadingPost.fromOldState(state);
      try {
        List<Post> posts = state.posts;
        final Post post = await _postRepository.createPost(
          userId: event.userId,
          title: event.title,
          content: event.content,
        );
        if (post != null) {
          posts.add(post);
          yield LoadSuccessPost.fromOldState(state, posts: posts);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    if (event is UpdatePostEvent) {
      yield LoadingPost.fromOldState(state);
      try {
        List<Post> posts = state.posts;
        final Post post = await _postRepository.updatePost(
          userId: event.userId,
          postId: event.postId,
          title: event.title,
          content: event.content,
        );
        posts[posts.indexWhere((element) => element.id == post.id)] = post;

        yield LoadSuccessPost.fromOldState(state, posts: posts);
      } catch (e) {
        print(e.toString());
      }
    }

    if (event is DeletePostEvent) {
      yield LoadingPost.fromOldState(state);
      try {
        List<Post> posts = state.posts;
        final Post post = await _postRepository.deletePost(
          userId: event.userId,
          postId: event.postId,
        );
        posts.removeWhere((element) => element.id == post.id);

        yield LoadSuccessPost.fromOldState(state, posts: posts);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

class PostEvent {}

class GetPostEvent extends PostEvent {
  String userId;
  GetPostEvent(this.userId);
}

class CreatePostEvent extends PostEvent {
  String title;
  String content;
  String userId;

  CreatePostEvent({
    this.title,
    this.content,
    this.userId,
  });
}

class UpdatePostEvent extends PostEvent {
  String title;
  String content;
  String userId;
  String postId;

  UpdatePostEvent({
    this.title,
    this.content,
    this.userId,
    this.postId,
  });
}

class DeletePostEvent extends PostEvent {
  String userId;
  String postId;

  DeletePostEvent({
    this.userId,
    this.postId,
  });
}

class PostState {
  List<Post> posts;

  PostState({this.posts});
}

class InitPostState extends PostState {
  InitPostState() : super(posts: []);
}

class LoadingPost extends PostState {
  LoadingPost.fromOldState(PostState oldSate, {List<Post> posts})
      : super(
          posts: posts ?? oldSate.posts,
        );
}

class LoadSuccessPost extends PostState {
  LoadSuccessPost.fromOldState(PostState oldSate, {List<Post> posts})
      : super(
          posts: posts ?? oldSate.posts,
        );
}

class LoadFailPost extends PostState {}
