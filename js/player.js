// js/player.js

const SLIDE_DURATION = 6000;


// ==============================
// START PLAYER
// ==============================

async function startPlayer() {

    const params = new URLSearchParams(window.location.search);
    const screenCode = params.get("screen");

    if (!screenCode) {
        console.error("No screen specified.");
        return;
    }

    // Load screen
    const screen = await getScreen(screenCode);

    if (!screen) {
        console.error("Screen not found.");
        return;
    }

    console.log("Screen Loaded:", screen);


    // Load screen/menu relationships
    const screenMenuItems = await getMenuItemsForScreen(screen.id);

    if (!screenMenuItems || screenMenuItems.length === 0) {
        console.error("No menu items assigned to this screen.");
        return;
    }


    // Get menu item IDs
    const menuItemIds = screenMenuItems.map(
        item => item.menu_item_id
    );


    // Load actual menu items
    const menuItems = await getMenuItems(menuItemIds);


    // Build ordered player menu
    const playerMenu = buildPlayerMenu(
        screenMenuItems,
        menuItems
    );

    if (playerMenu.length === 0) {
        console.error("Player menu is empty.");
        return;
    }

    console.log("PLAYER MENU:", playerMenu);


    // Preload all images before starting rotation
    await preloadImages(playerMenu);

    console.log("IMAGES PRELOADED");


    // Start player
    startRotation(playerMenu);
}


// ==============================
// BUILD PLAYER MENU
// ==============================

function buildPlayerMenu(screenMenuItems, menuItems) {

    return screenMenuItems
        .map(screenItem => {

            const menuItem = menuItems.find(
                item => item.id === screenItem.menu_item_id
            );

            if (!menuItem) {
                return null;
            }

            return {
                ...menuItem,
                display_order: screenItem.display_order
            };
        })
        .filter(item => item !== null)
        .sort(
            (a, b) => a.display_order - b.display_order
        );
}


// ==============================
// PRELOAD IMAGES
// ==============================

async function preloadImages(playerMenu) {

    const promises = playerMenu.map(item => {

        if (!item.image_path) {
            return Promise.resolve();
        }

        const imageUrl = getAssetUrl(item.image_path);

        // Store final URL in player item
        item.image_url = imageUrl;

        return new Promise(resolve => {

            const img = new Image();

            img.onload = resolve;

            img.onerror = () => {
                console.error(
                    "Failed to preload image:",
                    imageUrl
                );

                resolve();
            };

            img.src = imageUrl;
        });
    });

    await Promise.all(promises);
}


// ==============================
// ROTATION
// ==============================

function startRotation(playerMenu) {

    if (!playerMenu || playerMenu.length === 0) {
        console.error("No items to rotate.");
        return;
    }

    let currentIndex = 0;

    function showCurrentItem() {

        const currentItem = playerMenu[currentIndex];

        // Render image + text
        renderHero(currentItem);

        // Start progress bar
        restartProgressBar(SLIDE_DURATION);

        // Don't rotate if there is only one item
        if (playerMenu.length === 1) {
            return;
        }

        setTimeout(() => {

            currentIndex =
                (currentIndex + 1) % playerMenu.length;

            showCurrentItem();

        }, SLIDE_DURATION);
    }

    showCurrentItem();
}


// ==============================
// INITIALIZE
// ==============================

startPlayer();