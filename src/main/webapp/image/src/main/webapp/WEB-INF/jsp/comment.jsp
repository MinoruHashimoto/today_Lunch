<%-- コメント画面を出力するビュー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ 
page import="model.Account, model.Restaurant, model.Comment, java.util.List"%>
<%
String r_name = (String) session.getAttribute("r_name");
Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
List<Comment> cList = (List<Comment>) session.getAttribute("cList");
Account account =(Account)session.getAttribute("account");
String noComment = (String) request.getAttribute("noComment");
double avgStar = (double) session.getAttribute("avg" + restaurant.getId());
int follower = (int) session.getAttribute("follower" + restaurant.getId());
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
	<%-- 見出しの上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<h1>&#x1f374; 本日のランチ &#x1f374;</h1>
	<%-- 見出しの下部に3行空白を開けるタグ<pre> --%>
	<pre>



	</pre>

	<%-- 「&#x1f374;」はフォークとナイフの絵文字 --%>
	<h2>
		&#x1f374; 「<%=r_name%>」 &#x1f374;
	</h2>


	<table class="T_table">
		<tr>
			<th>店名</th>
			<th>ジャンル</th>
			<th>定番メニュー</th>
			<th>価格帯</th>
			<th>距離</th>
			<th>定休日</th>
			<th>電話番号</th>
			<th colspan="2">口コミ</th>
			<th>フォロワー</th>
		</tr>
		<tr>
			<td><h2>
					<a target="_blank" href="<%=restaurant.getUrl()%>"><%=restaurant.getName()%></a>
				</h2></td>
			<td><%=restaurant.getJanru()%></td>
			<td><%=restaurant.getDishes()%></td>
			<td><%=restaurant.getPrice()%></td>
			<td><%=restaurant.getDistance()%></td>
			<td><%=restaurant.getHoliday()%></td>
			<td><%=restaurant.getTel()%></td>
			<td class="star"><%if (avgStar >= 4.75) {
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
					%><span>(口コミなし)</span><%
				}%>
			</td>
			<td><%if(avgStar!=0){%>
					<%=avgStar%>
				<%} %></td>
			<td><%=follower%></td>
		</tr>
	</table>

	<%-- ここに口コミを表示する --%>
	<%
	if (cList != null) {
		if (cList.size() != 0) {
	%>
	<h2>口コミ</h2>
	<div class="review">
		<%
		for (Comment comment : cList) {
			//口コミを書いた人の年齢を取得
			int age =  (int) session.getAttribute(comment.getU_id()+"'s_age");
			if(age==0){
				age=account.getAge();
			}
		%>
		<p><%=comment.getU_id()%>さんの口コミ（<%=age %>歳）
		</p>
		<b> <span class="star"> <%
 switch (comment.getStar()) {
 case 1:
 %>★☆☆☆☆ <%
 break;
 case 2:
 %>★★☆☆☆ <%
 break;
 case 3:
 %>★★★☆☆ <%
 break;
 case 4:
 %>★★★★☆ <%
 break;
 case 5:
 %> ★★★★★ <%
 }
 %>
		</span> <%=comment.getTitle()%></b>
		<p>
			<%=comment.getText()%>
		</p>
		<%
		}
		}
		}
		if (noComment != null) {
		%>
		<p><%=noComment%></p>
		<%
		}
		%>
	</div>

	<%-- 口コミ記入欄 --%>
	<P></P>
	<h4 class="p">口コミをかく</h4>

	<form action="/today_Lunch/CommentServlet" method="post" class="p">
		<div class="evaluation">
			<input id="star1" type="radio" name="star" value="5" required /> <label
				for="star1"><span class="text">最高</span>★</label> <input id="star2"
				type="radio" name="star" value="4" /> <label for="star2"><span
				class="text">良い</span>★</label> <input id="star3" type="radio" name="star"
				value="3" /> <label for="star3"><span class="text">普通</span>★</label>
			<input id="star4" type="radio" name="star" value="2" /> <label
				for="star4"><span class="text">悪い</span>★</label> <input id="star5"
				type="radio" name="star" value="1" required /> <label for="star5"><span
				class="text">最悪</span>★</label>
		</div>
		<input name="title" placeholder="タイトルを入力" maxlength="45"
			title="1~45の文字列" class="review-write" required><br>
		<textarea name="text" rows="4" cols="40" placeholder="口コミを入力"
			maxlength="100" title="100文字以下のの文字列" class="review-write"></textarea>
		<br> <input type="submit" value="送信"> <input type="reset"
			value="リセット">
	</form>


	<%-- メイン画面・ログアウトの間に3行空けるタグ<pre> --%>
	<pre>



	</pre>
	<div class="button_wrapper">
		<a href="/today_Lunch/SuggestionServlet" class="btn"><span>提案画面へ</span></a>
		<a href="/today_Lunch/BackMainServlet" class="btn"><span>メイン画面</span></a>
		<a href="/today_Lunch/LogoutServlet" class="btn"><span>ログアウト</span></a>
	</div>
	<%-- body下部に10行空白を開けるタグ<pre> --%>
	<pre>










	</pre>
</div>
</html>