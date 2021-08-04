//BO。フォロー中の店舗情報をデータベースから取得する処理を行う。
package model;

import java.util.List;

import dao.FollowDAO;

public class GetFollowingListLogic {

	//ログインユーザーのフォロー中の店舗の情報を取得するメソッド
		public List<Integer> execute(String u_id) {
			FollowDAO dao = new FollowDAO();
			List<Integer> followList = dao.findBy(u_id);
			return followList;
		}
}

