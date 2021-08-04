/*
 * ログインに関するリクエストを処理するコントローラ 
 */

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
import model.LoginLogic;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;
  protected void doGet(HttpServletRequest request,
      HttpServletResponse response)
      throws ServletException, IOException {
	// フォワード
    RequestDispatcher dispatcher = request.getRequestDispatcher(
        "/WEB-INF/jsp/login.jsp");
    dispatcher.forward(request, response);
  }

  protected void doPost(HttpServletRequest request,
      HttpServletResponse response)
      throws ServletException, IOException {

	  // リクエストパラメータの取得
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");
	String pass = request.getParameter("pass");
	
	// ログイン処理の実行
	LoginLogic loginLogic = new LoginLogic();
	Account account = loginLogic.execute(userId, pass);
	
	// ログイン処理の成否によって処理を分岐
	if(account!=null) {	// ログイン成功時
		// セッションスコープにユーザーIDを保存
		HttpSession session= request.getSession();
		session.setAttribute("account", account);
		
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
		        "/WEB-INF/jsp/main.jsp");
		dispatcher.forward(request, response);
	}else {	// ログイン失敗時
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/loginNG.jsp");
		dispatcher.forward(request, response);
	}

  }
}