//RESTAURANTテーブルを担当するDAO

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Restaurant;

public class RestaurantDAO {
	// データベース接続に使用する情報
	private final String JDBC_URL = "jdbc:mysql://localhost/today_lunch?useSSL=false";
	private final String DB_USER = "root";
	private final String DB_PASS = "root";
	private List<Restaurant> rList = new ArrayList<>();

	//JDBCドライバの読み込み
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static String makeSentence(String janru, String price) {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM RESTAURANT ");
		String wa = "WHERE JANRU = '和食' ";
		String yo = "WHERE JANRU = '洋食' ";
		String chu = "WHERE JANRU = '中華' ";
		String p800 = "PRICE <800 ";
		String p800to1500 = "PRICE BETWEEN 800 AND 1500 ";
		String p1501 = "PRICE >=1501  ";

		//選択したジャンルごとのSQL文
		switch (janru) {
		case "和食":
			sb.append(wa);
			break;
		case "洋食":
			sb.append(yo);
			break;
		case "中華":
			sb.append(chu);
			break;
		case "おまかせ":
			break;
		}

		//追加するSQL文
		if (!price.equals("こだわらない")) {
			if (janru.equals("おまかせ")) {
				sb.append("WHERE ");
			} else {
				sb.append("AND ");
			}

			switch (price) {
			case "800円未満":
				sb.append(p800);
				break;
			case "800円～1500円":
				sb.append(p800to1500);
				break;
			case "1501円以上":
				sb.append(p1501);
				break;
			}
		}
		String sql = sb.toString();
		return sql;
	}

	public static String makeSentence(String janru, String price, String keyword) {
		StringBuilder sb = new StringBuilder();
		String sql = makeSentence(janru, price);

		if ((price.equals("こだわらない")) && (janru.equals("おまかせ"))) {
			sb.append(sql).append("WHERE NAME LIKE '%").append(keyword).append("%' UNION ")
					.append(sql).append("WHERE DISHES LIKE '%").append(keyword).append("%' ");
		} else {
			sb.append(sql).append("AND NAME LIKE '%").append(keyword).append("%' UNION ")
					.append(sql).append("AND DISHES LIKE '%").append(keyword).append("%' ");
		}
		sql = sb.toString();
		return sql;

	}

