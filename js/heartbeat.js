// ==========================================
// HEARTBEAT
// ==========================================

let heartbeatTimer = null;

// ==========================================
// SEND HEARTBEAT
// ==========================================

async function sendHeartbeat(screen) {

    if (!screen) {

        console.error("Heartbeat: screen is undefined");

        return;

    }

    const payload = {

        screen: screen.code,

        screen_id: screen.id,

        current_menu: screen.layout,

        software_version: APP_VERSION,

        player_status: "online",

        last_seen: new Date().toISOString(),

        last_sync: lastSystemUpdate

    };

    console.log("Heartbeat payload:", payload);

    const { error } = await db
        .from("screen_status")
        .upsert(payload, {
            onConflict: "screen"
        });

    if (error) {

        console.error("Heartbeat Error:", error);

    } else {

        console.log("Heartbeat OK");

    }

}

// ==========================================
// START HEARTBEAT
// ==========================================

async function startHeartbeat(screen) {

    if (!screen) {

        console.error("Cannot start heartbeat. Screen not found.");

        return;

    }

    // Envía inmediatamente el primer heartbeat
    await sendHeartbeat(screen);

    // Evita múltiples timers
    if (heartbeatTimer) {

        clearInterval(heartbeatTimer);

    }

    heartbeatTimer = setInterval(() => {

        sendHeartbeat(screen);

    }, 30000);

}

// ==========================================
// STOP HEARTBEAT
// ==========================================

function stopHeartbeat() {

    if (heartbeatTimer) {

        clearInterval(heartbeatTimer);

        heartbeatTimer = null;

        console.log("Heartbeat stopped");

    }

}