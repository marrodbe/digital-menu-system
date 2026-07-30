// ==========================================
// COCKTAILS
// ==========================================

function buildCocktailCard(c) {

    return `
        <label>Name</label>
        <input
            id="name-${c.id}"
            value="${c.name || ""}"
        >

        <label>Description</label>
        <input
            id="desc-${c.id}"
            value="${c.description || ""}"
        >

        <label>Price</label>
        <input
            id="price-${c.id}"
            value="${c.price || ""}"
        >

        <label>Image URL</label>
        <input
            id="img-${c.id}"
            value="${c.image || ""}"
            oninput="updatePreview(${c.id})"
        >

        <input
            type="file"
            onchange="uploadImage(event, ${c.id})"
        >

        <label>Preview</label>

        <img
            id="preview-${c.id}"
            src="${c.image || ""}"
            style="
                width:120px;
                height:120px;
                object-fit:cover;
                border-radius:8px;
                display:block;
                margin-bottom:15px;
            "
        >

        <label>Screen</label>

        <select id="screen-${c.id}">

            <option value="pubfelix"
                ${c.screen === "pubfelix" ? "selected" : ""}>
                pubfelix
            </option>

            <option value="pasillo"
                ${c.screen === "pasillo" ? "selected" : ""}>
                pasillo
            </option>

            <option value="futbolin"
                ${c.screen === "futbolin" ? "selected" : ""}>
                futbolin
            </option>

            <option value="cocina"
                ${c.screen === "cocina" ? "selected" : ""}>
                cocina
            </option>

        </select>

        <br><br>

        <button onclick="saveCocktail(${c.id})">
            Save
        </button>

        <button
            onclick="deleteCocktail(${c.id})"
            style="background:red;margin-left:10px;"
        >
            Delete
        </button>

    `;

}



// ==========================================
// HELPERS
// ==========================================

function getValue(id) {

    return document.getElementById(id).value;

}

function updatePreview(id) {

    const preview =
        document.getElementById(`preview-${id}`);

    if (!preview) return;

    preview.src =
        getValue(`img-${id}`);

}



// ==========================================
// LOAD
// ==========================================

async function loadCocktails() {

    const { data, error } =
        await db
            .from("cocktails")
            .select("*")
            .order("id");

    if (error) {

        console.error("Load Cocktails:", error);

        return;

    }

    const container =
        document.getElementById("list");

    container.innerHTML = "";

    data.forEach(c => {

        const div =
            document.createElement("div");

        div.className = "card";

        div.innerHTML =
            buildCocktailCard(c);

        container.appendChild(div);

    });

}



// ==========================================
// SAVE
// ==========================================

async function saveCocktail(id) {

    const payload = {

        name: getValue(`name-${id}`),

        description: getValue(`desc-${id}`),

        price: getValue(`price-${id}`),

        image: getValue(`img-${id}`),

        screen: getValue(`screen-${id}`)

    };

    const { error } =
        await db
            .from("cocktails")
            .update(payload)
            .eq("id", id);

    if (error) {

        console.error(error);

        alert("Error saving cocktail");

        return;

    }

    alert("Cocktail saved.");

}



// ==========================================
// DELETE
// ==========================================

async function deleteCocktail(id) {

    if (!confirm("Delete this cocktail?"))
        return;

    const { error } =
        await db
            .from("cocktails")
            .delete()
            .eq("id", id);

    if (error) {

        console.error(error);

        alert("Delete failed");

        return;

    }

    await loadCocktails();

}



// ==========================================
// ADD
// ==========================================

async function addCocktail() {

    const { error } =
        await db
            .from("cocktails")
            .insert({

                name: "New Cocktail",

                description: "",

                price: "",

                image: "",

                screen: "pubfelix"

            });

    if (error) {

        console.error(error);

        alert("Couldn't create cocktail");

        return;

    }

    await loadCocktails();

}



// ==========================================
// UPLOAD IMAGE
// ==========================================

async function uploadImage(event, id) {

    const file =
        event.target.files[0];

    if (!file) return;

    const fileName =
        `${Date.now()}-${file.name}`;

    const { error } =
        await db
            .storage
            .from("menu-images")
            .upload(fileName, file);

    if (error) {

        console.error(error);

        alert("Upload failed");

        return;

    }

    const { data } =
        db.storage
            .from("menu-images")
            .getPublicUrl(fileName);

    document.getElementById(
        `img-${id}`
    ).value = data.publicUrl;

    updatePreview(id);

    console.log("Image uploaded");

}