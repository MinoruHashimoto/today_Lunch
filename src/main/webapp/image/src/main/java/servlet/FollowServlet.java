//フォローに関するリクエストを処理するコントローラ

package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Account;
import model.FollowLogic;
import model.GetAverageStarLogic;
import model.GetFollowerLogic;
import model.GetFollowingListLogic;
import model.GetRestaurantListLogic;
import model.Restaurant;

@WebServlet("/FollowServlet")
public class FollowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<Integer> r_idList = new ArrayList<>();
		List<Restaurant> followList = new ArrayList<>();
		
		//セッションスコープからログイン中ユーザーのIDを取得
		HttpSession session = request.getSession();
		Account account = (Account)session.getAttribute("account");
		String u_id = account.getUserId();
		
		//フォロー中店舗のIDリストをDBのFOLLOWテーブルから取得
		GetFollowingListLogic getFListLogic = new GetFollowingListLogic();
		r_idList = getFListLogic.execute(u_id);
		
		if(r_idList!=null && r_idList.size()!=0) {
			//IDリストにある店舗をDBのRESTAURANTテーブルから取得し、セッションスコープに保存
			
			for(int r_id : r_idList) {
				GetRestaurantListLogic getRListLogic = new GetRestaurantListLogic();
				Restaurant restaurant = getRListLogic.execute(r_id);
				followList.add(restaurant);
				

				String r_id_str = String.valueOf(r_id);
				//それぞれの店舗のレビューの星の数の平均を、セッションスコープに保存
				GetAverageStarLogic gALogic = new GetAverageStarLogic();
				double avgStar = gALogic.execute(r_id);
				session.setAttribute("avg"+r_id_str, avgStar);
				
				
				//それぞれの店舗のフォロワー数を、セッションスコープに保存
				GetFollowerLogic gFLogic = new GetFollowerLogic();
				int follower = gFLogic.execute(r_id);
				session.setAttribute("follower"+r_id_str, follower);
			}
			session.setAttribute("followList", followList);
		}else {
			request.setAttribute("noRestaurant", "noRestaurant");
		}
		
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/following.jsp");
		dispatcher.forward(request, response);
	}

		protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//リクエストスコープから店舗IDを取得
		int i = 1;
		String r_name = null;
		label: for (; i < 100; i++) {
			String str = String.valueOf(i);
			r_name = (String) request.getParameter(str);
			if (r_name != null) {
				break label;
			}
		}
		
		// セッションスコープに保存されているユーザー情報を取得
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		String u_id = account.getUserId();
		
		//フォローテーブルに新規フォロー情報を追加する
		FollowLogic followLogic = new FollowLogic();
		boolean bo = followLogic.execute(i, u_id);
		if(bo) {//追加に成功した場合、フォローした店舗のIDを属性名とする
			//boolean型（true）のインスタンスを、セッションスコープに保存
			GetRestaurantListLogic gLogic = new GetRestaurantListLogic();
			Restaurant restaurant = gLogic.execute(i);
			int r_id = restaurant.getId();
			String r_id_str = String.valueOf(r_id);
			session.setAttribute("doYouFollow"+r_id_str, true);
			
			
			//更新されたフォロワー数を、セッションスコープに保存
			GetFollowerLogic gFLogic = new GetFollowerLogic();
			int follower = gFLogic.execute(r_id);
			session.setAttribute("follower"+r_id_str, follower);
			
		}
		
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/suggestion.jsp");
		dispatcher.forward(request, response);
	}

}
