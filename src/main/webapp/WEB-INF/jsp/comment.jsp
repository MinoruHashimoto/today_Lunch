<%-- コメント画面を出力するビュー --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ 
page import="model.Restaurant,model.Comment,java.util.List"%>
<%
String r_name = (String) session.getAttribute("r_name");
Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
List<Comment> cList = (List<Comment>) session.getAttribute("cList");
String noComment = (String) request.getAttribute("noComment");
%>
<!DOCTYPE html>
<html>
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">
<div align="center">
	<head>
<meta charset="UTF-8">
<%-- 中央揃えのコード<center> --%>
<title>&#x1f374; 本日のランチ &#x1f374;</title>
	</head>
	<body>
		<%-- title上部に5行空白を開けるタグ<pre> --%>
		<pre>





</pre>
		<%-- 「&#x1f374;」はフォークとナイフの絵文字 --%>
		<h1>
			&#x1f374; 「<%=r_name%>」 &#x1f374;
		</h1>

		<%-- slectタグの文字サイズを変更するタグ<style> --%>
		<style>
select {
	font-size: 20px;
}
</style>
		<table border="1">
			<tr>
				<th>店名</th>
				<th>ジャンル</th>
				<th>定番メニュー</th>
				<th>価格帯</th>
				<th>距離</th>
				<th>定休日</th>
				<th>電話番号</th>
			</tr>
			<tr>
				<td><h2>
						<a href="<%=restaurant.getUrl()%>"><%=restaurant.getName()%></a>
					</h2></td>
				<td><%=restaurant.getJanru()%></td>
				<td><%=restaurant.getDishes()%></td>
				<td><%=restaurant.getPrice()%></td>
				<td><%=restaurant.getDistance()%></td>
				<td><%=restaurant.getHoliday()%></td>
				<td><%=restaurant.getTel()%></td>
			</tr>
		</table>

		<%-- ここにコメントを表示する --%>
		<%
		
		if (cList != null) {
			if (cList.size() != 0) {
		%>
		<p>ユーザーID:コメント</p>
		<%
		for (Comment comment : cList) {
		%>
		<p><%=comment.getU_id()%>さん：
			<%=comment.getText()%></p>
		<%
		}
		}
		} if (noComment != null) {
		%>
		<p><%=noComment%></p>
		<%
		}
		%>

		<%-- コメント記入欄 --%>
		<P></P>
		<h4>コメントをかく&#x270f;</h4>

		<form action="/today_Lunch/CommentServlet" method="post">
			<textarea name="text" rows="4" cols="40" placeholder="コメントを入力"
				minlength="1" maxlength="100" title="1~100の文字列" required></textarea>
			<br> <input type="submit" value="送信"> <input
				type="reset" value="リセット">
		</form>


		<%-- メイン画面・ログアウトの間に3行空けるタグ<pre> --%>
		<pre>



		</pre>
		<a href="/today_Lunch/SuggestionServlet">提案画面へ</a>
		<br>
		<a href="/today_Lunch/BackMainServlet">メイン画面へ</a>
		<br>
		<a href="/today_Lunch/LogoutServlet">ログアウト</a>
</div>
</body>
</html>