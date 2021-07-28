//店舗データを削除するコントローラ

package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RestaurantDAO;
import model.GetRestaurantListLogic;
import model.Restaurant;

@WebServlet("/DeleteRestaurantServlet")
public class DeleteRestaurantServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//リクエストスコープから店舗ID(,店舗名)を取得
		int i = 1;
		String r_name = null;
		label: for (; i < 100; i++) {
			String str = String.valueOf(i);
			r_name = (String) request.getParameter(str);
			if (r_name != null) {
				break label;
			}
		}

		RestaurantDAO dao = new RestaurantDAO();
		boolean bo = dao.delete(i);
		if (bo) {
			request.setAttribute("deleteMsg", "登録店舗を1件削除しました。");
		}

		//表示する、更新された店舗一覧を取得
		GetRestaurantListLogic getRestaurantListLogic = new GetRestaurantListLogic();
		List<Restaurant> rList = getRestaurantListLogic.execute();

		// セッションスコープに全店舗リストを保存
		HttpSession session = request.getSession();
		session.setAttribute("rList", rList);

		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/admin.jsp");
		dispatcher.forward(request, response);
	}

}
