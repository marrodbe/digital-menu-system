console.log("APP START");

const SUPABASE_URL =
  "https://yuoeunioviahidgmyutr.supabase.co";

const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1b2V1bmlvdmlhaGlkZ215dXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg2MjM4MDAsImV4cCI6MjA5NDE5OTgwMH0.IVGtXHt1C_9ZYymNjrrcKscP-VthrvkZH3U_rQU9Vjk";

const supabaseClient =
  supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY
  );

let cocktails = [];
let current = 0;
let screenConfig = null;

const params =
  new URLSearchParams(
    window.location.search
  );

const screen =
  params.get("screen") || "pubfelix";

console.log("ACTIVE SCREEN:", screen);



// 🔹 LOAD SCREEN CONFIG (layout per TV)
async function loadScreenConfig() {

  const { data, error } =
    await supabaseClient
      .from("screens")
      .select("*")
      .eq("name", screen)
      .single();

  if (error) {
    console.log("SCREEN CONFIG ERROR:", error);
    return;
  }

  console.log("SCREEN CONFIG:", data);

  screenConfig = data;
}



// 🔹 LOAD MENU (cocktails)
async function loadMenu() {

  console.log("LOADING MENU");

  const { data, error } =
    await supabaseClient
      .from("cocktails")
      .select("*")
      .eq("screen", screen);

  console.log("DATA:", data);
  console.log("ERROR:", error);

  if (error) return;

  cocktails = data;

  if (!cocktails.length) return;

  const layout =
    screenConfig?.active_layout
    || cocktails[0].layout
    || "hero";

  document.body.setAttribute(
    "data-layout",
    layout
  );

if (layout === "grid") {

  // 🔴 HIDE HERO
  document.querySelector(".menu-container").style.display = "none";

  // 🟢 SHOW GRID
  document.getElementById("grid-layout").style.display = "grid";

  renderGridLayout();

  return;
}

if (layout === "food") {

  document.querySelector(".menu-container").style.display = "none";

  const grid = document.getElementById("grid-layout");
  grid.style.display = "flex";
  grid.style.flexDirection = "column";

  renderFoodLayout();

  return;
}

// 🟢 SHOW HERO AGAIN IF NOT GRID
document.querySelector(".menu-container").style.display = "block";
document.getElementById("grid-layout").style.display = "none";

  current = 0;
  showCocktail(current);
}



// 🔹 INITIALIZE APP
async function initialize() {
  await loadScreenConfig();
  await loadMenu();
}

initialize();



// 🔹 DISPLAY SINGLE COCKTAIL
function showCocktail(index) {

  if (!cocktails.length) return;

  const cocktail =
    cocktails[index];

  const image =
    document.getElementById("cocktail-image");

  const video =
    document.getElementById("background-video");

  const title =
    document.getElementById("cocktail-name");

  const description =
    document.getElementById("cocktail-description");

  const price =
    document.getElementById("cocktail-price");

  title.textContent = cocktail.name;
  description.textContent = cocktail.description;
  price.textContent = cocktail.price;

  if (cocktail.video) {

    video.src = cocktail.video;
    video.style.opacity = 1;
    image.style.opacity = 0;

  } else {

    image.src = cocktail.image;
    image.style.opacity = 1;
    video.style.opacity = 0;
  }
}



// 🔹 GRID LAYOUT
function renderGridLayout() {

  const grid =
    document.getElementById("grid-layout");

  if (!grid) return;

  grid.innerHTML = "";

  cocktails.forEach(cocktail => {

    const card =
      document.createElement("div");

    card.className = "grid-card";

    card.innerHTML = `
      <img src="${cocktail.image}">
      <div class="grid-info">
        <div class="grid-name">
          ${cocktail.name}
        </div>
        <div class="grid-description">
          ${cocktail.description}
        </div>
        <div class="grid-price">
          ${cocktail.price}
        </div>
      </div>
    `;

    grid.appendChild(card);
  });

  grid.style.display = "grid";
}

function renderFoodLayout() {

  const container =
    document.getElementById("grid-layout");

  container.innerHTML = "";

  cocktails.forEach(item => {

    const row =
      document.createElement("div");

    row.className = "food-row";

    row.innerHTML = `
      <div class="food-left">
        <div class="food-name">${item.name}</div>
        <div class="food-desc">${item.description || ""}</div>
      </div>
      <div class="food-price">${item.price}</div>
    `;

    container.appendChild(row);
  });
}



// 🔹 SLIDESHOW ROTATION
setInterval(() => {

  if (!cocktails.length) return;

  current =
    (current + 1) %
    cocktails.length;

  showCocktail(current);

}, 5000);



// 🔹 REALTIME UPDATES
const channel =
  supabaseClient.channel("cocktail-changes");

channel
  .on(
    "postgres_changes",
    {
      event: "*",
      schema: "public",
      table: "cocktails"
    },
    async payload => {

      console.log("REALTIME UPDATE");
      console.log(payload);

      await loadMenu();
    }
  )
  .subscribe(status => {

    console.log("SUB STATUS:", status);

  });