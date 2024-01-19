Requerimientos:
Xamp instalado con apache y mysql
Composer 2.6.6 instalado
PHP 7.4.33 instalado
MariaDB 10.4.32 instalado, normalmente es la que usar por defecto XAMP

Paso 1: Descargar y copiar la carpeta del proyecto en la ruta C:\xampp\htdocs. Recomiendo nombrar la carpeta como "proyecto" debido a las configuraciones que se realizarán más adelante.

Paso 2: Ir a C:\xampp\apache\conf\extra, abrir el archivo httpd-vhosts.conf y agregar lo siguiente al final:
<VirtualHost *:80>
    DocumentRoot "C:\xampp\htdocs\proyecto"
    ServerName proyecto.local
    <Directory "C:\xampp\htdocs\proyecto">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

Paso 3: Ir a C:\xampp\apache\conf\extra, abrir httpd-xampp.conf y agregar lo siguiente en la última línea:

<Directory "C:/xampp/htdocs/proyecto/src/public">
    AllowOverride All
    Require all granted 
</Directory>

Paso 4: Abrir una terminal en la ruta C:\xampp\htdocs\proyecto para ejecutar los comandos "composer install" y luego "composer dump-autoload". Si todo está instalado correctamente, no debería haber problemas.

Paso 5: Ejecutar el script de la base de datos. Primero, crear el esquema y luego las tablas, seguido del dataset de regiones, comunas y candidatos.

Paso 6: Ejecutar el script para crear el procedimiento almacenado. Adjuntaré la base de datos exportada y un archivo de texto con los comandos CREATE e INSERT (si hay problemas con la creacion de la base de datos ejecutar en el mismo orden el txt de la base de datos).

PD: El puerto de la base de datos es 3306