async function startPlayer() {

    const params = new URLSearchParams(window.location.search);

    const screenCode = params.get("screen");

    if (!screenCode) {
        console.error("No screen specified.");
        return;
    }

    const screen = await getScreen(screenCode);

    if (!screen) {
        console.error("Screen not found.");
        return;
    }

    console.log("Screen Loaded");

    console.table(screen);

    const menu = await getMenuItemsForScreen(screen.id);

    const menuItemIds = menu.map(item => item.menu_item_id);

    const menuItems = await getMenuItems(menuItemIds);

    const firstItem = menuItems[0];

    renderHero(firstItem);

}

startPlayer();