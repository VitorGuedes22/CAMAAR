function mostrar_ocultar() {
    var input_senha = document.getElementById('senha_pass');
    var btn_olho_senha = document.getElementById('olho_senha');

    if (input_senha.type === 'password') {
        input_senha.setAttribute('type', 'text');
        btn_olho_senha.classList.replace('olho_aberto', 'olho_fechado');
        btn_olho_senha.setAttribute('src', '../icons/olho_fechado.svg');
    } else {
        input_senha.setAttribute('type', 'password');
        btn_olho_senha.classList.replace('olho_fechado', 'olho_aberto');
        btn_olho_senha.setAttribute('src', '../icons/olho_aberto.svg');
    }
}

function mostrar_ocultar_r() {
    var input_senha = document.getElementById('redefinir_senha');
    var btn_olho_senha = document.getElementById('olho_senha');

    if (input_senha.type === 'password') {
        input_senha.setAttribute('type', 'text');
        btn_olho_senha.classList.replace('olho_aberto', 'olho_fechado');
        btn_olho_senha.setAttribute('src', '../icons/olho_fechado.svg');
    } else {
        input_senha.setAttribute('type', 'password');
        btn_olho_senha.classList.replace('olho_fechado', 'olho_aberto');
        btn_olho_senha.setAttribute('src', '../icons/olho_aberto.svg');
    }
}

function mostrar_ocultar_r1() {
    var input_senha1 = document.getElementById('confir_redefinir_senha');
    var btn_olho_senha = document.getElementById('olho_senha1');

    if (input_senha1.type === 'password') {
        input_senha1.setAttribute('type', 'text');
        btn_olho_senha.classList.replace('olho_aberto', 'olho_fechado');
        btn_olho_senha.setAttribute('src', '../icons/olho_fechado.svg');
    } else {
        input_senha1.setAttribute('type', 'password');
        btn_olho_senha.classList.replace('olho_fechado', 'olho_aberto');
        btn_olho_senha.setAttribute('src', '../icons/olho_aberto.svg');
    }
}

// essa função não é fixa
function redirecionarPagina() {
    window.location.href = "home.html";
}

function displayFileName(inputId, displayId) {
    const input = document.getElementById(inputId);
    const display = document.getElementById(displayId);
    const files = input.files;

    if (files.length > 0) {
        let fileNames = [];
        for (let i = 0; i < files.length; i++) {
            fileNames.push(files[i].name);
        }
        display.textContent = fileNames.join(', ');
    } else {
        display.textContent = "Nenhum arquivo selecionado";
    }
}

//Pop up de gerenciamento
document.addEventListener('DOMContentLoaded', () => {

    const popup = document.getElementById('popup');
    const closePopup = document.getElementById('close-popup');
    const popupUpload = document.getElementById('popup-upload');
    const closePopupUpload = document.getElementById('close-popup-upload');

    // Botões do Popup
    const btnImportar = document.getElementById('importar_dados_btn');
    const fileInputDisciplinas = document.getElementById('file_input_disciplinas');
    const fileInputMembros = document.getElementById('file_input_membros');
    const btnEditar = document.getElementById('editar_templates');
    const btnEnviar = document.getElementById('enviar_formularios');
    const btnResultados = document.getElementById('resultados');

    document.getElementById("menu-icon").onclick = function() {
        console.log("clicou");
        const sidebar = document.getElementById("sidebar");
        if (sidebar.style.width === "0px" || sidebar.style.width === "") {
            sidebar.style.width = "250px";
        } else {
            sidebar.style.width = "0";
        }
    };

    document.getElementById("gerenciamento-btn").onclick = function() {
        document.getElementById("title").textContent = "Gerenciamento";
        popup.style.display = "block"; // Abre popup
    };

    document.getElementById("avaliacoes-btn").onclick = function() {
        document.getElementById("title").textContent = "Avaliações";
    };

    // Ação do X de fechar o popup
    closePopup.onclick = function() {
        popup.style.display = "none";
    };

    closePopupUpload.onclick = function() {
        popupUpload.style.display = "none";
    };

    // Se clicar fora do popup ele fecha
    window.onclick = function(event) {
        if (event.target == popup) {
            popup.style.display = "none";
        }
        if (event.target == popupUpload) {
            popupUpload.style.display = "none";
        }
    };

    // Condições para habilitar botões
    btnImportar.onclick = function() {
        //console.log("Botão de Importar Dados clicado");
        //alert("Botão de Importar Dados clicado");
        popupUpload.style.display = "block"; // Abre o popup de upload
    };

    btnEditar.onclick = function() {
        btnEnviar.disabled = false;
    };

    btnEnviar.onclick = function() {
        btnResultados.disabled = false;
    };
});

/*
function validateFileType(input) {
    var file = input.files[0];
    var fileName = file.name.toLowerCase();
    var validExtensions = ["json"];

    if (!validExtensions.includes(fileName.split('.').pop())) {
        alert("O arquivo selecionado deve ser do tipo JSON.");
        input.value = ''; // Limpa o campo de seleção de arquivo
        input.nextElementSibling.textContent = 'Nenhum arquivo selecionado'; // Atualiza o texto visível
        document.getElementById("upload_form").querySelectorAll('input[type="submit"]')[0].disabled = true; // Desabilita o botão de enviar
    } else {
        input.nextElementSibling.textContent = fileName; // Mostra o nome do arquivo selecionado
        document.getElementById("upload_form").querySelectorAll('input[type="submit"]')[0].disabled = false; // Habilita o botão de enviar
    }
}
*/

function validateFileType(input) {
    var file = input.files[0];
    var fileName = file.name.toLowerCase();
    var validExtensions = ["json"];

    // Verifica a extensão do arquivo
    if (!validExtensions.includes(fileName.split('.').pop())) {
        alert("O arquivo selecionado deve ser do tipo JSON.");
        input.value = ''; // Limpa o campo de seleção de arquivo
        resetFileDisplay(input); // Atualiza o texto visível
        disableSubmitButton(); // Desabilita o botão de enviar
        return;
    } else{
        // Tenta ler o conteúdo do arquivo como JSON
        var reader = new FileReader();
        reader.onload = function(e) {
            try {
                JSON.parse(e.target.result); // Tenta analisar o conteúdo como JSON
                updateFileDisplay(input, fileName); // Atualiza o nome do arquivo visível
                enableSubmitButton(); // Habilita o botão de enviar
            } catch (error) {
                alert("O conteúdo do arquivo não está em formato JSON válido.");
                input.value = ''; // Limpa o campo de seleção de arquivo
                resetFileDisplay(input); // Atualiza o texto visível
                disableSubmitButton(); // Desabilita o botão de enviar
            }
        };
        reader.readAsText(file);
    }
}

function resetFileDisplay(input) {
    input.nextElementSibling.textContent = 'Nenhum arquivo selecionado';
}

function updateFileDisplay(input, fileName) {
    input.nextElementSibling.textContent = fileName;
}

function disableSubmitButton() {
    document.getElementById("upload_form").querySelector('input[type="submit"]').disabled = true;
}

function enableSubmitButton() {
    document.getElementById("upload_form").querySelector('input[type="submit"]').disabled = false;
}



