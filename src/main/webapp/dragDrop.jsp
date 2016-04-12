<%-- 
    Document   : dragDrop
    Created on : 11/04/2016, 01:24:12 PM
    Author     : fzarate
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/dragDrop.css" />
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Drag Drop API!!!</h1>
        <div id="main">
            <div class="source">
                <div class="circle" draggable="true"></div>
                <div class="circle" draggable="true"></div>
                <div class="circle" draggable="true"></div>
                <div class="circle" draggable="true"></div>
            </div>
            <div class="container"></div>
        </div>
        <script type="text/javascript">
            var container;
            window.addEventListener('load', init);
            function init(){
                container = document.querySelector('.container');
                container.addEventListener('dragover', dragSobreContainer, false);
                container.addEventListener('dragleave', dragSalioContainer, false);
                container.addEventListener('drop', manejarDrop, false);
                
                var circles = document.getElementsByClassName('circle');
                for(i in circles){
                    var circle  = circles[i];
                    var x = random(0,90);
                    var y = random(0,90);
                    if (typeof circle.style != "undefined"){
                        circle.style.top = y+'%';
                        circle.style.left = x+'%';
                        circle.addEventListener('dragstart', dragIniciado, false);
                        circle.addEventListener('dragend', dragFinalizado, false);
                    }
                }
            }
            
            function dragIniciado(e){
                this.style.backgroundColor='blue';
                var padre = document.createElement('p');
                var clone = this.cloneNode(true);
                padre.appendChild(clone);
                e.dataTransfer.setData('text', padre.innerHTML);
            }
            function manejarDrop(e){
                e.preventDefault();
                var datos = e.dataTransfer.getData('text')
            }
            function dragSobreContainer(e){
                e.preventDefault();
                this.classList.add('over');
                return false;
            }
            function dragSalioContainer(e){
                e.preventDefault();
                this.classList.remove('over');
                return false;
            }
            function dragFinalizado(e){
                this.style.backgroundColor='red';
            }
            function random(min,max){
                return Math.floor(Math.random()*(max-min+1))+min;
            }
        </script>
    </body>
</html>
