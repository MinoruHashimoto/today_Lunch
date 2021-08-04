<%-- 管理者画面を表示するビュー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
	<title>&#x1f374; 本日のランチ &#x1f374;</title>
	<meta charset="UTF-8">
	<%-- スタイルシート呼び出し --%>
	<link rel="stylesheet" href="css/color.css">
</head>


<div class="body">
	<%-- 見出しの上部に5行空白を開けるタグ<pre> --%>
	<pre>





	</pre>
	<%-- 見出しの下部に3行空白を開けるタグ<pre> --%>
	<pre>



	</pre>


	<h2>&#x1f374;　管理者ログイン　&#x1f374;</h2>
	<form action="/today_Lunch/AdLoginServlet" method="post">
    <table class="T_table">
        <tr>
            <td><input type="text" class="form" placeholder="ID" name="id" maxlength='10' required/></td>
        </tr>
        <tr>
            <td><input type="password" class="form" placeholder="パスワード" name="pass" maxlength='10' required/></td>
        </tr>
    </table>
    <pre>
    </pre>
    	<div class="button_wrapper">
		<button type="submit" id="gradual">ログイン</button>
		</div>
</form> 
	<%-- body下部に7行空白を開けるタグ<pre> --%>
	<pre>







	</pre>
	<br>
<div class="button_wrapper">
<a href="/today_Lunch/welcome.jsp" class="btn"><span>トップへ戻る</span></a>
</div>
	<%-- body下部に10行空白を開けるタグ<pre> --%>
	<pre>










	</pre>
</div>
</html>