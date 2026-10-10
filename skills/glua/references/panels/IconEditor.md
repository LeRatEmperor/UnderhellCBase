# IconEditor

**Realm:** Client  ·  **Members:** 12  ·  **Inherits:** `DFrame`

An icon editor that permits a user to modify a [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon) and re-render it. This is used by the spawn menu and is what is shown when you right-click an icon and select `Edit Icon`.

This makes use of the [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel) element.

> **Note:** This panel is only available in Sandbox and Sandbox derived gamemodes!

[wiki page](https://wiki.facepunch.com/gmod/IconEditor)

### IconEditor:AboveLayout · Client
`IconEditor:AboveLayout()`

Applies the top-down view camera settings for the model in the [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel).

Called when a user clicks the `Above` (third) button (See [IconEditor](https://wiki.facepunch.com/gmod/IconEditor)).

[wiki](https://wiki.facepunch.com/gmod/IconEditor:AboveLayout)

---

### IconEditor:BestGuessLayout · Client
`IconEditor:BestGuessLayout()`

Applies the best camera settings for the model in the [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel), using the values returned by [PositionSpawnIcon](https://wiki.facepunch.com/gmod/Global.PositionSpawnIcon).

Called when a user clicks the `wand` button (See the ) and when [IconEditor:Refresh](https://wiki.facepunch.com/gmod/IconEditor:Refresh) is called.

[wiki](https://wiki.facepunch.com/gmod/IconEditor:BestGuessLayout)

---

### IconEditor:FillAnimations · Client · `INTERNAL`
`IconEditor:FillAnimations(ent: Entity)`

Fills the [DListView](https://wiki.facepunch.com/gmod/DListView) on the left of the editor with the model entity's animation list. Called by [IconEditor:Refresh](https://wiki.facepunch.com/gmod/IconEditor:Refresh).

**Arguments:**
- `ent` (Entity) — The entity being rendered within the model panel.

[wiki](https://wiki.facepunch.com/gmod/IconEditor:FillAnimations)

---

### IconEditor:FullFrontalLayout · Client
`IconEditor:FullFrontalLayout()`

Applies the front view camera settings for the model in the [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel).

Called when a user clicks the `Front` (second) button (See the ).

[wiki](https://wiki.facepunch.com/gmod/IconEditor:FullFrontalLayout)

---

### IconEditor:OriginLayout · Client
`IconEditor:OriginLayout()`

Places the camera at the origin (0,0,0), relative to the entity, in the [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel).

Called when a user clicks the `Center` (fifth) button (See the ).

[wiki](https://wiki.facepunch.com/gmod/IconEditor:OriginLayout)

---

### IconEditor:Refresh · Client
`IconEditor:Refresh()`

Updates the internal [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel) and [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon). 

This should be called immediately after setting the SpawnIcon with [IconEditor:SetIcon](https://wiki.facepunch.com/gmod/IconEditor:SetIcon).

[wiki](https://wiki.facepunch.com/gmod/IconEditor:Refresh)

---

### IconEditor:RenderIcon · Client
`IconEditor:RenderIcon()`

Re-renders the [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon).

Called when a user clicks the `RENDER` button, this retrieves the render data from the internal [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel) and passes it as a table to [Panel:RebuildSpawnIconEx](https://wiki.facepunch.com/gmod/Panel:RebuildSpawnIconEx).

[wiki](https://wiki.facepunch.com/gmod/IconEditor:RenderIcon)

---

### IconEditor:RightLayout · Client
`IconEditor:RightLayout()`

Applies the right side view camera settings for the model in the [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel).

Called when a user clicks the `Right` (fourth) button (See the ). (Note: The icon for this points left.)

[wiki](https://wiki.facepunch.com/gmod/IconEditor:RightLayout)

---

### IconEditor:SetDefaultLighting · Client · `INTERNAL`
`IconEditor:SetDefaultLighting()`

Sets up the default ambient and directional lighting for the [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel). Called by [IconEditor:Refresh](https://wiki.facepunch.com/gmod/IconEditor:Refresh).

[wiki](https://wiki.facepunch.com/gmod/IconEditor:SetDefaultLighting)

---

### IconEditor:SetFromEntity · Client
`IconEditor:SetFromEntity(ent: Entity)`

Sets the editor's model and icon from an entity. Alternative to [IconEditor:SetIcon](https://wiki.facepunch.com/gmod/IconEditor:SetIcon), with uses a [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon).

You do not need to call [IconEditor:Refresh](https://wiki.facepunch.com/gmod/IconEditor:Refresh) after this.

**Arguments:**
- `ent` (Entity) — The entity to retrieve the model and skin from.

[wiki](https://wiki.facepunch.com/gmod/IconEditor:SetFromEntity)

---

### IconEditor:SetIcon · Client
`IconEditor:SetIcon(icon: Panel)`

Sets the [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon) to modify. You should call [Panel:Refresh](https://wiki.facepunch.com/gmod/Panel:Refresh) immediately after this, as the user will not be able to make changes to the icon beforehand.

**Arguments:**
- `icon` (Panel) — The SpawnIcon object to be modified.

[wiki](https://wiki.facepunch.com/gmod/IconEditor:SetIcon)

---

### IconEditor:UpdateEntity · Client · `INTERNAL`
`IconEditor:UpdateEntity(ent: Entity)`

Updates the entity being rendered in the internal [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel). Called by the model panel's [DModelPanel:LayoutEntity](https://wiki.facepunch.com/gmod/DModelPanel:LayoutEntity) method.

**Arguments:**
- `ent` (Entity) — The entity being rendered within the model panel.

[wiki](https://wiki.facepunch.com/gmod/IconEditor:UpdateEntity)
