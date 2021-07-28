<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">

<head>
<pre>





	</pre>
<h1 class="title">&#x1f374; 本日のランチ &#x1f374;</h1>
</head>

<div class="body">
	<h1>&#x1f374; ユーザー登録画面 &#x1f374;</h1>
	<p>すべて記入してください。</p>
	<p>※IDは半角英数字10文字まで。</p>

	<form action="/today_Lunch/RegisterServlet" method="post">
		<table class="T_table">
			<tr>
				<th>ID</th>
				<td><input type="text" name="userId" maxlength='10' required></td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td><input type="password" name="pass" maxlength='10' required></td>
			</tr>
			<tr>
				<th>氏名</th>
				<td><input type="text" name="name" maxlength='40' required></td>
			</tr>
			<tr>
				<th>年齢</th>
				<td><input type="text" name="age" pattern="\d+"
					title="1文字以上の半角数字" required></td>
			</tr>
			<tr>
				<th>メールアドレス</th>
				<td><input type="email" name="mail" required></td>
			</tr>
		</table>
		<input type="submit" value="登録">
	</form>

	<br> <a href="/today_Lunch/LoginServlet">ログイン</a> 
	<a href="/today_Lunch/welcome.jsp">TOP画面へ戻る</a>
</div>
</html>