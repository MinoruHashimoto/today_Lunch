//FOLLOWテーブルを担当するDAO

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Follow;

public class FollowDAO {
	// データベース接続に使用する情報
	private final String JDBC_URL = "jdbc:mysql://localhost/today_lunch?useSSL=false";
	private final String DB_USER = "root";
	private final String DB_PASS = "root";

	//JDBCドライバの読み込み
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
//特定の店舗に対し、フォロー中かどうかを確認するメソッド
	public Follow findBy(int r_id, String u_id) {
		Follow follow = null;

		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			//SELECT文を準備
			String sql = "SELECT * FROM FOLLOW WHERE R_ID = ? AND U_ID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, r_id);
			pStmt.setString(2, u_id);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();

			// 一致するフォローデータが存在した場合
			if (rs.next()) {
				int id = rs.getInt("ID");
				r_id = rs.getInt("R_ID");
				u_id = rs.getString("U_ID");
				follow = new Follow(id, r_id, u_id);

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		// 見つかったフォローインスタンスまたはnullを返す
		return follow;
	}

	//ログインユーザーのフォロー中の店舗を取得するメソッド
	public List<Integer> findBy(String u_id) {
		List<Integer> followList = new ArrayList<>();
		
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {
			
			//SELECT文を準備
			String sql = "SELECT * FROM FOLLOW WHERE U_ID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, u_id);
			
			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();
			
			// 一致するフォローデータが存在した場合
			while (rs.next()) {
				int r_id = rs.getInt("R_ID");
				followList.add(r_id);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		// 取得したr_idまたは0を返す
		return followList;
	}
	
	public boolean create(int r_id, String u_id) {
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// INSERT文の準備
			String sql = "INSERT INTO FOLLOW(R_ID, U_ID) VALUES(?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			// INSERT文中の「?」に使用する値を設定しSQLを完成
			pStmt.setInt(1, r_id);
			pStmt.setString(2, u_id);

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

	public boolean delete(int r_id, String u_id) {
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {
			// DELETE文の準備
			String sql = "DELETE FROM FOLLOW WHERE R_ID = ? AND U_ID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			// DELETE文中の「?」に使用する値を設定しSQLを完成
			pStmt.setInt(1, r_id);
			pStmt.setString(2, u_id);

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

	//フォロワー数を数えるメソッド
	public int countFollower(int r_id) {
		int follower = 0;
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// SELECT文の準備
			String sql = "SELECT COUNT(ID) FROM FOLLOW WHERE R_ID = " + r_id;

			//SQL文をDBに届けるPreparedStatementインスタンス取得
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();
			// SELECT文の結果をfollowerに代入
			while (rs.next()) {
				follower = rs.getInt("COUNT(ID)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		// followerまたは0を返す
		return follower;
	}
}
