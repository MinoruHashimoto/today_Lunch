//フォローに関するリクエストを処理するコントローラ

package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.FollowLogic;
import model.GetRestaurantListLogic;
import model.Restaurant;

@WebServlet("/FollowServlet")
public class FollowServlet extends HttpServlet {
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
		String userId = (String) session.getAttribute("userId");

		//フォローテーブルに新規フォロー情報を追加する
		FollowLogic followLogic = new FollowLogic();
		boolean bo = followLogic.execute(i, userId);
		if(bo) {//追加に成功した場合、フォローした店舗のIDを属性名とする
			//boolean型（true）のインスタンスを、セッションスコープに保存
			GetRestaurantListLogic gLogic = new GetRestaurantListLogic();
			Restaurant restaurant = gLogic.execute(i);
			int r_id = restaurant.getId();
			String r_id_str = String.valueOf(r_id);
			session.setAttribute(r_id_str, true);
		}
		
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/suggestion.jsp");
		dispatcher.forward(request, response);
	}

}
