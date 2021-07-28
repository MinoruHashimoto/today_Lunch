<%-- 管理者ログイン失敗画面を表示するビュー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">


<head>
	<title>&#x1f374;　本日のランチ　&#x1f374;</title>
</head>

<div class="body">
	<%-- BODY下部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<h1>&#x1f374;　管理者ログイン失敗　&#x1f374;</h1>
	<p>ログインに失敗しました。</p>
	<a href="/today_Lunch/AdLoginServlet">再試行</a>
	<a href="/today_Lunch/welcome.jsp">TOP画面へ戻る</a>
</div>
</html>