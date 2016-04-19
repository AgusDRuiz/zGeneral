<%-- 
    Document   : dataSet
    Created on : 13/04/2016, 11:07:58 AM
    Author     : fzarate
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DataSet!!!</title>
    </head>
    <body>
        <div id="elementoUno" data-a="ejemplo"></div>
        <div id="elementoDos" data-a="ejemplo"></div>
        <script>
            window.addEventListener('load', init);
            function init(){
                vardocument.querySelectorAll('[data-a]');
                
                var ele = document.getElementById("elementoUno");
                console.log(ele.getAttribute('data-a'));//No es lo recomendable
                
                console.log(ele.dataset.a);     //$("#elemento").data('a');
                ele.dataset.a = "casa";         //$("#elemento").data('a','casa');
                console.log(ele.dataset.a);
            }
        </script>
    </body>
</html>
