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
<%-- 見出しの上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>

	<h1>&#x1f374; 登録失敗 &#x1f374;</h1><br>
	<p>登録に失敗しました。</p>
	<p>このIDは既に使用されています。</p>
	<p>別の新たなIDで登録しなおしてください。</p>
	<%-- body下部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<div class="button_wrapper">
	<a href="/today_Lunch/RegisterServlet" class="btn">登録画面へ戻る</a>
	　<a href="/today_Lunch/welcome.jsp" class="btn">TOP画面へ戻る</a>
	</div>
</div>
</html>