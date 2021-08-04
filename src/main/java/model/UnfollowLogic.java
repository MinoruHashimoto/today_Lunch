/**
 * フォローを外す処理を担当するBO 
 */

package model;

import dao.FollowDAO;

public class UnfollowLogic {
  public boolean execute(int r_id, String u_id) {
    FollowDAO dao = new FollowDAO();
    boolean bo = dao.delete(r_id, u_id);
    return bo;
  }
}