document.getElementById("menu-icon").onclick = function() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar.style.width === "0px" || sidebar.style.width === "") {
        sidebar.style.width = "250px";
    } else {
        sidebar.style.width = "0";
    }
};