/*
 * 店舗の編集に関する処理を行うモデル  
 */

package model;

import dao.RestaurantDAO;

public class EditRestaurantLogic {
  public void execute(Restaurant restaurant, int id) { 
    RestaurantDAO dao = new RestaurantDAO();
    dao.change(restaurant, id);
  }
}