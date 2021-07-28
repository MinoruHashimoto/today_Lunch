<%-- 管理画面を表示するビュー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Restaurant,java.util.List"%>
<%
String name = (String) request.getAttribute("name");
String editMsg = (String) request.getAttribute("editMsg");
String deleteMsg = (String) request.getAttribute("deleteMsg");
List<Restaurant> rList = (List<Restaurant>) session.getAttribute("rList");
%>
<%-- 分離されたJSPテンプレート --%>
<!DOCTYPE html>
<html>
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">
<meta charset="UTF-8">

<head>
<title>&#x1f374; 本日のランチ &#x1f374;</title>
</head>



<div class="body">
	<%-- title上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<br>
	<h1 class="title">&#x1f374; 店舗管理ページ &#x1f374;</h1>
	<a href="/today_Lunch/ManageServlet"></a> <br> <br>［現在ログインしています］

	<%
 if (name != null) {
 %>
	<p class="success">
		「<%=name%>」を追加しました。
	</p>
	<%
	}
	if (editMsg != null) {
	%>
	<div>
		<%=editMsg%>
	</div>
	<%
	}
	if (deleteMsg != null) {
	%>
	<div class="alert alert-success" role="alert">
		<%=deleteMsg%>
	</div>
	<%
	}
	%>
	<h3>登録店舗を追加する</h3>

	<form action="/today_Lunch/AdminServlet" method="post">
		<table class="T_table">
			<tr>
				<th>店舗名</th>
				<td><input type="text" name="name" required title="1文字以上の文字列"></td>
			</tr>
			<tr>
				<th>ジャンル</th>
				<td><input type="text" name="janru" required pattern="和食|洋食|中華"
					title="「和食」「洋食」「中華」のうちどれか一つ"></td>
			</tr>
			<tr>
				<th>距離区分</th>
				<td><input type="text" name="distance" required
					title="1文字以上の文字列"></td>
			</tr>
			<tr>
				<th>定休日</th>
				<td><input type="text" name="holiday" title="1文字以上の文字列"
					required></td>
			</tr>
			<tr>
				<th>電話番号</th>
				<td><input type="tel" name="tel"
					pattern="\d{2,4}-\d{3,4}-\d{3,4}" title="電話番号の形式　(例)090-1234-5678"
					required></td>
			</tr>
			<tr>
				<th>値段区分</th>
				<td><input type="tel" name="price" pattern="\d+"
					title="1文字以上の半角数字" required></td>
			</tr>
			<tr>
				<th>定番メニュー</th>
				<td><input type="text" name="dishes" title="1文字以上の文字列" required></td>
			</tr>
			<tr>
				<th>URL</th>
				<td><input type="url" name="url" required></td>
			</tr>
		</table>
		<input type="submit" value="登録">
	</form>

	<h2>店舗一覧</h2>
	<table border="1">
		<tr>
			<th>店舗ID</th>
			<th>店名</th>
			<th>ジャンル</th>
			<th>定番メニュー</th>
			<th>価格帯</th>
			<th>距離</th>
			<th>定休日</th>
			<th>電話番号</th>
			<th>編集</th>
			<th>削除</th>
		</tr>
		<%
		for (Restaurant restaurant : rList) {
		%>
		<tr>
			<td><%=restaurant.getId()%></td>
			<td>
				<h2>
					<a href="<%=restaurant.getUrl()%>"><%=restaurant.getName()%></a>
				</h2>
			</td>
			<td><%=restaurant.getJanru()%></td>
			<td><%=restaurant.getDishes()%></td>
			<td><%=restaurant.getPrice()%></td>
			<td><%=restaurant.getDistance()%></td>
			<td><%=restaurant.getHoliday()%></td>
			<td><%=restaurant.getTel()%></td>
			<td><form action="/today_Lunch/EditRestaurantServlet"
					method="get">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>">
					<button type="submit" name="button">編集</button>
				</form></td>
			<td><form action="/today_Lunch/DeleteRestaurantServlet"
					method="post">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>">
					<button type="submit" name="button"
						onclick="return confirm('削除してよろしいですか？');">削除</button>
				</form></td>
		</tr>
		<%
		}
		%>
	</table>

	<%-- body下部に7行空白を開けるタグ<pre> --%>
	<pre>








	<a href="/today_Lunch/AdLogoutServlet">ログアウト</a>






</div>
</html>