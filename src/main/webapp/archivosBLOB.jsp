<%-- 
    Document   : archivosBLOB
    Created on : 13/04/2016, 01:26:19 PM
    Author     : fzarate
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Archivos BLOB</title>
    </head>
    <body>
        <h1>Archivos BLOB!!!</h1>
        <label>Seleccione un archivo:</label>
        <input type="file" id="archivo" />
        <script>
            window.addEventListener('load', init);
            function init(){
                var inFile = document.getElementById('archivo');
                inFile.addEventListener('change', crearBlob, false);
            }
            function crearBlob(e){
                var archivos = e.target.files;
                for(var i=0; i<archivos.length;i++){
                    var archivo = archivos[i];
                    var fr = new FileReader();
                    fr.addEventListener('load', function(){
                        mostrar(event, archivo);
                    }, false);
                    
                    var blob = archivo.slice(0,1000);
                    fr.readAsBinaryString(blob);
                }
            }
            function mostrar(e,a){
                console.log(e);
                console.log(a);
            }
        </script>
    </body>
</html>
