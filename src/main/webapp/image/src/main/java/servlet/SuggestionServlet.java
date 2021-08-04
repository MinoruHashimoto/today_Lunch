//提案するレストランに関するリクエストを処理するコントローラ

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
import model.CheckFollowingLogic;
import model.GetAverageStarLogic;
import model.GetFollowerLogic;
import model.GetRestaurantListLogic;
import model.Restaurant;

@WebServlet("/SuggestionServlet")
public class SuggestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//リクエストスコープからrestaurantリスト取得（なければ新規作成）
		List<Restaurant> rList = (List<Restaurant>) request.getAttribute("rList");
		HttpSession session = request.getSession();
		if (rList == null) {
			rList = new ArrayList<>();
			session.setAttribute("rList", rList);
		}

		//セッションスコープに選択肢のデフォルト値を保存
		session.setAttribute("janru", "default");
		session.setAttribute("price", "default");

		//フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/suggestion.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		String janru = request.getParameter("janru");
		String price = request.getParameter("price");
		String keyword = request.getParameter("keyword");
		List<Restaurant> rList = (List<Restaurant>) request.getAttribute("rList");

		// 得たパラメータをセッションスコープに保存
		HttpSession session = request.getSession();
		session.setAttribute("janru", janru);
		session.setAttribute("price", price);
		session.setAttribute("keyword", keyword);

		//選択箇所がある場合のエラーメッセージリクエストスコープに保存
		if (janru.equals("default")) {
			request.setAttribute("jErr", "ジャンルを選択してください");
		}
		if (price.equals("default")) {
			request.setAttribute("pErr", "価格帯を選択してください");
		}

		//DBで該当する店を探し、そのリストをリクエストスコープに保存
		if (!janru.equals("default") && !price.equals("default")) {
			GetRestaurantListLogic getRListLogic = new GetRestaurantListLogic();
			rList = getRListLogic.execute(janru, price, keyword);

			//該当する店舗データがDB内にない場合、その旨を表示する
			if (rList.size() == 0) {
				request.setAttribute("noRestaurant", "該当する店が見つかりませんでした・・・");
			} else {//該当する店舗データがあった場合
				//ログイン中のユーザーのIDを取得
				Account account = (Account) session.getAttribute("account");
				String u_id = account.getUserId();
				for (int i = 0; i < rList.size(); i++) {

					//それぞれの店舗に対して,ログイン中のユーザーがフォローしているかどうかを確認し、セッションスコープに保存
					int r_id = rList.get(i).getId();
					String r_id_str = String.valueOf(r_id);
					CheckFollowingLogic cLogic = new CheckFollowingLogic();
					boolean doYouFollow = cLogic.execute(r_id, u_id);
					if (doYouFollow) {
						session.setAttribute("doYouFollow"+r_id_str, true);
					} else {
						session.setAttribute("doYouFollow"+r_id_str, false);
					}

					//それぞれの店舗のレビューの星の数の平均を、セッションスコープに保存
					GetAverageStarLogic gALogic = new GetAverageStarLogic();
					double avgStar = gALogic.execute(r_id);
					session.setAttribute("avg"+r_id_str, avgStar);
					
					
					//それぞれの店舗のフォロワー数を、セッションスコープに保存
					GetFollowerLogic gFLogic = new GetFollowerLogic();
					int follower = gFLogic.execute(r_id);
					session.setAttribute("follower"+r_id_str, follower);
					
					

				}

			}
		}
		if (rList != null) {
			session.setAttribute("rList", rList);
		}
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/WEB-INF/jsp/suggestion.jsp");
		dispatcher.forward(request, response);
	}
}
