//店舗データ編集に関するコントローラ

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

import model.EditRestaurantLogic;
import model.GetRestaurantListLogic;
import model.Restaurant;

@WebServlet("/EditRestaurantServlet")
public class EditRestaurantServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		//リクエストスコープから店舗名,店舗IDを取得
		int i = 1;
		String r_name = null;
		label: for (; i < 100; i++) {
			String str = String.valueOf(i);
			r_name = (String) request.getParameter(str);
			if (r_name != null) {
				break label;
			}
		}

		//店舗情報を取得して、セッションスコープに保存
		GetRestaurantListLogic getRestaurantListLogic = new GetRestaurantListLogic();
		Restaurant restaurant = getRestaurantListLogic.execute(i);
		HttpSession session = request.getSession();
		session.setAttribute("restaurant", restaurant);
		

		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/editRestaurant.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		// リクエストパラメータの取得
		String name = (String) request.getParameter("name");
		String janru = (String) request.getParameter("janru");
		String distance = (String) request.getParameter("distance");
		String holiday = (String) request.getParameter("holiday");
		String tel = (String) request.getParameter("tel");
		String price_String = (String) request.getParameter("price");
		String dishes = (String) request.getParameter("dishes");
		String url = (String) request.getParameter("url");

		//数値でDBに入れる値はint型に修正しておく
		int price = Integer.parseInt(price_String);
		
		//IDはフォームで送られてこないので、
		//セッションスコープに入れていたrestaurantインスタンスのIDを利用する
		HttpSession session = request.getSession();
		Restaurant restaurant_ =(Restaurant) session.getAttribute("restaurant");
		int id = restaurant_.getId();
		
		//店舗を店舗リストに追加
		Restaurant restaurant = new Restaurant(id, name, janru, distance,
				holiday, tel, price, dishes, url);
		EditRestaurantLogic editRestaurantLogic = new EditRestaurantLogic();
		editRestaurantLogic.execute(restaurant, id);
		
		//表示する、更新された店舗一覧を取得
		GetRestaurantListLogic getRestaurantListLogic = new GetRestaurantListLogic();
		List<Restaurant> rList = getRestaurantListLogic.execute();
		
		//リクエストスコープに編集した店舗名、セッションスコープに全店舗リストを保存
		request.setAttribute("editMsg", "店舗情報が変更されました。");
		session.setAttribute("rList", rList);

		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/admin.jsp");
		dispatcher.forward(request, response);
	}

}
