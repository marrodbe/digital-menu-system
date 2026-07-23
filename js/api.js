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

async function getMenuItemsForScreen(screenId) {

    const { data, error } = await db
        .from("screen_menu_items")
        .select("*")
        .eq("screen_id", screenId);

    console.log("SCREEN MENU ITEMS");
    console.table(data);
    console.log(error);

    return data;
}

async function getMenuItems(menuItemIds) {

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
        .in("id", menuItemIds);

    if (error) {
        console.error(error);
        return [];
    }

    return data;
}

function getAssetUrl(path) {

    if (!path) {
        return null;
    }

    const { data } = db
        .storage
        .from("menu-assets")
        .getPublicUrl(path);

    return data.publicUrl;
}