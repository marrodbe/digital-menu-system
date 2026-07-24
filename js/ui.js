// js/ui.js

const TRANSITION_DURATION = 400;

let activeImage = "a";
let activeKitchenImage = "a";


// =====================================================
// HERO LAYOUT
// Pub Felix
// =====================================================


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


    if (item.image_url) {

        nextImage.src = item.image_url;

        nextImage.onload = () => {

            nextImage.classList.add("active");
            currentImage.classList.remove("active");

        };

        if (nextImage.complete) {

            nextImage.classList.add("active");
            currentImage.classList.remove("active");

        }
    }


    content.classList.add("hero-fade-out");


    setTimeout(() => {

        updateHeroContent(item);

        content.classList.remove("hero-fade-out");

    }, TRANSITION_DURATION);


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


// =====================================================
// KITCHEN LAYOUT
// Cocina
// =====================================================


// ==============================
// RENDER KITCHEN MENU
// ==============================

function renderKitchenMenu(items) {

    // ==============================
    // KITCHEN LOGO
    // ==============================

    const kitchenLogo =
        document.getElementById("kitchen-logo");

    if (kitchenLogo) {
        kitchenLogo.src = getAssetUrl(
            "logos/mercadito-la-california-logo.png"
        );
    }

    const container =
        document.getElementById("kitchen-items");

    if (!container) {
        console.error("Kitchen items container not found.");
        return;
    }

    container.innerHTML = "";


    items.forEach(item => {

        const row =
            document.createElement("div");

        row.className = "kitchen-item";


        const name =
            document.createElement("div");

        name.className = "kitchen-item-name";

        name.textContent =
            item.name || "";


        const price =
            document.createElement("div");

        price.className = "kitchen-item-price";

        price.textContent =
            formatPrice(item.price);


        row.appendChild(name);
        row.appendChild(price);

        container.appendChild(row);
    });
}


// ==============================
// PREPARE KITCHEN MEDIA
// ==============================

function buildKitchenMedia(media) {

    if (!media || media.length === 0) {
        return [];
    }

    return media
        .filter(item =>
            item.active === true &&
            item.media_type === "image"
        )
        .sort((a, b) =>
            a.display_order - b.display_order
        )
        .map(item => ({
            ...item,
            image_url: getAssetUrl(item.file_path)
        }));
}


// ==============================
// FIRST KITCHEN IMAGE
// ==============================

function renderKitchenImage(item) {

    if (!item || !item.image_url) {
        return;
    }

    const imageA =
        document.getElementById("kitchen-image-a");

    const imageB =
        document.getElementById("kitchen-image-b");

    if (!imageA || !imageB) {
        return;
    }


    imageA.src = item.image_url;

    imageA.classList.add("active");
    imageB.classList.remove("active");

    activeKitchenImage = "a";
}


// ==============================
// KITCHEN IMAGE CROSSFADE
// ==============================

function transitionKitchenImage(item) {

    if (!item || !item.image_url) {
        return;
    }

    const imageA =
        document.getElementById("kitchen-image-a");

    const imageB =
        document.getElementById("kitchen-image-b");


    const currentImage =
        activeKitchenImage === "a"
            ? imageA
            : imageB;

    const nextImage =
        activeKitchenImage === "a"
            ? imageB
            : imageA;


    nextImage.src = item.image_url;


    const showNextImage = () => {

        nextImage.classList.add("active");

        currentImage.classList.remove("active");

    };


    nextImage.onload = showNextImage;


    if (nextImage.complete) {
        showNextImage();
    }


    activeKitchenImage =
        activeKitchenImage === "a"
            ? "b"
            : "a";
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