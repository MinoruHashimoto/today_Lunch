<%-- 管理者ログイン失敗画面を表示するビュー --%>
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
	<%-- BODY下部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<h1>&#x1f374;　管理者ログイン失敗　&#x1f374;</h1>
	<p>ログインに失敗しました。</p>
	<a href="/today_Lunch/AdLoginServlet">管理者ログイン画面へ戻る</a>
	<a href="/today_Lunch/welcome.jsp">TOP画面へ戻る</a>
</div>
</html>