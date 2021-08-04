//フォロワー数の取得に関する処理を行うモデル

package model;

import dao.FollowDAO;

public class GetFollowerLogic {

  public int execute(int r_id) {
    FollowDAO dao = new FollowDAO();
    int follower = dao.countFollower(r_id);
    
    return follower;
  }
}