<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Restaurant,java.util.List"%>
<%
List<Restaurant> rList = (List<Restaurant>) session.getAttribute("rList");
String janru = (String) session.getAttribute("janru");
String price = (String) session.getAttribute("price");
String keyword = (String) session.getAttribute("keyword");
String sort = (String) session.getAttribute("sort");
String follow = (String) request.getAttribute("follow");
String unfollow = (String) request.getAttribute("follow");
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
	<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
	<link
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"
		rel="stylesheet">
	<script src="good.js"></script>
	<meta charset="UTF-8">
</head>



<div class="body">


	<%-- title上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>

	<%-- 「&#x1f374;」はフォークとナイフの絵文字。 --%>
	<h1 class="title">&#x1f374; 本日のランチ &#x1f374;</h1>
	<P>
		本日のランチを提案します。<br> ジャンルと価格帯を選択してください。
	</P>
	<h3>今日何食べる？</h3>

	<form action="/today_Lunch/SuggestionServlet" method="post">

			<div class="cp_ipselect">
				<select name="janru" class="cp_sl06" required>
					<option value="" hidden disabled selected></option>
					<option value="和食" <%if (janru.equals("和食")) {%> selected <%}%>>和食</option>
					<option value="洋食" <%if (janru.equals("洋食")) {%> selected <%}%>>洋食</option>
					<option value="中華" <%if (janru.equals("中華")) {%> selected <%}%>>中華</option>
					<option value="おまかせ" <%if (janru.equals("おまかせ")) {%> selected <%}%>>おまかせ</option>
				</select> <span class="cp_sl06_highlight"></span> <span
					class="cp_sl06_selectbar"></span> <label
					class="cp_sl06_selectlabel">ジャンルを選択</label>
			</div>

			<div class="cp_ipselect">
				<select name="price" class="cp_sl06" required>
					<option value="" hidden disabled selected></option>
					<option value="800円未満" <%if (price.equals("800円未満")) {%> selected
						<%}%>>800円未満</option>
					<option value="800円～1500円" <%if (price.equals("800円～1500円")) {%>
						selected <%}%>>800円～1500円</option>
					<option value="1501円以上" <%if (price.equals("1501円以上")) {%> selected
						<%}%>>1501円以上</option>
					<option value="こだわらない" <%if (price.equals("こだわらない")) {%> selected
						<%}%>>こだわらない</option>
				</select> <span class="cp_sl06_highlight"></span> <span
					class="cp_sl06_selectbar"></span> <label
					class="cp_sl06_selectlabel">価格帯を選択</label>
			</div>

			<div class="cp_ipselect">
				<select name="sort" class="cp_sl06" required>
					<option value="" hidden disabled selected></option>
					<option value="評価が高い順" <%if (sort.equals("評価が高い順")) {%> selected
						<%}%>>評価が高い順</option>
                                                <option value="近い順" <%if (sort.equals("近い順")) {%> selected <%}%>>近い順</option>
					<option value="安い順" <%if (sort.equals("安い順")) {%> selected <%}%>>安い順</option>
				</select> <span class="cp_sl06_highlight"></span> <span
					class="cp_sl06_selectbar"></span> <label
					class="cp_sl06_selectlabel">並び替え</label>
			</div>
		<table class="T_table" style="width:30%;" >
			<tr>
				<td><input type="text" class="form" name="keyword"
					placeholder="キーワード検索" <%if (keyword != null) {%>
					value="<%=keyword%>" <%}%>></td>
			</tr>
		</table>
		<pre>

		</pre>
		<div class="button_wrapper">
			<button type="submit" id="gradual">検索</button>
		</div>
	</form>


	<%-- 選択項目と結果表示の間に2行余白を空けるコード<pre> --%>
	<pre>


</pre>

	<%
	if (follow != null) {
	%><%=follow %><%
	}if(unfollow !=  null){
	%><%=follow %><%
	}%>

	<%
	if (rList != null) {
		if (rList.size() != 0) {
		%>
		<p><%=rList.size()%>店舗見つかりました！
		</p>
		<p>本日のランチにこちらはいかがですか？</p>
		<%-- ここに結果を表示する --%>
		<table class="S_table">
			<tr>
				<th>店名</th>
				<th>フォロワー</th>
				<th>フォロー</th>
				<th>ジャンル</th>
				<th>定番メニュー</th>
				<th>価格帯(円)</th>
				<th>距離(m)</th>
				<th>定休日</th>
				<th>電話番号</th>
				<th colspan="3">口コミ</th>
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
				<td><%=follower%></td>
				<td>
					<%
					if (!doYouFollow) {
					%><form action="/today_Lunch/FollowServlet" method="post">
						<input type="hidden" name="<%=restaurant.getId()%>"
							value="<%=restaurant.getName()%>">
							<button type="submit" class="reset flat border">
							<i class="fas fa-user-plus"></i></button>
	
						<%
						} else {
						%><form action="/today_Lunch/UnfollowServlet" method="post">
							<input type="hidden" name="<%=restaurant.getId()%>"
								value="<%=restaurant.getName()%>">
							<button type="submit" class="reset flat border" id="reverse"
							onclick="return confirm('<%=restaurant.getName()%>のフォローを解除');">
							<i class="fas fa-user-check"></i></button>
							
							<%
							}
							%>
						</form>
				</td>
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
						口コミを見る  &gt;</button>
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
	<div class="button_wrapper">
	<a href="/today_Lunch/BackMainServlet" class="btn">メイン画面へ</a>
	　<a href="/today_Lunch/LogoutServlet" class="btn">ログアウト</a>
	</div>

	<!-- ページトップへ戻るボタン -->
	<p class="pagetop" style="display: block;">
		<a href="#"> <i class="fas fa-chevron-up"></i>
		</a>
	</p>


</div>
</html>