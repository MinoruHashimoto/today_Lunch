<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">
<meta charset="UTF-8">

<head>
<title>本日のランチ</title>
</head>


<div class="body">
	<h1>&#x1f374; ユーザー登録画面 &#x1f374;</h1>
	<p>すべて記入してください。</p>
	<p>※IDは半角英数字10文字まで。</p>

	<form action="/today_Lunch/RegisterServlet" method="post">
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
				<td><input type="text" class="form" placeholder="氏名"
					name="name" maxlength='10' required /></td>
			</tr>
			<tr>
				<td><input type="text" class="form" placeholder="年齢" name="age"
					maxlength='10' pattern="1[3-9]|[2-9][0-9]|1[01][0-9]" title="あなたの年齢（半角数字）" required /></td>
			</tr>
			<tr>
				<td><input type="email" class="form" placeholder="メールアドレス"
					name="mail" maxlength='10' required /></td>
			</tr>
		</table>
		<pre></pre>
		<div class="button_wrapper">
			<button type="submit">登録</button>
		</div>
	</form>
	<pre>



		</pre>
	<div class="button_wrapper">
		<a href="/today_Lunch/LoginServlet" class="btn"><span>ログイン</span></a>
		<a href="/today_Lunch/welcome.jsp" class="btn"><span>トップへ戻る</span></a>
	</div>
</div>
</html>