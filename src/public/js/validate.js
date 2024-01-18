let selecciones = 0;

$(document).ready(function() {
  var regionSelect = $("#region");
  var candidateSelect = $("#candidate");
  var selectedRegionId;
  var comunaSelect = $("#comuna");

  comunaSelect.append($("<option>", {
    value: "",
    text: "Seleccione Región"
  }));
  $.ajax({
    url: "http://localhost/getRegion",
    type: "GET",
    dataType: "json",
    success: function(data) {
        // Iterar sobre los datos y agregar opciones al select
        $.each(data, function(index, region) {
            regionSelect.append($("<option>", {
                value: region.region_id,
                text: region.nombre
            }));
        });

        // Manejar el cambio de la región seleccionada
        regionSelect.on("change", function() {
          // Obtener el ID de la región seleccionada
          selectedRegionId = $(this).val();

          console.log("ID de la región seleccionada:", selectedRegionId);
          cargarComunas(selectedRegionId);
      });
      
    },
    error: function(error) {
        console.error("Error al obtener datos de /getRegion:", error);
    }
  });
  
  $.ajax({
    url: "http://localhost/getCandidatos",
    type: "GET",
    dataType: "json",
    success: function(data) {
        // Iterar sobre los datos y agregar opciones al select de candidatos
        $.each(data, function(index, candidato) {
            candidateSelect.append($("<option>", {
                value: candidato.id_candidato,
                text: candidato.nombre
            }));
        });
    },
    error: function(error) {
        console.error("Error al obtener datos de /getCandidatos:", error);
    }
});

  $('#formVotacion').submit(function(event) { 
    
      event.preventDefault();
      // Validación del Nombre y Apellido
      var nameValue = $('#name').val().trim();
      if (nameValue === '') {
          alert('Nombre y Apellido no deben quedar en blanco.');
          event.preventDefault();
          return;
      }

      // Validación del Alias
      var aliasValue = $('#alias').val().trim();
      if (aliasValue.length <= 5 || !/[a-zA-Z0-9]/.test(aliasValue)) {
          alert('El Alias debe tener más de 5 caracteres y contener letras y números.');
          event.preventDefault();
          return;
      }

      // Validación del RUT
      var rutValue = $('#rut').val().trim();
      if (!validarRutChileno(rutValue)) {
          alert('El RUT no tiene el formato correcto.');
          event.preventDefault();
          return;
      }

      // Validación del Email
      var emailValue = $('#email').val().trim();
      if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailValue)) {
          alert('El correo electrónico no tiene el formato correcto.');
          event.preventDefault();
          return;
      }
      var dataVoto = capturarValores();
      var dataVotoJSON = JSON.stringify(dataVoto);
      console.log("dataVoto", dataVotoJSON);

      // Si todas las validaciones pasan, el formulario se enviará normalmente
      // Llamada ajax a la ruta definida en PHP
      $.ajax({
          url: 'http://localhost/votar',
          type: 'POST',
          contentType: "application/json", 
          data: dataVotoJSON,
          success: function(response) {
              // Manejar la respuesta del servidor si es necesario
              alert('Voto Registrado con exito!');
              console.log(response);
          },
          error: function(error) {
              // Manejar el error si es necesario
              console.log("error", error)
          }
      });
  });
});

function cargarComunas(regionId) {
  var comunaSelect = $("#comuna");
  // Realizar la llamada AJAX
  $.ajax({
      url: "http://localhost/getComuna",
      type: "POST",
      dataType: "json",
      contentType: "application/json", // Establecer el tipo de contenido como JSON
      data: JSON.stringify({ region_id: regionId }), // Pasar el region_id en el cuerpo de la solicitud
      success: function (data) {
          // Limpiar y llenar el select de comunas
          
          comunaSelect.empty(); // Limpiar opciones existentes

          // Agregar opción predeterminada
          comunaSelect.append($("<option>", {
              value: "",
              text: "Seleccione"
          }));

          // Iterar sobre las comunas y agregar opciones al select
          $.each(data, function (index, comuna) {
              comunaSelect.append($("<option>", {
                  value: comuna.comuna_id,
                  text: comuna.nombre
              }));
          });
      },
      error: function (error) {
          console.error("Error al obtener datos de /getComuna:", error);
      }
  });
}


function capturarValores() {
  var nombre = $('#name').val();
  var alias = $('#alias').val();
  var rut = $('#rut').val();
  var email = $('#email').val();
  var region = $('#region').val();
  var comuna = $('#comuna').val();
  var candidato = $('#candidate').val();
  
  rut = rut.replace(/\./g, ''); // Eliminar puntos
  rut = rut.replace('-', ''); // Eliminar guiones existentes
  rut = rut.slice(0, -1) + '-' + rut.slice(-1); // Agregar guión antes del último dígito

  var voteSeleccionado = [];
  $('input[name="vote[]"]:checked').each(function() {
      voteSeleccionado.push($(this).val());
  });
  var voteConcatenado = voteSeleccionado.join(', ');
  var valoresCapturados = {
    "nombre_apellido": nombre,
    "alias": alias,
    "rut": rut,
    "email": email,
    "nombre_candidato": candidato,
    "fuente_referencia": voteConcatenado,
    "nombre_comuna": comuna,
    "nombre_region": region
  };

  console.log('Valores:', valoresCapturados);
  return valoresCapturados;
};



function limitarSeleccion(checkbox) {
  if (checkbox.checked) {
    selecciones++;
  } else {
    selecciones--;
  }

  // Desmarcar las casillas si se excede el límite de dos selecciones
  if (selecciones > 2) {
    checkbox.checked = false;
    selecciones--;
  }
}

// Función para validar RUT chileno(módulo 11)  
function validarRutChileno(rut) {
    // Elimina puntos y guiones y convierte a minúsculas si hay una "k" al final
    rut = rut.replace(/[.-]/g, '').toLowerCase();

    // Extrae el dígito verificador
    var dv = rut.slice(-1);

    // Extrae el número sin el dígito verificador
    var num = rut.slice(0, -1);

    // Calcula el módulo 11
    var suma = 0;
    var factor = 2;

    for (var i = num.length - 1; i >= 0; i--) {
        suma += parseInt(num.charAt(i)) * factor;

        factor = factor === 7 ? 2 : factor + 1;
    }

    var resto = suma % 11;
    var dvCalculado = 11 - resto;

    // Compara el dígito verificador calculado con el proporcionado
    return (dvCalculado === 11 && dv === '0') || (dvCalculado === 10 && dv.toLowerCase() === 'k') || (dvCalculado < 10 && dvCalculado == dv);
}