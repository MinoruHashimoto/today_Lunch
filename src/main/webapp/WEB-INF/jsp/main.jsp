<%--main画面を表示するビュー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 分離されたJSPテンプレート --%>
<!DOCTYPE html>
<html>


<head>
	<title>&#x1f374; 本日のランチ &#x1f374;</title>
	<meta charset="UTF-8">
	<%-- スタイルシート呼び出し --%>
	<link rel="stylesheet" href="css/color.css">
</head>


<div class="body">
	<%-- title上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<br>
	<h1 class="title">&#x1f374;　Welcome！　&#x1f374;</h1>
	<pre>
	
	
	</pre>
	<div class="button_wrapper">
	<a href="/today_Lunch/SuggestionServlet" class="hover-effect_slide">ランチ提案画面へ進む</a>
	</div>
	<br>［現在ログインしています］

	<%-- body下部に7行空白を開けるタグ<pre> --%>
	<pre>







	</pre>
</div>
</html>