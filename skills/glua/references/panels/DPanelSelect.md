# DPanelSelect

**Realm:** Client  ·  **Members:** 4  ·  **Inherits:** `DPanelList`  ·  `DEPRECATED`

A base panel for things like [DModelSelect](https://wiki.facepunch.com/gmod/DModelSelect).
		Basically, a list of panels that can be selected.
		Selected panel can be retrieved and has visual indication of being selected.

[wiki page](https://wiki.facepunch.com/gmod/DPanelSelect)

### DPanelSelect:AddPanel · Client · `hook` · `DEPRECATED`
`DPanelSelect:AddPanel(pnl: Panel, conVars: table = nil)`

Adds a panel to be selectable.

**Arguments:**
- `pnl` (Panel) — The panel to add.
- `conVars` (table, default `nil`) — ConVars to set when this panel is selected.

[wiki](https://wiki.facepunch.com/gmod/DPanelSelect:AddPanel)

---

### DPanelSelect:FindBestActive · Client · `hook` · `DEPRECATED` · `INTERNAL`
`DPanelSelect:FindBestActive()`

Used internally by [DPanelSelect:AddPanel](https://wiki.facepunch.com/gmod/DPanelSelect:AddPanel) to select the best default selected panel based on player's convars.

[wiki](https://wiki.facepunch.com/gmod/DPanelSelect:FindBestActive)

---

### DPanelSelect:OnActivePanelChanged · Client · `hook` · `DEPRECATED`
`DPanelSelect:OnActivePanelChanged(oldPnl: Panel, newPnl: Panel)`

Called when the selected panel changes.

**Arguments:**
- `oldPnl` (Panel) — Old selected panel.
- `newPnl` (Panel) — New selected panel.

[wiki](https://wiki.facepunch.com/gmod/DPanelSelect:OnActivePanelChanged)

---

### DPanelSelect:SelectPanel · Client · `hook` · `DEPRECATED`
`DPanelSelect:SelectPanel(pnl: Panel)`

Selects a given panel.

**Arguments:**
- `pnl` (Panel) — Panel to select.

[wiki](https://wiki.facepunch.com/gmod/DPanelSelect:SelectPanel)
