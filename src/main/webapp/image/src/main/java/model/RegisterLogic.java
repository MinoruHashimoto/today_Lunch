/**
 * ユーザー登録処理を担当するBO 
 */

package model;

import dao.AccountDAO;

public class RegisterLogic {
  public boolean execute(Account register) {
    AccountDAO dao = new AccountDAO();
    Account account = dao.findBy(register);
    
    if(account == null) {
    	return dao.register(register);
    }else {return false;}
  }
}