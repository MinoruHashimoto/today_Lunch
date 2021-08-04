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


<div class = "body">
	<h1>&#x1f374;　登録失敗　&#x1f374;</h1><br>
	<p>登録に失敗しました。</p>
	<p>このIDは既に使用されています。</p>
	<p>別の新たなIDで登録しなおしてください。</p>
	<%-- body下部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<a href="/today_Lunch/RegisterServlet">登録画面へ戻る</a><br>
	<a href="/today_Lunch/welcome.jsp">TOP画面へ戻る</a>
</div>
</html>