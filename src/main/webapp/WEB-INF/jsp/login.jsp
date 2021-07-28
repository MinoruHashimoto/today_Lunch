<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<h1>&#x1f374; ログイン &#x1f374;</h1>
	<form action="/today_Lunch/LoginServlet" method="post">
		<table class="T_table">
			<tr>
				<th>ID:</th>
				<td><input type="text" name="userId" maxlength='10' required></td>
			</tr>
			<tr>
				<th>パスワード:</th>
				<td><input type="password" name="pass" maxlength='10' required></td>
			</tr>
			<tr>
				<th>&nbsp;</th>
				<td><input type="submit" value="ログイン" /></td>
			</tr>
		</table>
	</form>
	<%-- body下部に7行空白を開けるタグ<pre> --%>
	<pre>







	</pre>
	<a href="/today_Lunch/RegisterServlet">新規ユーザー登録</a>
	<a href="/today_Lunch/welcome.jsp">トップへ戻る</a>
</div>
</html>