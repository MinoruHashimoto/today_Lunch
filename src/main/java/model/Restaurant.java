/**
 * restaurantテーブルのレコードを表すEntity code 
 */

package model;

public class Restaurant {

	private int id;
	private String name;
	private String janru;
	private String distance;
	private String holiday;
	private String tel;
	private int price;
	private String dishes;
	private String url;

	public Restaurant(String name, String janru, String distance,
			String holiday, String tel, int price, String dishes, String url) {
		this.name = name;
		this.janru = janru;
		this.distance = distance;
		this.holiday = holiday;
		this.tel = tel;
		this.price = price;
		this.dishes = dishes;
		this.url = url;
	}
	
	public Restaurant(int id, String name, String janru, String distance,
			String holiday, String tel, int price, String dishes, String url) {
		this(name, janru, distance, holiday, tel, price, dishes, url);
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getJanru() {
		return janru;
	}

	public String getDistance() {
		return distance;
	}

	public String getHoliday() {
		return holiday;
	}

	public String getTel() {
		return tel;
	}

	public int getPrice() {
		return price;
	}

	public String getDishes() {
		return dishes;
	}

	public String getUrl() {
		return url;
	}
}