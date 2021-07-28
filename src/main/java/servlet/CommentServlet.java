//コメント欄に関するリクエストを処理するコントローラ

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

import model.Comment;
import model.GetCommentListLogic;
import model.GetRestaurantListLogic;
import model.PostCommentLogic;
import model.Restaurant;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		//リクエストスコープから店舗名,店舗IDを取得し、セッションスコープに保存
		int i = 1;
		String r_name = null;
		label: for (; i < 100; i++) {
			String str = String.valueOf(i);
			r_name = (String) request.getParameter(str);
			if (r_name != null) {
				break label;
			}
		}
		HttpSession session = request.getSession();
		session.setAttribute("r_id", i);
		session.setAttribute("r_name", r_name);

		//店舗情報を取得して、セッションスコープに保存
		GetRestaurantListLogic getRestaurantListLogic = new GetRestaurantListLogic();
		Restaurant restaurant = getRestaurantListLogic.execute(i);
		session.setAttribute("restaurant", restaurant);

		
		// コメントリストを取得して、リクエストスコープに保存
		GetCommentListLogic getCommentListLogic = new GetCommentListLogic();
		List<Comment> cList = getCommentListLogic.execute(i);
		session.setAttribute("cList", cList);
				
		//該当するコメントデータがDB内になければその旨を表示する
		if (cList.size() == 0) {
			request.setAttribute("noComment", "コメントはまだありません。");
		}

		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/comment.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		String text = request.getParameter("text");

		// セッションスコープに保存されているユーザー情報と店舗名を取得
		HttpSession session = request.getSession();
		int r_id = (int) session.getAttribute("r_id");
		String userId = (String) session.getAttribute("userId");

		// コメントをコメントリストに追加
		Comment comment = new Comment(r_id, userId, text);
		PostCommentLogic postCommentLogic = new PostCommentLogic();
		postCommentLogic.execute(comment);

		// コメントリストを取得して、リクエストスコープに保存
		GetCommentListLogic getCommentListLogic = new GetCommentListLogic();
		List<Comment> cList = getCommentListLogic.execute(r_id);
		session.setAttribute("cList", cList);

		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/comment.jsp");
		dispatcher.forward(request, response);
	}

}
