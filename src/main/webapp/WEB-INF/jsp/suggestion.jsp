<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Restaurant,java.util.List"%>
<%
List<Restaurant> rList = (List<Restaurant>) session.getAttribute("rList");
String janru = (String) session.getAttribute("janru");
String price = (String) session.getAttribute("price");
String keyword = (String) session.getAttribute("keyword");
String jErr = (String) request.getAttribute("jErr");
String pErr = (String) request.getAttribute("pErr");
boolean following = false;
String noRestaurant = (String) request.getAttribute("noRestaurant");
%>
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

	<%-- 「&#x1f374;」はフォークとナイフの絵文字。 --%>
	<h1 class="title">&#x1f374; 本日のランチ &#x1f374;</h1>
	<P>
		本日のランチを提案します。<br> ジャンルと価格帯を選んでください。
	</P>
	<h3>今日何食べる？</h3>

	<form action="/today_Lunch/SuggestionServlet" method="post">
		<table class="T_table">
			<select name="janru" class="form-item">
				<option value="default" <%if (janru.equals("default")) {%> selected
					<%}%>>（ジャンルを選択）</option>
				<option value="和食" <%if (janru.equals("和食")) {%> selected <%}%>>和食</option>
				<option value="洋食" <%if (janru.equals("洋食")) {%> selected <%}%>>洋食</option>
				<option value="中華" <%if (janru.equals("中華")) {%> selected <%}%>>中華</option>
				<option value="おまかせ" <%if (janru.equals("おまかせ")) {%> selected <%}%>>おまかせ</option>
			</select>
			<%
			if (jErr != null) {
			%>
			<p>
				<font color="red"><%=jErr%>
			</p>
			<%
			}
			%>
			<p>
				<select name="price" class="form-item">
					<option value="default" <%if (price.equals("default")) {%> selected
						<%}%>>（価格帯を選択）</option>
					<option value="800円未満" <%if (price.equals("800円未満")) {%> selected
						<%}%>>800円未満</option>
					<option value="800円～1500円" <%if (price.equals("800円～1500円")) {%>
						selected <%}%>>801円～1500円</option>
					<option value="1501円以上" <%if (price.equals("1501円以上")) {%> selected
						<%}%>>1501円以上</option>
					<option value="こだわらない" <%if (price.equals("こだわらない")) {%> selected
						<%}%>>こだわらない</option>
				</select>
			</p>
			<%
			if (pErr != null) {
			%>
			<p>
				<font color="red"><%=pErr%>
			</p>
			<%
			}
			%>
			<input type="text" name="keyword" placeholder="キーワード検索"
				<%if (keyword != null) {%> value="<%=keyword%>" <%}%>>

			<p>
				<input type="submit" value="検索" />
			</p>
		</table>
	</form>


	<%-- 選択項目と結果表示の間に5行余白を空けるコード<pre> --%>
	<pre>





</pre>

	<%
	if (rList != null) {
	%>
	<%
	if (rList.size() != 0) {
	%>
	<p><%=rList.size()%>店舗見つかりました！
	</p>
	<p>本日のランチにこちらはいかがですか？</p>

	<%-- ここに結果を表示する --%>
	<table border="1">
		<tr>
			<th>店名</th>
			<th>ジャンル</th>
			<th>定番メニュー</th>
			<th>価格帯</th>
			<th>距離</th>
			<th>定休日</th>
			<th>電話番号</th>
			<th>コメント</th>
			<th>フォロー</th>
		</tr>
		<%
		for (Restaurant restaurant : rList) {
			String r_id_str = String.valueOf(restaurant.getId());
			if(request.getAttribute(r_id_str)!=null){
			following = (boolean)request.getAttribute(r_id_str);}
		%>
		<tr>
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
			<td>
				<form action="/today_Lunch/CommentServlet" method="get">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>"> <input type="submit"
						value="コメント">
				</form>
			</td>
			<td>
				<% if(!following){%><form action="/today_Lunch/FollowServlet" method="post">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>"> <input type="submit"
						value="フォローする">
				<% }else{%><form action="/today_Lunch/UnFollowServlet" method="post">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>"> <input type="submit"
						value="フォロー中" onclick="return confirm('<%=restaurant.getName()%>のフォローを解除');">
				<% }%>
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
	%>
	<p>
		<font color="red"><%=noRestaurant%>
	</p>
	<%
	}
	%>
	<pre>



</pre>



	<%-- googleマップ埋め込み --%>
	<p class="center">
		<iframe
			src="https://www.google.com/maps/d/embed?
	mid=1rkpuTV26SzxyFtZ9Voe2WvRUCZUso3IP"
			width="640" height="480"> </iframe>
	</p>
	<%-- 5行空けるタグ<pre> --%>
	<pre>





</pre>
	<a href="/today_Lunch/BackMainServlet">メイン画面へ</a> <br> <a
		href="/today_Lunch/LogoutServlet">ログアウト</a>


</div>
</html>