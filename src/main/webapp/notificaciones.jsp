
<!DOCTYPE html>
<html>
    <head>
        <title>Notificaciones</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>Notificaciones!!!</h1>
        <p>¿Quieres activar notificaiones?</p>
        <div id="aviso"></div>
        <button id="act_not">Activar Notificaciones</button>
        <script>
            console.log(window.webkitNotifications);
            if(!window.webkitNotifications){
                alert("Tu navegador no soporta las funcionalidades de esta página");
            }
            window.addEventListener('load', init);
            function init(){
                document.querySelector('#act_not').addEventListener('click', function(){
                        if(window.webkitNotifications.checkPermission() == 0) createNotification();
                        else window.webkitNotifications.requestPermission();
                    
                },false);
            }
            function createNotification(){
                var notification = window.webkitNotifications.createNotification("img.png","Uso de Notification API","Felicidades con la configuracion");
                notification.show();
            }
        </script>
    </body>
</html>