	//提案画面で店舗検索結果表示に用いるメソッド
	public List<Restaurant> findBy(String janru_, String price_, String keyword) {
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {
			//選択したジャンル・価格帯に応じたSQL文作成を準備

			String sql;
			if (keyword == "") {
				sql = makeSentence(janru_, price_);
			} else {
				sql = makeSentence(janru_, price_, keyword);
			}
			//SQL文をDBに届けるPreparedStatementインスタンス取得
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();

			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				int id = rs.getInt("ID");
				String name = rs.getString("NAME");
				String janru = rs.getString("JANRU");
				String distance = rs.getString("DISTANCE");
				String holiday = rs.getString("HOLIDAY");
				String tel = rs.getString("TEL");
				int price = rs.getInt("PRICE");
				String dishes = rs.getString("DISHES");
				String url = rs.getString("URL");

				Restaurant restaurant = new Restaurant(id, name, janru, distance, holiday, tel, price, dishes, url);
				rList.add(restaurant);

				//レストランリストからランダムで１つ選ぶ（ジャンルをおまかせにした時に行う）
				if (janru_.equals("おまかせ")) {
					if (rList != null) {
						int num = new java.util.Random().nextInt(rList.size());
						Restaurant random = rList.get(num);
						rList.clear();
						rList.add(random);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();

			return null;
		}
		// 選んだ店リストまたはnullを返す

		return rList;
	}

	//クリックした店舗情報のコメント画面への表示に用いるメソッド
	public Restaurant findBy(int id) {
		Restaurant restaurant = null;
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			//SQL文の準備
			String sql = "SELECT * FROM RESTAURANT "
					+ "WHERE ID = '" + id + "' ";

			//SQL文をDBに届けるPreparedStatementインスタンス取得
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();

			// SELECT文の結果をRestaurantインスタンスに格納
			while (rs.next()) {
				id = rs.getInt("ID");
				String name = rs.getString("NAME");
				String janru = rs.getString("JANRU");
				String distance = rs.getString("DISTANCE");
				String holiday = rs.getString("HOLIDAY");
				String tel = rs.getString("TEL");
				int price = rs.getInt("PRICE");
				String dishes = rs.getString("DISHES");
				String url = rs.getString("URL");

				restaurant = new Restaurant(id, name, janru, distance, holiday, tel, price, dishes, url);

			}
		} catch (SQLException e) {
			e.printStackTrace();

			return null;
		}
		// 選んだ店またはnullを返す

		return restaurant;
	}

	//管理画面で店舗一覧表示に用いるメソッド
	public List<Restaurant> findAll() {
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			//SQL文を準備
			String sql = "SELECT * FROM RESTAURANT";

			//SQL文をDBに届けるPreparedStatementインスタンス取得
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();

			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				int id = rs.getInt("ID");
				String name = rs.getString("NAME");
				String janru = rs.getString("JANRU");
				String distance = rs.getString("DISTANCE");
				String holiday = rs.getString("HOLIDAY");
				String tel = rs.getString("TEL");
				int price = rs.getInt("PRICE");
				String dishes = rs.getString("DISHES");
				String url = rs.getString("URL");

				Restaurant restaurant = new Restaurant(id, name, janru, distance, holiday, tel, price, dishes, url);
				rList.add(restaurant);

			}
		} catch (SQLException e) {
			e.printStackTrace();

			return null;
		}
		return rList;
	}

	public boolean create(Restaurant restaurant) {
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// INSERT文の準備
			String sql = "INSERT INTO RESTAURANT(NAME, JANRU, DISTANCE HOLIDAY,"
					+ " TEL, PRICE, DISHES, URL) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			// INSERT文中の「?」に使用する値を設定しSQLを完成
			pStmt.setString(1, restaurant.getName());
			pStmt.setString(2, restaurant.getJanru());
			pStmt.setString(3, restaurant.getDistance());
			pStmt.setString(4, restaurant.getHoliday());
			pStmt.setString(5, restaurant.getTel());
			pStmt.setInt(6, restaurant.getPrice());
			pStmt.setString(7, restaurant.getDishes());
			pStmt.setString(8, restaurant.getUrl());

			// INSERT文を実行
			int result = pStmt.executeUpdate();

			if (result != 1) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public boolean change(Restaurant restaurant, int id) {
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// UPDATE文の準備
			String sql = "UPDATE RESTAURANT SET NAME=?, JANRU=?, DISTANCE=?, "
					+ "HOLIDAY=?, TEL=?, PRICE=?, DISHES=?, URL=? WHERE ID=?;";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			// INSERT文中の「?」に使用する値を設定しSQLを完成
			pStmt.setString(1, restaurant.getName());
			pStmt.setString(2, restaurant.getJanru());
			pStmt.setString(3, restaurant.getDistance());
			pStmt.setString(4, restaurant.getHoliday());
			pStmt.setString(5, restaurant.getTel());
			pStmt.setInt(6, restaurant.getPrice());
			pStmt.setString(7, restaurant.getDishes());
			pStmt.setString(8, restaurant.getUrl());
			pStmt.setInt(9, id);

			// INSERT文を実行
			int result = pStmt.executeUpdate();

			if (result != 1) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public boolean delete(int id) {

		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// INSERT文の準備
			String sql = "DELETE FROM RESTAURANT WHERE ID = ? ;";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			// DELETE文中の「?」に使用する値を設定しSQLを完成
			pStmt.setInt(1, id);

			// DELETE文を実行
			int result = pStmt.executeUpdate();

			if (result != 1) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}