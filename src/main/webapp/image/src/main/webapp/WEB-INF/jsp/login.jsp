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
				<td><input type="text" class="form" placeholder="ID"
					name="userId" maxlength='10' required /></td>
			</tr>
			<tr>
				<td><input type="password" class="form" placeholder="Password"
					name="pass" maxlength='10' required /></td>
			</tr>
			<tr>
				<th></th>
			</tr>
		</table>
		<pre>
		</pre>
		<div class="button_wrapper">
			<button type="submit">ログイン</button>
		</div>
	</form>
	<%-- body下部に7行空白を開けるタグ<pre> --%>
	<pre>







	</pre>
	<div class="button_wrapper">
		<a href="/today_Lunch/RegisterServlet" class="btn"><span>ユーザー登録</span></a>
		<a href="/today_Lunch/welcome.jsp" class="btn"><span>トップへ戻る</span></a>
	</div>
</div>
</html>