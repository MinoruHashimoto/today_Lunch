/**
 * 一般ユーザーのログイン処理を担当するBO 
 */

package model;

import dao.AccountDAO;

public class LoginLogic {
  public boolean execute(String userId, String pass) {
    AccountDAO dao = new AccountDAO();
    Account account = dao.findBy(userId, pass);
    return account != null;
  }
}