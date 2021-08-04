//ACCOUNTテーブルを担当するDAO

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Account;

public class AccountDAO {
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

	public Account findBy(String userId, String pass) {
		Account account = null;

		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			//SELECT文を準備
			String sql = "SELECT * FROM ACCOUNT WHERE USER_ID = ? AND PASS = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, userId);
			pStmt.setString(2, pass);

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();

			// 一致したユーザーが存在した場合
			// そのユーザーを表すAccountインスタンスを生成
			if (rs.next()) {
				userId = rs.getString("USER_ID");
				pass = rs.getString("PASS");
				String mail = rs.getString("MAIL");
				String name = rs.getString("NAME");
				int age = rs.getInt("AGE");
				String gender = rs.getString("GENDER");

				account = new Account(userId, pass, mail, name, age, gender);

			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		// 見つかったユーザーまたはnullを返す
		return account;
	}
	//CommentServletで、コメントを書いたユーザーを探すときに使うメソッド
	public Account findBy(String userId) {
		Account account = null;
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {
			
			//SELECT文を準備
			String sql = "SELECT * FROM ACCOUNT WHERE USER_ID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, userId);
			
			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();
			
			// 一致したユーザーが存在した場合
			// そのユーザーを表すAccountインスタンスを生成
			if (rs.next()) {
				userId = rs.getString("USER_ID");
				String pass = rs.getString("PASS");
				String mail = rs.getString("MAIL");
				String name = rs.getString("NAME");
				int age = rs.getInt("AGE");
				String gender = rs.getString("GENDER");

				//このうち、年齢を30, 40のように、1桁目を切り捨てる
				age = (int)(Math.floor((double)age/10)) * 10;
				
				account = new Account(userId, pass, mail, name, age, gender);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		// 見つかったユーザーまたは0を返す
		return account;
	}

	public Account findBy(Account register) {
		Account account = null;
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// SELECT文を準備
			String sql = "SELECT * FROM ACCOUNT WHERE USER_ID = ? AND PASS = ?"
					+ " AND MAIL= ? AND NAME = ? AND AGE = ? AND GENDER = ?" ;
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, register.getUserId());
			pStmt.setString(2, register.getPass());
			pStmt.setString(3, register.getMail());
			pStmt.setString(4, register.getName());
			pStmt.setInt(5, register.getAge());
			pStmt.setString(6, register.getGender());

			// SELECTを実行し、結果表を取得
			ResultSet rs = pStmt.executeQuery();

			// 一致したユーザーが存在した場合
			// そのユーザーを表すAccountインスタンスを生成
			if (rs.next()) {
				// 結果表からデータを取得
				String userId = rs.getString("USER_ID");
				String pass = rs.getString("PASS");
				String mail = rs.getString("MAIL");
				String name = rs.getString("NAME");
				int age = rs.getInt("AGE");
				String gender = rs.getString("GENDER");

				account = new Account(userId, pass, mail, name, age, gender);

			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		// 見つかったユーザーまたはnullを返す
		return account;
	}

	public boolean register(Account register) {
		// データベースへ接続
		try (Connection conn = DriverManager.getConnection(
				JDBC_URL, DB_USER, DB_PASS)) {

			// INSERT文の準備
			String sql = "INSERT INTO ACCOUNT(USER_ID, PASS, MAIL, NAME, AGE, GENDER)"
					+ " VALUES(?, ?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setString(1, register.getUserId());
			pStmt.setString(2, register.getPass());
			pStmt.setString(3, register.getMail());
			pStmt.setString(4, register.getName());
			pStmt.setInt(5, register.getAge());
			pStmt.setString(6, register.getGender());

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
}