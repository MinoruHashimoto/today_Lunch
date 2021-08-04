//提案するレストランに関するリクエストを処理するコントローラ

package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;

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
	static Scanner sc = new Scanner(System.in);

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
		session.setAttribute("sort", "default");

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
		String sort = request.getParameter("sort");
		List<Restaurant> rList = (List<Restaurant>) request.getAttribute("rList");

		// 得たパラメータをセッションスコープに保存
		HttpSession session = request.getSession();
		session.setAttribute("janru", janru);
		session.setAttribute("price", price);
		session.setAttribute("keyword", keyword);
		session.setAttribute("sort", sort);

		//DBで該当する店を探し、そのリストをリクエストスコープに保存
		GetRestaurantListLogic getRListLogic = new GetRestaurantListLogic();
		rList = getRListLogic.execute(janru, price, keyword, sort);

		//該当する店舗データがDB内にない場合、その旨を表示する
		if (rList.size() == 0) {
			request.setAttribute("noRestaurant", "該当する店が見つかりませんでした・・・");
		} else {//該当する店舗データがあった場合

			//「評価が高い順」に並び変える用のマップを用意
			Map<Restaurant, Double> rMap = new HashMap<Restaurant, Double>();

			//ログイン中のユーザーのIDを取得
			Account account = (Account) session.getAttribute("account");
			String u_id = account.getUserId();
			for (int i = 0; i < rList.size(); i++) {

				int r_id = rList.get(i).getId();
				String r_id_str = String.valueOf(r_id);

				//それぞれの店舗のレビューの星の数の平均を、セッションスコープに保存
				GetAverageStarLogic gALogic = new GetAverageStarLogic();
				double avgStar = gALogic.execute(r_id);
				session.setAttribute("avg" + r_id_str, avgStar);

				//rMapにも保存
				rMap.put(rList.get(i), (Double) avgStar);

				//それぞれの店舗に対して,ログイン中のユーザーがフォローしているかどうかを確認し、セッションスコープに保存
				CheckFollowingLogic cLogic = new CheckFollowingLogic();
				boolean doYouFollow = cLogic.execute(r_id, u_id);
				if (doYouFollow) {
					session.setAttribute("doYouFollow" + r_id_str, true);
				} else {
					session.setAttribute("doYouFollow" + r_id_str, false);
				}

				//それぞれの店舗のフォロワー数を、セッションスコープに保存
				GetFollowerLogic gFLogic = new GetFollowerLogic();
				int follower = gFLogic.execute(r_id);
				session.setAttribute("follower" + r_id_str, follower);
			}

			/*「評価が高い順」に並び替える場合、まずrListをカラにし、
			 * そこにrMapの要素を、評価の高い順に入れる
			 */
			if (sort.equals("評価が高い順")) {
				rList.clear();

				//Map.Entryのリストを作成する
				List<Entry<Restaurant, Double>> list_entries = new ArrayList<Entry<Restaurant, Double>>(
						rMap.entrySet());

				Collections.sort(list_entries, new Comparator<Entry<Restaurant, Double>>() {
					//compareを使用して値を比較する
					public int compare(Entry<Restaurant, Double> obj1, Entry<Restaurant, Double> obj2) {
						//降順
						return obj2.getValue().compareTo(obj1.getValue());
					}
				});

				// 7. ループで要素順に値を取得する
				for (Entry<Restaurant, Double> entry : list_entries) {
					rList.add(entry.getKey());
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
