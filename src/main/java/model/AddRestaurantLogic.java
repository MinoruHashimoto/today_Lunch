/*
 * 店舗の追加登録に関する処理を行うモデル  
 */

package model;

import dao.RestaurantDAO;

public class AddRestaurantLogic {
  public void execute(Restaurant restaurant) { 
    RestaurantDAO dao = new RestaurantDAO();
    dao.create(restaurant);
  }
}