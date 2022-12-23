import 'package:shared_preferences/shared_preferences.dart';

class ShowMessagesModel {
  String? sId;
  String? subjectText;
  String? subjectId;
  String? text;
  String? type;
  String? createdAt;
  String? fromId;
  String? fromUsername;
  String? toId;
  String? toUsername;
  String? me;
  String? subredditName;
  int i = 0;
  ShowMessagesModel(
      {this.sId,
      this.subjectId,
      this.subjectText,
      this.text,
      this.type,
      this.fromId,
      this.fromUsername,
      this.createdAt,
      this.toId,
      this.subredditName,
      this.toUsername});

  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    me = prefs.getString('userName') as String;
  }

  int checkToOrFrom(userFrom, userTo) {
    return (me == userTo) ? 0 : 1;
  }

  String getText(type, user, subreddit) {
    String text = '';
    if (type == 'subredditBan') {
      text = 'u/$user has been banned from participating in r/$subreddit';
    } else if (type == 'subredditMute') {
      text = 'u/$user has been muted from r/$subreddit';
    } else if (type == 'subredditModeratorInvite') {
      text = 'Invitation to moderate r/$subreddit';
    } else if (type == 'subredditModeratorRemove') {
      text = 'u/$user has been removed as moderator from r/$subreddit';
    } else if (type == 'subredditApprove') {
      text = 'u/$user is an approved user';
    }
    return text;
  }

  String getBody(type, user, subreddit, fixed) {
    String body = '';
    if (type == 'subredditBan') {
      body =
          'u/$user have been banned from participating in r/$subreddit.You can still view and subscribe to r/$subreddit,but you won\'t be able to post or comment.If you have a question regarding your ban,you can contact moderator theam for r/$subreddit.';
    } else if (type == 'subredditMute') {
      body =
          'u/$user have been muted from r/$subreddit. You will not be able to message the moderators of r/$subreddit for 3 days';
    } else if (type == 'subredditModeratorInvite') {
      body =
          'u/$user is invited to become a moderator of r/$subreddit : r/$fixed! \n to accept,visit the moderators page for r/$subreddit.Otherwise if you did not expect to recieve this,you can simply ignore this invitation or report it. ';
    } else if (type == 'subredditModeratorRemove') {
      body =
          'u/$user: You have been removed as a moderator from r/$subreddit.If you have a question regarding your removal,tou can contact moderator of r/$subreddit';
    } else if (type == 'subredditApprove') {
      body =
          'u/$user have been added as an approved user to r/$subreddit : r/$fixed';
    }
    return body;
  }

  ShowMessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'subredditBan' ||
        json['type'] == 'subredditMute' ||
        json['type'] == 'subredditModeratorInvite' ||
        json['type'] == 'subredditModeratorRemove' ||
        json['type'] == 'subredditApprove' ||
        json['type'] == 'userMessage') {
      sId = (json['_id'] == null) ? '' : json['_id'] as String;
      fromId =
          (json['from']['_id'] == null) ? '' : json['from']['_id'] as String;
      fromUsername = json['from']['userName'] ?? '';
      toId = (json['to']['_id'] == null) ? '' : json['to']['_id'] as String;
      toUsername = json['to']['userName'] ?? '';
      i = checkToOrFrom(fromUsername, toUsername);
      if (json['subject'] != null) {
        subjectId = (json['subject']['_id'] == null)
            ? ''
            : json['subject']['_id'] as String;
        subjectText =
            (json['subject']['text'] == null) ? '' : json['subject']['text'];
        //invitation,approved
      } else {
        subredditName = json['subreddit']['fixedName'] ?? '';
        subjectId = (json['subreddit']['_id'] == null)
            ? ''
            : json['subreddit']['_id'] as String;
        subjectText = getText(json['type'], json['to']['userName'],
            json['subreddit']['fixedName']);
      }
      if (json['type'] == 'userMessage') {
        text = json['text'];
      } else {
        text = getBody(
            json['type'],
            toUsername,
            json['subreddit']['fixedName'] ?? '',
            json['subreddit']['name'] ?? '');
      }

      type = json['type'];

      createdAt = json['createdAt'];
    }
  }
}
