
//commentテーブルのレコードを表すクラス(Java Beans)

package model;

public class Comment {
	private int id;
	private int r_id; //店舗id
	private String u_id; // ユーザーID
	private String text; // つぶやき内容
	//  private Timestamp time; //投稿日時

	public Comment(int r_id, String u_id,
			String text) {
		this.r_id = r_id;
		this.u_id = u_id;
		this.text = text;
		//    this.time = time;
	}

	public Comment(int id, int r_id, String u_id,
			String text) {
		this(r_id, u_id, text);
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

	public String getText() {
		return text;
	}

	//  public String getTime() {
	//	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//	  String time = sdf.format(this.time);
	//	  return time;
	//  }
}