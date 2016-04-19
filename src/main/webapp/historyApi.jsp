<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History API!!!</title>
    </head>
    <body>
        <h1>History API</h1>
        <script>
            //window.addEventListener('load', init);
            //window.history.back();      //retroceder de página
            //window.history.forward();   //avanza de página
            //window.history.go();        //retrocede o avanza depende el parametro -n<x<n
            
            window.history.pushState({curso:"HTML5"},"","/cambio");
            window.history.pushState({curso:"HTML5"},"","/cambio");
            //window.history.replaceState(null,"","/cambio");
            window.history.back();
            window.onpopstate = function(e){                
                console.log(e.state.curso);
            }
            console.log(window.history.length)
        </script>
    </body>
</html>
