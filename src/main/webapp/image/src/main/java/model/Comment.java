
//commentテーブルのレコードを表すクラス(Java Beans)

package model;

public class Comment {
	private int id;
	private int r_id; //店舗id
	private String u_id; // ユーザーID
	private int star; //星の数
	private String title; // タイトル
	private String text; // レビュー
	//  private Timestamp time; //投稿日時

	public Comment(int r_id, String u_id) {
		this.r_id = r_id;
		this.u_id = u_id;
		//    this.time = time;
	}

	public Comment(int id, int r_id, String u_id) {
		this(r_id, u_id);
		this.id=id;
	}
	public Comment(int r_id, String u_id, int star,
			String title, String text) {
		this(r_id, u_id);
		this.star = star;
		this.title = title;
		this.text = text;
	}

	public Comment(int id, int r_id, String u_id,
			int star, String title, String text) {
		this(r_id, u_id, star, title, text);
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

	public int getStar() {
		return star;
	}

	public String getText() {
		return text;
	}
	
	public String getTitle() {
		return title;
	}
	

	//  public String getTime() {
	//	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//	  String time = sdf.format(this.time);
	//	  return time;
	//  }
}