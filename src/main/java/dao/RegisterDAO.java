/**
 * ユーザ登録時accountテーブルを担当するDAO 
 */

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Account;

public class RegisterDAO {
  // データベース接続に使用する情報
	private final String JDBC_URL ="jdbc:mysql://localhost/today_lunch?useSSL=false";
	private final String DB_USER = "root";
	private final String DB_PASS = "root";
  
  public Account findByRegister(Account register) {
	  
    Account account = null;

    try {   
      // データベースへ接続
      Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);

      // SELECT文を準備
      String sql = "SELECT USER_ID, PASS, MAIL, NAME, AGE FROM account "
      		+ "WHERE USER_ID = ? AND PASS = ?, AND MAIL = ?, AND NAME = ?, AND AGE = ?";
      PreparedStatement pStmt = conn.prepareStatement(sql);
      pStmt.setString(1, register.getUserId());
      pStmt.setString(2, register.getPass());
      pStmt.setString(3, register.getMail());
      pStmt.setString(4, register.getName());
      pStmt.setInt(5, register.getAge());

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
        
        account = new Account(userId, pass, mail, name, age);
      
      }
    } catch (SQLException e) {
      e.printStackTrace();
      return null;
    }
    // 見つかったユーザーまたはnullを返す
    return account;
  }
  
  public boolean register(Account register) {
	    // データベース接続
	    try(Connection conn = DriverManager.getConnection(
	          JDBC_URL, DB_USER, DB_PASS)) {

	      // INSERT文の準備(idは自動連番なので指定しなくてよい）
	      String sql = "INSERT INTO ACCOUNT(USER_ID, PASS, MAIL, NAME, AGE) VALUES(?, ?, ?, ?, ?)";
	      PreparedStatement pStmt = conn.prepareStatement(sql);
	      // INSERT文中の「?」に使用する値を設定しSQLを完成
	      pStmt.setString(1, register.getUserId());
	      pStmt.setString(2, register.getPass());
	      pStmt.setString(3, register.getMail());
	      pStmt.setString(4, register.getName());
	      pStmt.setInt(5, register.getAge());
	      
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