//commentテーブルを担当するDAO 

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Comment;

public class CommentDAO {
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

	public List<Comment> findBy(int r_id) {
		List<Comment> cList = new ArrayList<>();
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// SELECT文の準備
			String sql = "SELECT * FROM COMMENT WHERE R_ID = '" + r_id
					+ "' ORDER BY ID DESC";

			//SQL文をDBに届けるPreparedStatementインスタンス取得
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();
			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				int id = rs.getInt("ID");
				r_id = rs.getInt("R_ID");
				String u_id = rs.getString("U_ID");
				int star = rs.getInt("star");
				String title = rs.getString("TITLE");
				String text = rs.getString("TEXT");

				Comment comment = new Comment(id, r_id, u_id, star, title, text);
				cList.add(comment);
			}

		} catch (SQLException e) {
			e.printStackTrace();

			return null;
		}
		// 選んだ店リストまたはnullを返す

		return cList;
	}

	public boolean create(Comment comment) {
		// データベース接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// INSERT文の準備(idは自動連番なので指定しなくてよい）
			String sql = "INSERT INTO COMMENT(R_ID, U_ID, STAR, TEXT, TITLE) VALUES(?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			// INSERT文中の「?」に使用する値を設定しSQLを完成
			pStmt.setInt(1, comment.getR_id());
			pStmt.setString(2, comment.getU_id());
			pStmt.setInt(3, comment.getStar());
			pStmt.setString(4, comment.getTitle());
			pStmt.setString(5, comment.getText());

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

	public double countAvgStar(int r_id) {
		double avgStar = 0.0;
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// SELECT文の準備
			String sql = "SELECT AVG(STAR) FROM COMMENT WHERE R_ID = " + r_id;

			//SQL文をDBに届けるPreparedStatementインスタンス取得
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();
			// SELECT文の結果をavgStarに代入
			while (rs.next()) {
				avgStar = rs.getDouble("AVG(STAR)");
				avgStar=((double)Math.round(avgStar*10))/10;//小数点第二位を四捨五入
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0.0;
		}
		// avgStarまたは0を返す
		return avgStar;
	}
}