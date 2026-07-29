// js/player.js

const SLIDE_DURATION = 6000;
const KITCHEN_IMAGE_DURATION = 6000;

// =====================================================
// SYSTEM UPDATE WATCHER
// =====================================================

let lastSystemUpdate = null;
let realtimeChannel = null;


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

    // ==========================
    // LOAD SCREEN
    // ==========================

    const screen = await getScreen(screenCode);

    if (!screen) {
        console.error("Screen not found.");
        return;
    }

    console.log("Screen Loaded:", screen);

    // ==========================
    // SYSTEM STATE
    // ==========================

    lastSystemUpdate = await getSystemLastUpdate();

    console.log("SYSTEM LAST UPDATE:", lastSystemUpdate);

    // ==========================
// REALTIME
// ==========================

if (!realtimeChannel) {

    realtimeChannel = db
        .channel("system-state")

        .on(
            "postgres_changes",
            {
                event: "UPDATE",
                schema: "public",
                table: "system_state"
            },
            (payload) => {

                console.log(
                    "Realtime update received:",
                    payload.new.last_update
                );

                if (
                    payload.new.last_update !== lastSystemUpdate
                ) {

                    lastSystemUpdate = payload.new.last_update;

                    console.log(
                        "🔄 Menu updated. Reloading page..."
                    );

                    window.location.reload();

                }

            }
        )

        .subscribe((status) => {

            console.log(
                "Supabase Realtime status:",
                status
            );

        });

}


    // ==========================
    // LOAD SCREEN MENU
    // ==========================

    const screenMenuItems =
        await getMenuItemsForScreen(screen.id);

    if (
        !screenMenuItems ||
        screenMenuItems.length === 0
    ) {
        console.error(
            "No menu items assigned to this screen."
        );

        return;
    }


    // ==========================
    // GET MENU ITEM IDS
    // ==========================

    const menuItemIds =
        screenMenuItems.map(
            item => item.menu_item_id
        );


    // ==========================
    // LOAD MENU ITEMS + MEDIA
    // ==========================

    const menuItems =
        await getMenuItems(menuItemIds);

    const menuMedia =
        await getMenuItemMedia(menuItemIds);

    console.log("MENU MEDIA:", menuMedia);


    // ==========================
    // BUILD ORDERED MENU
    // ==========================

    const playerMenu =
        buildPlayerMenu(
            screenMenuItems,
            menuItems
        );

    if (playerMenu.length === 0) {

        console.error(
            "Player menu is empty."
        );

        return;
    }

    console.log("PLAYER MENU:", playerMenu);


    // ==========================
    // CHOOSE LAYOUT
    // ==========================

    if (screen.layout === "grid") {

        startKitchen(
            playerMenu,
            menuMedia
        );

        return;
    }


    // Default layout = HERO

    await preloadImages(playerMenu);

    console.log("IMAGES PRELOADED");

    startRotation(playerMenu);
}


// ==============================
// BUILD PLAYER MENU
// ==============================

function buildPlayerMenu(
    screenMenuItems,
    menuItems
) {

    return screenMenuItems
        .map(screenItem => {

            const menuItem =
                menuItems.find(
                    item =>
                        item.id ===
                        screenItem.menu_item_id
                );

            if (!menuItem) {
                return null;
            }

            return {
                ...menuItem,
                display_order:
                    screenItem.display_order
            };
        })
        .filter(item => item !== null)
        .sort(
            (a, b) =>
                a.display_order -
                b.display_order
        );
}


// =====================================================
// HERO
// Pub Felix
// =====================================================


// ==============================
// PRELOAD HERO IMAGES
// ==============================

async function preloadImages(playerMenu) {

    const promises =
        playerMenu.map(item => {

            if (!item.image_path) {
                return Promise.resolve();
            }

            const imageUrl =
                getAssetUrl(item.image_path);

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
// HERO ROTATION
// ==============================

function startRotation(playerMenu) {

    if (
        !playerMenu ||
        playerMenu.length === 0
    ) {

        console.error(
            "No items to rotate."
        );

        return;
    }


    let currentIndex = 0;
    let firstRender = true;


    function showCurrentItem() {

        const currentItem =
            playerMenu[currentIndex];


        if (firstRender) {

            renderHero(currentItem);

            firstRender = false;

        } else {

            transitionHero(currentItem);

        }


        restartProgressBar(
            SLIDE_DURATION
        );


        if (playerMenu.length === 1) {
            return;
        }


        setTimeout(() => {

            currentIndex =
                (currentIndex + 1) %
                playerMenu.length;

            showCurrentItem();

        }, SLIDE_DURATION);
    }


    showCurrentItem();
}


// =====================================================
// KITCHEN
// Cocina
// =====================================================


// ==============================
// START KITCHEN
// ==============================

async function startKitchen(
    playerMenu,
    menuMedia
) {

    console.log("STARTING KITCHEN");


    // Hide Hero
    const heroLayout =
        document.getElementById(
            "hero-layout"
        );

    if (heroLayout) {
        heroLayout.style.display = "none";
    }


    // Show Kitchen/Grid
    const gridLayout =
        document.getElementById(
            "grid-layout"
        );

    if (gridLayout) {
        gridLayout.style.display = "grid";
    }


    // Render static menu
    renderKitchenMenu(playerMenu);


    // Prepare media URLs
    const kitchenMedia =
        buildKitchenMedia(menuMedia);

    console.log(
        "KITCHEN MEDIA:",
        kitchenMedia
    );


    if (kitchenMedia.length === 0) {

        console.warn(
            "No kitchen media available."
        );

        return;
    }


    // Preload all kitchen images
    await preloadKitchenImages(
        kitchenMedia
    );

    console.log(
        "KITCHEN IMAGES PRELOADED"
    );


    // Start photo rotation
    startKitchenRotation(
        kitchenMedia
    );
}


// ==============================
// PRELOAD KITCHEN IMAGES
// ==============================

async function preloadKitchenImages(
    media
) {

    const promises =
        media.map(item => {

            if (!item.image_url) {
                return Promise.resolve();
            }


            return new Promise(resolve => {

                const img =
                    new Image();

                img.onload =
                    resolve;


                img.onerror = () => {

                    console.error(
                        "Failed to preload kitchen image:",
                        item.image_url
                    );

                    resolve();
                };


                img.src =
                    item.image_url;
            });
        });


    await Promise.all(promises);
}


// ==============================
// KITCHEN IMAGE ROTATION
// ==============================

function startKitchenRotation(media) {

    if (
        !media ||
        media.length === 0
    ) {

        return;
    }


    let currentIndex = 0;


    // First image
    renderKitchenImage(
        media[currentIndex]
    );


    // Only one image = no rotation
    if (media.length === 1) {
        return;
    }


    setInterval(() => {

        currentIndex =
            (currentIndex + 1) %
            media.length;


        transitionKitchenImage(
            media[currentIndex]
        );

    }, KITCHEN_IMAGE_DURATION);
}

// ==============================
// INITIALIZE
// ==============================

startPlayer();