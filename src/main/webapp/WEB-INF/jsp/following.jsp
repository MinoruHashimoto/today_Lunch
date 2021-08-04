<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Restaurant,java.util.List"%>
<%
List<Restaurant> followList = (List<Restaurant>) session.getAttribute("followList");
String noRestaurant = (String) request.getAttribute("noRestaurant");
%>
<!DOCTYPE html>
<html>


<head>
	<title>&#x1f374; 本日のランチ &#x1f374;</title>
	<%-- スタイルシート呼び出し --%>
	<link rel="stylesheet" href="css/color.css">
	<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
	<meta charset="UTF-8">
</head>





<div class="body">


	<%-- title上部に5行空白を開けるタグ<pre> --%>
	<pre>





</pre>

	<h1 class="title">&#x1f374; フォロー中の店舗 &#x1f374;</h1>
	<%
	if (followList != null) {
	%>
	<%
	if (followList.size() != 0) {
	%>
	<%=followList.size()%>件
	<pre>
	</pre>

	<%-- ここに結果を表示する --%>
	<table class="S_table">
		<tr>
			<th>店名</th>
			<th>フォロワー</th>
			<th>ジャンル</th>
			<th>定番メニュー</th>
			<th>価格帯(円)</th>
			<th>距離(m)</th>
			<th>定休日</th>
			<th>電話番号</th>
			<th colspan="3">口コミ</th>
		</tr>
		<%
		for (Restaurant restaurant : followList) {

			//表示する各店舗へのフォロー状態と、レビューの星の数の平均をセッションスコープから取得
			String r_id_str = String.valueOf(restaurant.getId());
			boolean doYouFollow = false;
			if (session.getAttribute("doYouFollow" + r_id_str) != null) {
				doYouFollow = (boolean) session.getAttribute("doYouFollow" + r_id_str);
			}
			double avgStar = (double) session.getAttribute("avg" + r_id_str);

			//フォロワー数をセッションスコープから取得
			int follower = (int) session.getAttribute("follower" + restaurant.getId());
		%>
		<tr>
			<td>
				<h2>
					<a target="_blank" href="<%=restaurant.getUrl()%>"><%=restaurant.getName()%></a>
				</h2>
			</td>
			<td><%=follower%></td>
			<td><%=restaurant.getJanru()%></td>
			<td><%=restaurant.getDishes()%></td>
			<td><%=restaurant.getPrice()%></td>
			<td><%=restaurant.getDistance()%></td>
			<td><%=restaurant.getHoliday()%></td>
			<td><%=restaurant.getTel()%></td>
			<td class="data-comment star">
				<%
				if (avgStar >= 4.75) {
				%>★★★★★<%
				} else if (avgStar >= 4.25) {
				%>★★★★<i class="fas fa-star-half"></i> <%
 } else if (avgStar >= 3.75) {
 %>★★★★☆<%
 } else if (avgStar >= 3.25) {
 %>★★★<i class="fas fa-star-half"></i>☆<%
 } else if (avgStar >= 2.75) {
 %>★★★☆☆<%
 } else if (avgStar >= 2.25) {
 %>★★<i class="fas fa-star-half"></i>☆☆<%
 } else if (avgStar >= 1.75) {
 %>★★☆☆☆<%
 } else if (avgStar >= 1.25) {
 %>★<i class="fas fa-star-half"></i>☆☆☆<%
 } else if (avgStar >= 1) {
 %>★☆☆☆☆<%
 } else {
 %><span>(口コミなし)</span> <%
 }
 %>
			</td>
			<td class="data-comment">
				<%
				if (avgStar != 0) {
				%> <%=avgStar%>&nbsp; <%
 }
 %>
			</td>
			<td class="data-comment">
				<form action="/today_Lunch/CommentServlet" method="get">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>">
					<!-- 星の数の平均値によって表示する星を変える -->
					<div class="button_wrapper">
						<button type="submit" class="reset flat black-border">
							口コミを見る &gt;</button>
					</div>
				</form>
			</td>
		</tr>
		<%
		}
		%>
	</table>

	<%
	}
	%>
	<%
	}
	%>
	<%
	if (noRestaurant != null) {
	%><p>フォロー中の店舗はありません。</p>
	<%
	}
	%>

	<%-- 5行空けるタグ<pre> --%>
	<pre>





</pre>
	<div class="button_wrapper">
		<a href="/today_Lunch/SuggestionServlet" class="btn"><span>提案画面へ</span></a>
		　<a href="/today_Lunch/LogoutServlet" class="btn"><span>ログアウト</span></a>
	</div>

</div>
</html>