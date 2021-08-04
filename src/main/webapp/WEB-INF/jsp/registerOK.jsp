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


<div class = "body">

<pre>





</pre>
	<h1>&#x1f374; 登録完了 &#x1f374;</h1>
	<p>ユーザー登録を受け付けました。</p>
	<p>あなたのIDは${userId}です。</p>
	<%-- body下部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<div class="button_wrapper">
	<a href="/today_Lunch/LoginServlet" class="btn">ログイン画面へ進む</a>
	　<a href="/today_Lunch/welcome.jsp" class="btn">TOP画面へ戻る</a>
	</div>
</div>
</html>