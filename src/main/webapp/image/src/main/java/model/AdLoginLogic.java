/**
 * 管理者のログイン処理を担当するBO 
 */

package model;

public class AdLoginLogic {
	public boolean execute(String id, String pass) {
		if (id.equals("root") && pass.equals("root")) {
			return true;
		} else {
			return false;
		}
	}
}