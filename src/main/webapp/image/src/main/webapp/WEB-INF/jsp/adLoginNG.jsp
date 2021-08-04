<%-- 管理者ログイン失敗画面を表示するビュー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%-- スタイルシート呼び出し --%>
<link rel="stylesheet" href="css/color.css">


<head>
	<title>&#x1f374; 本日のランチ &#x1f374;</title>
</head>


<div class="body">
	<%-- 見出しの上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<%-- 見出しの下部に3行空白を開けるタグ<pre> --%>
	<pre>



	</pre>

	<h2>&#x1f374;　管理者ログイン失敗　&#x1f374;</h2>
	<p>ログインに失敗しました。</p>
<div class="button_wrapper">
 	<a href="/today_Lunch/AdLoginServlet" class="btn"><span>再試行</span></a>　
	<a href="/today_Lunch/welcome.jsp" class="btn"><span>トップへ戻る</span></a>　
</div>
		<%-- body下部に15行空白を開けるタグ<pre> --%>
	<pre>















	</pre>
</div>
</html>