<%-- コメント画面を出力するビュー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ 
page
	import="model.Account, model.Restaurant, model.Comment, java.util.List,
java.sql.Timestamp, java.text.SimpleDateFormat"%>
<%
String r_name = (String) session.getAttribute("r_name");
Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
List<Comment> cList = (List<Comment>) session.getAttribute("cList");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
Account login = (Account) session.getAttribute("account");
String noComment = (String) request.getAttribute("noComment");
double avgStar = (double) session.getAttribute("avg" + restaurant.getId());
int follower = (int) session.getAttribute("follower" + restaurant.getId());
%>
<!DOCTYPE html>
<html>


<head>
	<title>&#x1f374; 本日のランチ &#x1f374;</title>
	<meta charset="UTF-8">
	<%-- スタイルシート呼び出し --%>
	<link rel="stylesheet" href="css/color.css">
	<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
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
			<td class="star">
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
			<td>
				<%
				if (avgStar != 0) {
				%> <%=avgStar%> <%
 }
 %>
			</td>
			<td><%=follower%></td>
		</tr>
	</table>

			<div class="line-top"> 口コミ </div>
		<div class="line-bc">
			<!--①LINE会話全体を囲う-->
			<%
			if (noComment != null) {
			%>
			<p class="noRestaurant">
				&nbsp;&nbsp;<%=noComment%>&nbsp;&nbsp;
			</p>
			<%
			}
			//ここに口コミを表示する 
			if (cList != null) {
			if (cList.size() != 0) {
				for (Comment comment : cList) {
					//コメント投稿日時をフォーマット化して取得
					String timeStr = sdf.format(comment.getTime());
			%>
			<!--左コメント始-->
			<%
			if (!comment.getU_id().equals(login.getUserId())) {
				Account account = (Account) session.getAttribute(comment.getU_id() + "'s_account");
			%>
			<div class="balloon6">
			<!--男女で表示するアイコンを変える-->
				<div class="faceicon">
					<%if(account.getGender().equals("男性")){ %><div class="boy-icon"></div>
					<%}else if(account.getGender().equals("女性")){ %><div class="girl-icon"></div><%} %>
				</div>
				<div class="chatting">
					<div class="says">
						<p><%=comment.getU_id()%>さん(<%=account.getAge()%>代:<%=account.getGender()%>) <b> <span
								class="star"> <%
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
						</p>
						<p>
							<%=comment.getText()%>
						</p>
					</div>
				</div>
				<span class="time"> <%=timeStr%>&nbsp;</span>
			</div>
			<!--/左コメント終-->
			<%
			} else {
			int age = login.getAge();
			//30, 40のように、1桁目を切り捨てる
			age = (int) (Math.floor((double) age / 10)) * 10;
			%>
			<!--右コメント始-->
			<div class="mycomment">
				<p><%=comment.getU_id()%>さん(<%=age%>代:<%=login.getGender()%>) <b> <span
						class="star"> <%
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
					</span> <%=comment.getTitle()%></b><br>
					<%=comment.getText()%>
				</p>
			</div>
			<span class="time"> <%=timeStr%>&nbsp;</span>

			<!--/右コメント終-->


			<%
			}
			}
		}
		}
		%><%-- 口コミ記入欄 --%>

		</div>
		<!--/①LINE会話終了-->
		<div class="write-bc">
			<form action="/today_Lunch/CommentServlet" method="post">
				<div class="line-side">
					<div class="evaluation">
						<input id="star1" type="radio" name="star" value="5" required />
						<label for="star1"><span class="text">最高</span>★</label> <input
							id="star2" type="radio" name="star" value="4" /> <label
							for="star2"><span class="text">良い</span>★</label> <input
							id="star3" type="radio" name="star" value="3" /> <label
							for="star3"><span class="text">普通</span>★</label> <input
							id="star4" type="radio" name="star" value="2" /> <label
							for="star4"><span class="text">悪い</span>★</label> <input
							id="star5" type="radio" name="star" value="1" required /> <label
							for="star5"><span class="text">最悪</span>★</label>
					</div>
					&nbsp;※星の評価は必須&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="button_wrapper align">
						<button type="submit" class="reset flat airplane">
							<i class="fas fa-paper-plane"></i>
						</button>
					</div>
				</div>
				<input name="title" placeholder="タイトルを入力" maxlength="30"
					title="1~45の文字列" class="review-write" required>
				<textarea name="text" rows="7" cols="40" placeholder="口コミを入力"
					maxlength="100" title="100文字以下のの文字列" class="review-write"></textarea>
			</form>
		</div>

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