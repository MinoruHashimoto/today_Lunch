/*
 * コメントの投稿に関する処理を行うモデル
 */

package model;

import dao.CommentDAO;

public class PostCommentLogic {
  public void execute(Comment comment) {
    CommentDAO dao = new CommentDAO();
    dao.create(comment);
  }
}