//レビューの星の数の平均の取得に関する処理を行うモデル

package model;

import dao.CommentDAO;

public class GetAverageStarLogic {

  public double execute(int r_id) {
    CommentDAO dao = new CommentDAO();
    double avgStar = dao.countAvgStar(r_id);
    
    return avgStar;
  }
}