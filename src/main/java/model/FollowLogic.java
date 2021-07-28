/**
 * フォロー処理を担当するBO 
 */

package model;

import dao.FollowDAO;

public class FollowLogic {
  public boolean execute(int r_id, String u_id) {
    FollowDAO dao = new FollowDAO();
    boolean bo = dao.create(r_id, u_id);
    return bo;
  }
}