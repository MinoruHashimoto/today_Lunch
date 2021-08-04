
//followテーブルのレコードを表すクラス(Java Beans)

package model;

public class Follow {
	private int id;
	private int r_id; //店舗id
	private String u_id; // ユーザーID

	public Follow(int r_id, String u_id) {
		this.r_id = r_id;
		this.u_id = u_id;
	}
	
	public Follow(int id, int r_id, String u_id) {
		this(r_id, u_id);
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public int getR_id() {
		return r_id;
	}

	public String getU_id() {
		return u_id;
	}
}