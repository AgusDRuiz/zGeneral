<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page Visibility</title>
    </head>
    <body>
        <h1>Page Visibility!!!</h1>
        <script>
            var arreglo_pre = getHidden();
            
            if(arreglo_pre){
                var hidden = arreglo_pre[0], visibilitychange = arreglo_pre[1];
            }else{
                alert("Tu navegador no lo soporta");
            }
            window.addEventListener('load', init);
            
            function init(){
                document.addEventListener(visibilitychange, manejadorVisi, false);
            }
            function manejadorVisi(){
                if(document[hidden]){
                    alert("cambiaste pagina");
                    return;
                }
            }
            function getHidden(){
                var prefijos = ['webkit','moz','ms'];
                if("hidden"  in document) return ["hidden","visibilitychange"];
                for(i in prefijos){
                    var prefijo = prefijos[i];
                     var opcion = prefijo+"Hidden";
                     var opcion_vs = prefijos+"visibilitychange";
                     if(opcion in document) return [opcion,opcion_vs];
                }
                return null;
            }
            
        </script>
    </body>
</html>
