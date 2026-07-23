// js/ui.js

console.log("UI LOADED");

function renderHero(item) {

    // TEXT
    document.getElementById("cocktail-name").textContent =
        item.name;

    document.getElementById("cocktail-description").textContent =
        item.description || "";

    document.getElementById("cocktail-price").textContent =
        `$${Number(item.price).toFixed(2)}`;


    // IMAGE
    const imageElement = document.getElementById("cocktail-image");

    if (item.image_url) {

        imageElement.src = item.image_url;
        imageElement.style.display = "block";

    } else {

        imageElement.removeAttribute("src");
        imageElement.style.display = "none";
    }
}

function restartProgressBar(duration) {

    const progress = document.querySelector(".progress");

    if (!progress) {
        return;
    }

    // Reiniciar animación
    progress.style.transition = "none";
    progress.style.width = "0%";

    // Forzar al navegador a registrar el reset
    void progress.offsetWidth;

    // Iniciar nueva animación
    progress.style.transition = `width ${duration}ms linear`;
    progress.style.width = "100%";
}