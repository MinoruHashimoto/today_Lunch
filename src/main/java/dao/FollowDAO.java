//FOLLOWテーブルを担当するDAO

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

}