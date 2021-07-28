<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">

<head>
	<%-- title上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<title>&#x1f374;　本日のランチ　&#x1f374;</title>
</head>

<div class = "body">
	<h1>&#x1f374;　登録完了　&#x1f374;</h1>
	<p>ユーザー登録を受け付けました。</p>
	<p>あなたのIDは${userId}です。</p>
	<%-- body下部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<a href="/today_Lunch/LoginServlet">ログイン画面へ進む</a><br>
	<a href="/today_Lunch/welcome.jsp">TOP画面へ戻る</a>
</div>
</html>