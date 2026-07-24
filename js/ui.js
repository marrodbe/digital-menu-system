// js/ui.js

const TRANSITION_DURATION = 400;

let activeImage = "a";


// ==============================
// RENDER HERO
// ==============================

function renderHero(item) {

    if (!item) {
        console.error("No item provided to renderHero.");
        return;
    }

    const imageA =
        document.getElementById("cocktail-image-a");

    const imageB =
        document.getElementById("cocktail-image-b");

    // Primera carga
    if (item.image_url) {

        imageA.src = item.image_url;
        imageA.classList.add("active");

        imageB.classList.remove("active");

        activeImage = "a";
    }


    // TEXT
    updateHeroContent(item);
}


// ==============================
// TRANSITION HERO
// ==============================

function transitionHero(item) {

    if (!item) {
        return;
    }

    const imageA =
        document.getElementById("cocktail-image-a");

    const imageB =
        document.getElementById("cocktail-image-b");

    const content =
        document.querySelector(".menu-content");


    const currentImage =
        activeImage === "a"
            ? imageA
            : imageB;

    const nextImage =
        activeImage === "a"
            ? imageB
            : imageA;


    // Prepare next image
    if (item.image_url) {

        nextImage.src = item.image_url;

        nextImage.onload = () => {

            // Crossfade images
            nextImage.classList.add("active");
            currentImage.classList.remove("active");

        };

        // If image is already cached
        if (nextImage.complete) {

            nextImage.classList.add("active");
            currentImage.classList.remove("active");

        }

    }


    // Fade text out
    content.classList.add("hero-fade-out");


    setTimeout(() => {

        // Update text while invisible
        updateHeroContent(item);

        // Fade text back in
        content.classList.remove("hero-fade-out");

    }, TRANSITION_DURATION);


    // Switch active image
    activeImage =
        activeImage === "a"
            ? "b"
            : "a";
}


// ==============================
// UPDATE HERO CONTENT
// ==============================

function updateHeroContent(item) {

    const nameElement =
        document.getElementById("cocktail-name");

    const descriptionElement =
        document.getElementById("cocktail-description");

    const priceElement =
        document.getElementById("cocktail-price");


    nameElement.textContent =
        item.name || "";

    descriptionElement.textContent =
        item.description || "";

    priceElement.textContent =
        formatPrice(item.price);
}


// ==============================
// FORMAT PRICE
// ==============================

function formatPrice(price) {

    if (
        price === null ||
        price === undefined ||
        price === ""
    ) {
        return "";
    }

    const amount = Number(price);

    if (Number.isNaN(amount)) {
        return "";
    }

    return `₡${amount.toLocaleString("es-CR", {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    })}`;
}


// ==============================
// PROGRESS BAR
// ==============================

function restartProgressBar(duration) {

    const progress =
        document.querySelector(".progress");

    if (!progress) {
        return;
    }

    progress.style.transition = "none";
    progress.style.width = "0%";

    void progress.offsetWidth;

    progress.style.transition =
        `width ${duration}ms linear`;

    progress.style.width = "100%";
}