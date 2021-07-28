/**
 * フォロー状況の確認処理を担当するBO 
 */

package model;

import dao.FollowDAO;

public class CheckFollowingLogic {
  public boolean execute(int r_id, String u_id) {
    FollowDAO dao = new FollowDAO();
    Follow follow = dao.findBy(r_id, u_id);
    return follow != null;
  }
}