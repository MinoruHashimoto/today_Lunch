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
String noRestaurant = (String) request.getAttribute("noRestaurant");
%>
<!DOCTYPE html>
<html>
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<meta charset="UTF-8">

<head>
	<title>本日のランチ</title>
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
		<select name="janru">
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
			<select name="price">
				<option value="default" <%if (price.equals("default")) {%> selected
					<%}%>>（価格帯を選択）</option>
				<option value="800円未満" <%if (price.equals("800円未満")) {%> selected
					<%}%>>800円未満</option>
				<option value="800円～1500円" <%if (price.equals("800円～1500円")) {%>
					selected <%}%>>800円～1500円</option>
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
	<table class="S_table">
		<tr>
			<th>店名</th>
			<th>ジャンル</th>
			<th>定番メニュー</th>
			<th>価格帯</th>
			<th>距離</th>
			<th>定休日</th>
			<th>電話番号</th>
			<th>口コミ</th>
			<th>フォロワー数</th>
			<th>フォロー</th>
		</tr>
		<%
		for (Restaurant restaurant : rList) {

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
			<td><%=restaurant.getJanru()%></td>
			<td><%=restaurant.getDishes()%></td>
			<td><%=restaurant.getPrice()%></td>
			<td><%=restaurant.getDistance()%></td>
			<td><%=restaurant.getHoliday()%></td>
			<td><%=restaurant.getTel()%></td>
			<td>
				<form action="/today_Lunch/CommentServlet" method="get">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>"> 
						<!-- 星の数の平均値によって表示する星を変える -->
						<div class="button_wrapper">
						<input type="submit"
						value="<%if (avgStar >= 4.75) {
									%>★★★★★<%
								} else if (avgStar >= 4.25) {
									%>★★★★<i class="far fa-star-half"></i><%
								} else if (avgStar >= 3.75) {
									%>★★★★☆<%
								} else if (avgStar >= 3.25) {
									%>★★★<i class="far fa-star-half"></i>☆<%
								} else if (avgStar >= 2.75) {
									%>★★★☆☆<%
								} else if (avgStar >= 2.25) {
									%>★★<i class="far fa-star-half"></i>☆☆<%
								} else if (avgStar >= 1.75) {
									%>★★☆☆☆<%
								} else if (avgStar >= 1.25) {
									%>★<i class="far fa-star-half"></i>☆☆☆<%
								} else if (avgStar >= 1) {
									%>★☆☆☆☆<%
								} else {
									%>(口コミなし)<%
								}%>" >
						</div>
				</form>
			</td>
			<td><%=follower%></td>
			<td>
				<%
				if (!doYouFollow) {
				%><form action="/today_Lunch/FollowServlet" method="post">
					<input type="hidden" name="<%=restaurant.getId()%>"
						value="<%=restaurant.getName()%>"> <input type="submit"
						value="フォローする">
					<%
					} else {
					%><form action="/today_Lunch/UnfollowServlet" method="post">
						<input type="hidden" name="<%=restaurant.getId()%>"
							value="<%=restaurant.getName()%>"> <input type="submit"
							value="フォロー中"
							onclick="return confirm('<%=restaurant.getName()%>のフォローを解除');">
						<%
						}
						%>
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
	<div class="button_wrapper">
		<a href="/today_Lunch/FollowServlet" class="btn"><span>フォロー中の店舗から探す</span></a>
	</div>

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