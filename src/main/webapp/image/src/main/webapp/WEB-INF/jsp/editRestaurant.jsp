<%-- 店舗編集画面を出力するビュー --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ 
page import="model.Restaurant"%>
<%
Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
%>
<!DOCTYPE html>
<html>
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">
<meta charset="UTF-8">

<head>
	<title>本日のランチ</title>
</head>


<div class="body">
		<%-- title上部に5行空白を開けるタグ<pre> --%>
		<pre>





</pre>
		<%-- 「&#x1f374;」はフォークとナイフの絵文字 --%>
		<h1>
			&#x1f374; 「<%=restaurant.getName()%>」編集ページ &#x1f374;
		</h1>

		<%-- slectタグの文字サイズを変更するタグ<style> --%>
		<style>
select {
	font-size: 20px;
}
</style>


		<form action="/today_Lunch/EditRestaurantServlet" method="post">
			<table class="T_table">
				<tr>
					<th>店舗名</th>
					<td><input type="text" name="name" required title="1文字以上の文字列"
					value="<%=restaurant.getName()%>"></td>
				</tr>
				<tr>
					<th>ジャンル</th>
					<td><input type="text" name="janru" required
						pattern="和食|洋食|中華" title="「和食」「洋食」「中華」のうちどれか一つ"
					value="<%=restaurant.getJanru()%>"></td>
				</tr>
				<tr>
					<th>距離区分</th>
					<td><input type="text" name="distance" required
						title="1文字以上の文字列" value="<%=restaurant.getDistance()%>"></td>
				</tr>
				<tr>
					<th>定休日</th>
					<td><input type="text" name="holiday" title="1文字以上の文字列"
						value="<%=restaurant.getHoliday()%>"required></td>
				</tr>
				<tr>
					<th>電話番号</th>
					<td><input type="tel" name="tel"
						pattern="\d{2,4}-\d{3,4}-\d{3,4}" title="電話番号の形式　(例)090-1234-5678"
						value="<%=restaurant.getTel()%>"required></td>
				</tr>
				<tr>
					<th>値段区分</th>
					<td><input type="tel" name="price" pattern="\d+"
						title="1文字以上の数字" required value="<%=restaurant.getPrice()%>"></td>
				</tr>
				<tr>
					<th>定番メニュー</th>
					<td><input type="text" name="dishes" title="1文字以上の文字列"
					value="<%=restaurant.getDishes()%>" required></td>
				</tr>
				<tr>
					<th>URL</th>
					<td><input type="url" name="url" required
					value="<%=restaurant.getUrl()%>"></td>
				</tr>
			</table>
			<input type="submit" value="変更">
		</form>
		<%-- 3行空けるタグ<pre> --%>
		<pre>



		</pre>
		<a href="/today_Lunch/AdminServlet">戻る</a>
</div>
</body>
</html>