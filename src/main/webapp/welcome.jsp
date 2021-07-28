
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/welcome.css">

<head>
<title>&#x1f374; 本日のランチ &#x1f374;</title>
</head>

<div class="head">
	<h1 class="title">
		<span>&#x1f374;</span> <span>&nbsp;</span> <span>本</span> <span>日</span>
		<span>の</span> <span>ラ</span> <span>ン</span> <span>チ</span> <span>&nbsp;</span>
		<span>&#x1f374;</span>
	</h1>
</div>

<div class="body">
	<%-- title上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>

	<h1>&#x1f374; トップメニュー &#x1f374;</h1>
	<a href="/today_Lunch/LoginServlet" class="button"><span>サインイン</span><span>Sign
			in</span></a><br>
	<br> <a href="/today_Lunch/RegisterServlet" class="button"><span>ユーザー登録</span><span>Sign
			up</span></a><br>
	<br> <a href="/today_Lunch/AdLoginServlet" class="button"><span>管理者ページ</span><span>Administrator</span></a><br>
	<br>

	<%-- body下部に20行空白を開けるタグ<pre> --%>
	<pre>





















	</pre>
</div>

</html>