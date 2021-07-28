//登録店舗の管理に関するリクエストを処理するコントローラ

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

import model.AddRestaurantLogic;
import model.GetRestaurantListLogic;
import model.Restaurant;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {



		//フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/admin.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// リクエストパラメータの取得(数値でDBに入れる値はint型に修正しておく)
		request.setCharacterEncoding("UTF-8");
		
		String name = (String) request.getParameter("name");
		String janru = (String) request.getParameter("janru");
		String distance = (String) request.getParameter("distance");
		String holiday = (String) request.getParameter("holiday");
		String tel = (String) request.getParameter("tel");
		String price_String = (String) request.getParameter("price");
		String dishes = (String) request.getParameter("dishes");
		String url = (String) request.getParameter("url");

		int price = Integer.parseInt(price_String);
		
		//店舗を店舗リストに追加
		Restaurant restaurant = new Restaurant(name, janru, distance,
				holiday, tel, price, dishes, url);
		AddRestaurantLogic addRestaurantLogic = new AddRestaurantLogic();
		addRestaurantLogic.execute(restaurant);
		
		//表示する、更新された店舗一覧を取得
		GetRestaurantListLogic getRestaurantListLogic = new GetRestaurantListLogic();
		List<Restaurant> rList = getRestaurantListLogic.execute();
		
		//リクエストスコープに追加した店舗名、セッションスコープに全店舗リストを保存
		request.setAttribute("name", name);
		HttpSession session= request.getSession();
		session.setAttribute("rList", rList);

		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/admin.jsp");
		dispatcher.forward(request, response);
	}

}
