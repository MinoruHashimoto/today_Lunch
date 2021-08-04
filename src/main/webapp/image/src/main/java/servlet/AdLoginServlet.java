/*
 * 管理者ログインに関するリクエストを処理するコントローラ 
 */

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

import model.AdLoginLogic;
import model.GetRestaurantListLogic;
import model.Restaurant;

@WebServlet("/AdLoginServlet")
public class AdLoginServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;
  protected void doGet(HttpServletRequest request,
      HttpServletResponse response)
      throws ServletException, IOException {
	// フォワード
    RequestDispatcher dispatcher = request.getRequestDispatcher(
        "/WEB-INF/jsp/adLogin.jsp");
    dispatcher.forward(request, response);
  }

  protected void doPost(HttpServletRequest request,
      HttpServletResponse response)
      throws ServletException, IOException {

	  // リクエストパラメータの取得
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	// 管理者ログイン処理の実行
	AdLoginLogic bo = new AdLoginLogic();
	boolean result = bo.execute(id, pass);
	
	// 管理者ログイン処理の成否によって処理を分岐
	if(result) {	// ログイン成功時
		//表示する店舗一覧を取得
		GetRestaurantListLogic getRestaurantListLogic = new GetRestaurantListLogic();
		List<Restaurant> rList = getRestaurantListLogic.execute();
		
		// セッションスコープに管理者情報と全店舗リストを保存
		HttpSession session= request.getSession();
		session.setAttribute("id", id);
		session.setAttribute("rList", rList);
		
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
		        "/WEB-INF/jsp/admin.jsp");
		dispatcher.forward(request, response);
	}else {	// ログイン失敗時
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/adLoginNG.jsp");
		dispatcher.forward(request, response);
	}

  }
}