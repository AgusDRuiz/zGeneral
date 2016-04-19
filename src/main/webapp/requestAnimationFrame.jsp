<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>requestAnimationFrame</title>
        <style>
            #c{
                border: 2px solid;
            }
        </style>
    </head>
    <body>
        <h1>Request Animation Frame!!!</h1>
        <p>Optimizar las animaciones</p>
        <canvas width="800" height="600" id="c"></canvas>
        <script>
            var context, canvas;
            var x=0,y=0,v_x=5,v_y=5;
            window.addEventListener('load', init);
            
            window.requestAnimationFrame=(function (){
                    return window.requestAnimationFrame ||
                    window.webkitrequestAnimationFrame ||
                    window.mozrequestAnimationFrame||
                    function(f){
                    window.setTimeout(f, 100/60);
                    }
                })();//Autoejecutar la funcion
                function init(){
                    canvas = document.getElementById('c');
                    context = canvas.getContext('2d');
                    draw();
                }
                function draw(){
                    /*requestAnimationFrame(draw);
                    console.log(":)");*/
                    context.clearRect(0,0,canvas.width,canvas.height);
                    context.beginPath();
                    context.arc(x,y,50,0,Math.PI*2);
                    context.closePath;
                    context.fill();
                    x +=v_x;
                    y +=v_y;
                    if(x<0||x>canvas.width)v_x=-v_x;
                    if(y<0||y>canvas.height)v_y=-v_y;
                    requestAnimationFrame(draw);
                }
                draw();
            
        </script>
    </body>
</html>
