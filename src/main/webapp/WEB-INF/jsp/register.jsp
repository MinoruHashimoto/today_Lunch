<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
	<title>&#x1f374; 本日のランチ &#x1f374;</title>
	<meta charset="UTF-8">
	<%-- スタイルシート呼び出し --%>
	<link rel="stylesheet" href="css/color.css">
</head>


<div class="body">
<pre>





</pre>
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
					maxlength='10' pattern="1[0-9]|[2-9][0-9]|1[01][0-9]"
					title="あなたの年齢（半角数字)(10～119）" required /></td>
			</tr>
			<tr>
				<td><input type="email" class="form" placeholder="メールアドレス"
					name="mail" maxlength='10' required /></td>
			</tr>
		</table>
		<div class="cp_ipselect">
			<select name="gender" class="cp_sl06" required>
				<option value="hidden" disabled selected></option>
				<option value="男性">男性</option>
				<option value="女性">女性</option>
			</select> <span class="cp_sl06_highlight"></span> <span
				class="cp_sl06_selectbar"></span> <label class="cp_sl06_selectlabel">性別</label>
		</div>
		<pre></pre>
		<div class="button_wrapper">
			<button type="submit" id="gradual">登録</button>
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