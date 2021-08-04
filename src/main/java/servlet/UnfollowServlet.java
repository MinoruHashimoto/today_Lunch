//フォローを外す動作に関するリクエストを処理するコントローラ

package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Account;
import model.GetFollowerLogic;
import model.GetRestaurantListLogic;
import model.Restaurant;
import model.UnfollowLogic;

@WebServlet("/UnfollowServlet")
public class UnfollowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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

		//フォローテーブルのフォロー情報を一件削除する
		UnfollowLogic unfollowLogic = new UnfollowLogic();
		boolean bo = unfollowLogic.execute(i, u_id);
		if(bo) {//削除に成功した場合、フォローを外した店舗のIDを属性名とする
			//boolean型（false）のインスタンスを、セッションスコープに保存
			GetRestaurantListLogic gLogic = new GetRestaurantListLogic();
			Restaurant restaurant = gLogic.execute(i);
			int r_id = restaurant.getId();
			String r_id_str = String.valueOf(r_id);
			session.setAttribute("doYouFollow"+r_id_str, false);
			
			
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
