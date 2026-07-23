// js/ui.js

console.log("UI LOADED");

function renderHero(item) {

    document.getElementById("cocktail-name").textContent =
        item.name;

    document.getElementById("cocktail-description").textContent =
        item.description;

    document.getElementById("cocktail-price").textContent =
        `$${Number(item.price).toFixed(2)}`;

}