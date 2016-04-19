<%-- 
    Document   : fileAPI
    Created on : 13/04/2016, 01:04:21 PM
    Author     : fzarate
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>fileAPI</title>
        <style>
            body{
                font-family: Arial;
            }
            .half{
                width: 40%;
                display: inline-block;
                vertical-align: top;
            }
        </style>
    </head>
    <body>
        <h1>File API!!!</h1>
        <h1>Leer archivos</h1>
        <div class="half">
            <form id="form">
                <input type="file" id="archivos" />
            </form>
            <section>
                <h2>Contenido del archivo</h2>
                <pre id="contenido"></pre>
            </section>
        </div>
        <div class="half">
            <h2>Informacion</h2>
            <p><strong>Nombre</strong></p> <span id="nombre"></span>
            <p><strong>Tamaño</strong></p> <span id="size"></span>
        </div> 
        <script>
            window.addEventListener('load', init);  
            function init(){
                var inData = document.getElementById('archivos');
                inData.addEventListener('change', leerArchivos, false);
            }
            function leerArchivos(e){
                var files = e.target.files;
                var reader = new FileReader();
                reader.addEventListener('load', muestrainfo, false);
                for(var i=0; i<files.length;i++){
                    var file = files[i];
                    document.getElementById("nombre").innerHTML = file.name;
                    document.getElementById("size").innerHTML = file.size/1024;
                    
                    if(file.type.match(/image.*/i)){
                        reader.readAsDataURL(file);
                        continue;
                    }
                    reader.readAsText(file);
                }
            }
            function muestrainfo(e){
                var result = e.target.result;
                var target = document.getElementById("contenido");
                
                if(result.indexOf(' ')<1){
                    var img = document.createElement('img');
                    img.setAttribute('src', result);
                    target.appendChild(img);
                    return;
                }
                target.innerHTML = e.target.result;
            }
        </script>
    </body>
</html>
