async function getScreen(screenCode) {

    const { data, error } = await db
        .from("screens")
        .select("*")
        .eq("code", screenCode);

    if (error) {
        console.error(error);
        return null;
    }

    if (data.length === 0) {
        return null;
    }

    return data[0];
}


// ==============================
// GET MENU ITEMS FOR SCREEN
// ==============================

async function getMenuItemsForScreen(screenId) {

    const { data, error } = await db
        .from("screen_menu_items")
        .select("*")
        .eq("screen_id", screenId);

    console.log("SCREEN MENU ITEMS");
    console.table(data);
    console.log(error);

    if (error) {
        console.error(error);
        return [];
    }

    return data;
}


// ==============================
// GET MENU ITEMS
// ==============================

async function getMenuItems(menuItemIds) {

    if (!menuItemIds || menuItemIds.length === 0) {
        return [];
    }

    const { data, error } = await db
        .from("menu_items")
        .select(`
            *,
            categories (
                id,
                name,
                code
            )
        `)
        .in("id", menuItemIds)
        .eq("active", true);

    if (error) {
        console.error(error);
        return [];
    }

    return data;
}


// ==============================
// GET MENU ITEM MEDIA
// ==============================

async function getMenuItemMedia(menuItemIds) {

    if (!menuItemIds || menuItemIds.length === 0) {
        return [];
    }

    const { data, error } = await db
        .from("menu_item_media")
        .select("*")
        .in("menu_item_id", menuItemIds)
        .eq("active", true)
        .order("display_order", {
            ascending: true
        });

    if (error) {
        console.error(
            "Error loading menu item media:",
            error
        );

        return [];
    }

    return data;
}


// ==============================
// GET ASSET URL
// ==============================

function getAssetUrl(path) {

    if (!path) {
        return null;
    }

    const { data } = db
        .storage
        .from("menu-assets")
        .getPublicUrl(path);

    // Cache busting:
    // forces the browser to request the latest version
    // of an asset when the player is loaded.
    return `${data.publicUrl}?v=${Date.now()}`;
}

// =====================================================
// SYSTEM STATE
// =====================================================

async function getSystemLastUpdate() {

    const { data, error } = await db
        .from("system_state")
        .select("last_update")
        .eq("id", 1)
        .single();

    if (error) {
        console.error(
            "Error loading system state:",
            error
        );

        return null;
    }

    return data.last_update;
}

async function notifyMenuChanged() {

    const { error } = await db
        .from("system_state")
        .update({
            last_update: new Date().toISOString()
        })
        .eq("id", 1);

    if (error) {
        console.error("Error notifying menu change:", error);
    }

}

// ==========================
// DASHBOARD
// ==========================

async function getScreenStatus() {

    const { data, error } = await db
        .from("screen_status")
        .select("*")
        .order("screen");

    if (error) {

        console.error(error);
        return [];

    }

    return data;

}

async function getOnlineScreens() {

    const screens = await getScreenStatus();

    const now = Date.now();

    return screens.filter(screen => {

        const lastSeen = new Date(screen.last_seen).getTime();

        return (now - lastSeen) < 90000;

    });

}

async function getOfflineScreens() {

    const screens = await getScreenStatus();

    const now = Date.now();

    return screens.filter(screen => {

        const lastSeen = new Date(screen.last_seen).getTime();

        return (now - lastSeen) >= 90000;

    });

}

// ==========================================
// DASHBOARD
// ==========================================

async function getDashboardPlayers() {

    const { data, error } = await db
        .from("dashboard_players")
        .select("*")
        .order("name");

    if (error) {

        console.error(error);

        return [];

    }

    return data;

}