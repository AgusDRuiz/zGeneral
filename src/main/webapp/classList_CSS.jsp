<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ClassList</title>
        <style>
            div{
                height: 100px;
                width: 100px;
                background-color: #33FF70;
                transition: all 0.4s;
            }
            .rojo{
                background-color: #222;
                border-radius: 200px;
            }
        </style>
    </head>
    <body>
        <h1>Classlist API</h1>
        <div id="elemento"></div>
        <script>
            var bandera = false;
            window.addEventListener('load', init);
            function init(){
                var el = document.querySelector('#elemento');
                el.onclick = function(){
                    /*if(!bandera){
                        el.classList.add('rojo');
                        bandera = true;                        
                    }else{
                        el.classList.remove('rojo');
                        bandera = false;
                    }*/
                    /*if(!el.classList.contains('rojo')){
                        el.classList.add('rojo');                        
                    }else{
                        el.classList.remove('rojo');
                    }*/
                    el.classList.toggle('rojo');
                }
            }
        </script>
    </body>
</html>
