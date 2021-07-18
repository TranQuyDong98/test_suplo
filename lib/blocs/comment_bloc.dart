import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/data/repositories/repositories.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentRepository _commentRepository = new CommentRepository();
  CommentBloc() : super(InitCommentState());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is GetCommentEvent) {
      yield LoadingComment.fromOldState(state);
      try {
        final List<Comment> comments =
            await _commentRepository.getComments(event.userId, event.postId);
        yield LoadSuccessComment.fromOldState(state, comments: comments);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

class CommentEvent {}

class GetCommentEvent extends CommentEvent {
  String userId;
  String postId;

  GetCommentEvent(this.userId, this.postId);
}

class CommentState {
  List<Comment> comments;

  CommentState({this.comments});
}

class InitCommentState extends CommentState {
  InitCommentState() : super(comments: []);
}

class LoadingComment extends CommentState {
  LoadingComment.fromOldState(CommentState oldSate, {List<Comment> comments})
      : super(
          comments: comments ?? oldSate.comments,
        );
}

class LoadSuccessComment extends CommentState {
  LoadSuccessComment.fromOldState(CommentState oldSate,
      {List<Comment> comments})
      : super(
          comments: comments ?? oldSate.comments,
        );
}

class LoadFailComment extends CommentState {}
