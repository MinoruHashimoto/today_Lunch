//BO。店舗情報をデータベースから取得する処理を行う。
package model;

import java.util.List;

import dao.RestaurantDAO;

public class GetRestaurantListLogic {
	
	//選択した条件に合う店舗情報のリストを取得するメソッド
	public List<Restaurant> execute(String janru, String price, String keyword, String sort) {
		RestaurantDAO dao = new RestaurantDAO();
		List<Restaurant> rList = dao.findBy(janru, price, keyword, sort);
		return rList;
	}
	
	//特定の店舗の情報を取得するメソッド
	public Restaurant execute(int r_id) {
		RestaurantDAO dao = new RestaurantDAO();
		Restaurant restaurant = dao.findBy(r_id);
		return restaurant;
	}
	
	//管理画面で表示する全店舗情報を取得するメソッド
	public List<Restaurant> execute() {
		RestaurantDAO dao = new RestaurantDAO();
		List<Restaurant> rList = dao.findAll();
		return rList;
	}
}