//コメントの取得に関する処理を行うモデル

package model;

import java.util.List;

import dao.CommentDAO;

public class GetCommentListLogic {

  public List<Comment> execute(int r_id) {
    CommentDAO dao = new CommentDAO();
    List<Comment> commentList = dao.findBy(r_id);
    
    return commentList;
  }
}