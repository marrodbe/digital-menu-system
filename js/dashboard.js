// ==========================================
// DASHBOARD
// ==========================================

let dashboardData = [];

// ==========================================
// INIT
// ==========================================

async function initDashboard() {

    await reloadDashboard();

    subscribeDashboard();

}

// ==========================================
// RELOAD
// ==========================================

async function reloadDashboard() {

    dashboardData = await getDashboardPlayers();

    renderSummary();

    renderPlayers();

}

//
// ==========================================
// SUMMARY
// ==========================================

function renderSummary() {

    const summary =
        document.getElementById("summary");

    const now = Date.now();

    let online = 0;

    dashboardData.forEach(player => {

        if (!player.last_seen) return;

        const diff =
            (now - new Date(player.last_seen).getTime()) / 1000;

        if (diff < 90) {

            online++;

        }

    });

    const offline =
        dashboardData.length - online;

    summary.innerHTML = `

        <div class="kpi">

            <h2>${online}</h2>

            <p>Online</p>

        </div>

        <div class="kpi">

            <h2>${offline}</h2>

            <p>Offline</p>

        </div>

        <div class="kpi">

            <h2>${dashboardData.length}</h2>

            <p>Total Players</p>

        </div>

    `;

}

//
// ==========================================
// PLAYERS
// ==========================================

function renderPlayers() {

    const container =
        document.getElementById("players");

    container.innerHTML = "";

    dashboardData.forEach(player => {

        container.innerHTML +=
            buildPlayerCard(player);

    });

}

//
// ==========================================
// PLAYER CARD
// ==========================================

function buildPlayerCard(player) {

    const now = Date.now();

    let seconds = "-";

    let online = false;

    if (player.last_seen) {

        seconds =
            Math.floor(
                (now - new Date(player.last_seen).getTime()) / 1000
            );

        online = seconds < 90;

    }

    return `

        <div class="player">

            <h3>${player.name}</h3>

            <p>

                ${online ? "🟢" : "🔴"}

                ${online ? "Online" : "Offline"}

            </p>

            <p>

                <strong>Layout:</strong>

                ${player.layout ?? "-"}

            </p>

            <p>

                <strong>Version:</strong>

                ${player.software_version ?? "-"}

            </p>

            <p>

                <strong>Heartbeat:</strong>

                ${seconds} sec

            </p>

        </div>

    `;

}

// ==========================================
// REALTIME
// ==========================================

function subscribeDashboard() {

    const channel = db
        .channel("dashboard-monitor")
        .on(
            "postgres_changes",
            {
                event: "UPDATE",
                schema: "public",
                table: "screen_status"
            },
            (payload) => {

                console.log("Realtime payload:", payload);

                reloadDashboard();

            }
        );

    channel.subscribe((status, err) => {

        console.log("Dashboard Realtime:", status);

        if (err) {
            console.error("Realtime Error:", err);
        }

    });

}

//
// ==========================================
// START
// ==========================================

initDashboard();