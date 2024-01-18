<?php

require __DIR__ . '\vendor\autoload.php';
// require __DIR__ . '\src\controller\HomeController.php';
// use proyecto\src\controller\HomeController;
// use proyecto\src\controller\HomeController as Controlador;
// $controller = new HomeController();
$servername = "127.0.0.1:3306";
$username = "root";
$password = "";
$dbname = "votaciones";

// Obtener la ruta desde la URL
$uri = $_SERVER['REQUEST_URI'];

//conexion a la base de datos (Mysql)
try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // Definir rutas
    switch ($uri) {
        case '/':
            header('Location: /src/public/index.html');
            exit();
            break;
            case '/votar':
                // Verificación del RUT y la inserción de datos
                $postData = json_decode(file_get_contents("php://input"), true);
            
                if (isset($postData['rut'])) {
                    // Llamada al SP InsertarVotante
                    $spQuery = "CALL InsertarVotante(:nombre_apellido, :alias, :rut, :email, :nombre_candidato, :fuente_referencia, :nombre_comuna, :nombre_region)";
            
                    // Preparar y ejecutar la llamada al SP
                    $spStmt = $conn->prepare($spQuery);
                    $spStmt->bindParam(':nombre_apellido', $postData['nombre_apellido']);
                    $spStmt->bindParam(':alias', $postData['alias']);
                    $spStmt->bindParam(':rut', $postData['rut']);
                    $spStmt->bindParam(':email', $postData['email']);
                    $spStmt->bindParam(':nombre_candidato', $postData['nombre_candidato']);
                    $spStmt->bindParam(':fuente_referencia', $postData['fuente_referencia']);
                    $spStmt->bindParam(':nombre_comuna', $postData['nombre_comuna']);
                    $spStmt->bindParam(':nombre_region', $postData['nombre_region']);
            
                    // Ejecutar la llamada al SP
                    $spStmt->execute();
            
                    // Verificar si hay errores
                    if ($spStmt->errorCode() !== '00000') {
                        $errorInfo = $spStmt->errorInfo();
                        echo "Error al ejecutar la consulta: " . implode(', ', $errorInfo);
                    } else {
                        // Obtener el resultado del SP
                        $result = $spStmt->fetch(PDO::FETCH_ASSOC);
            
                        if (isset($result['id_votante'])) {
                            echo "Datos insertados correctamente. ID Votante: " . $result['id_votante'];
                        } else {
                            echo "Error al insertar datos.";
                        }
                    }
                }
                break;            
        case '/getRegion':
        // Verificar si la solicitud es una petición AJAX
        if ($_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
            // Consulta para obtener todas las regiones
            $query = "SELECT * FROM Region";
            $stmt = $conn->prepare($query);
            $stmt->execute();

            // Obtener los resultados como un array asociativo
            $regiones = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Enviar las regiones como respuesta JSON
            header('Content-Type: application/json');
            echo json_encode($regiones);
            exit();
        } else {
            // Si la solicitud no es AJAX, devolver un error
            header('HTTP/1.0 400 Bad Request');
            echo '400 Bad Request';
            exit();
        }
        break;
        case '/getComuna':
            // Verificar si la solicitud es una petición AJAX
            if ($_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
                // Obtener el cuerpo de la solicitud
                $requestData = json_decode(file_get_contents("php://input"), true);

                // Verificar si se proporciona un ID de región en el cuerpo
                if (isset($requestData['region_id'])) {
                    $regionId = $requestData['region_id'];

                    // Consulta para obtener todas las comunas de una región específica
                    $query = "SELECT * FROM Comuna WHERE region_id = :region_id";
                    $stmt = $conn->prepare($query);
                    $stmt->bindParam(':region_id', $regionId);
                    $stmt->execute();

                    // Obtener los resultados como un array asociativo
                    $comunas = $stmt->fetchAll(PDO::FETCH_ASSOC);

                    // Enviar las comunas como respuesta JSON
                    header('Content-Type: application/json');
                    echo json_encode($comunas);
                    exit();
                } else {
                    // Si no se proporciona el ID de la región en el cuerpo, devolver un error
                    http_response_code(400);
                    echo json_encode(array('error' => 'Bad Request'));
                    exit();
                }
            } else {
                // Si la solicitud no es AJAX, devolver un error
                http_response_code(400);
                echo json_encode(array('error' => 'Bad Request'));
                exit();
            }
            break;        
        case '/getCandidatos':
        // Verificar si la solicitud es una petición AJAX
        if ($_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
            // Consulta para obtener todas las regiones
            $query = "SELECT * FROM candidato";
            $stmt = $conn->prepare($query);
            $stmt->execute();

            // Obtener los resultados como un array asociativo
            $candidatos = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Enviar las regiones como respuesta JSON
            header('Content-Type: application/json');
            echo json_encode($candidatos);
            exit();
        } else {
            // Si la solicitud no es AJAX, devolver un error
            header('HTTP/1.0 400 Bad Request');
            echo '400 Bad Request';
            exit();
        }
        break;
        default:
            header('HTTP/1.0 404 Not Found');
            echo '404 Not Found';
            break;
    }
} catch (PDOException $e) {
    echo "Error en la conexión: " . $e->getMessage();
    die();
}






?>