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


<head>
	<title>&#x1f374; 本日のランチ &#x1f374;</title>
	<meta charset="UTF-8">
	<%-- スタイルシート呼び出し --%>
	<link rel="stylesheet" href="css/color.css">
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
					<td><input type="text" class="form" placeholder="店舗名" name="name" required title="1文字以上の文字列"
					value="<%=restaurant.getName()%>"></td>
				</tr>
				<tr>
					<td><input type="text" class="form" placeholder="ジャンル" name="janru" required
						pattern="和食|洋食|中華" title="「和食」「洋食」「中華」のうちどれか一つ"
					value="<%=restaurant.getJanru()%>"></td>
				</tr>
				<tr>
					<td><input type="text" class="form" placeholder="距離（m）" name="distance" required
						title="1文字以上の文字列" value="<%=restaurant.getDistance()%>"></td>
				</tr>
				<tr>
					<td><input type="text" class="form" placeholder="定休日" name="holiday" title="1文字以上の文字列"
						value="<%=restaurant.getHoliday()%>"required></td>
				</tr>
				<tr>
					<td><input type="tel" class="form" placeholder="電話番号" name="tel"
						pattern="\d{2,4}-\d{3,4}-\d{3,4}" title="電話番号の形式　(例)090-1234-5678"
						value="<%=restaurant.getTel()%>"required></td>
				</tr>
				<tr>
					<td><input type="tel" class="form" placeholder="価格帯（円）" name="price" pattern="\d+"
						title="1文字以上の数字" required value="<%=restaurant.getPrice()%>"></td>
				</tr>
				<tr>
					<td><input type="text" class="form" placeholder="定番メニュー" name="dishes" title="1文字以上の文字列"
					value="<%=restaurant.getDishes()%>" required></td>
				</tr>
				<tr>
					<td><input type="url" class="form" placeholder="URL" name="url" required
					value="<%=restaurant.getUrl()%>"></td>
				</tr>
			</table>
			<pre>
			</pre>
			<div class="button_wrapper">
		<button type="submit" id="gradual">変更</button>
		</div>
		</form>
		<%-- 3行空けるタグ<pre> --%>
		<pre>



		</pre>
		<div class="button_wrapper">
		<a href="/today_Lunch/AdminServlet" class="btn">戻る</a>
		</div>
</div>
</body>
</html>