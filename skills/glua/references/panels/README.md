# Panels (VGUI)

This category covers VGUI / Derma panels — the client-only UI widgets you build menus, HUDs, and tool screens from (DFrame, DButton, DPanel, DScrollPanel, DTextEntry, DListView, DTree, and friends). Most panels are created with `vgui.Create("ClassName", parent)` and then configured through **colon methods** on the returned object (`pnl:SetText(...)`, `pnl:SetSize(...)`, `pnl:Dock(...)`). Behavior is wired up by **overriding hook-style methods** you assign yourself: layout via `PerformLayout`, custom rendering via `Paint`/`PaintOver`, and events via `DoClick`, `OnSelect`, `OnChange`, `OnRowSelected`, etc. Images and icons usually take a material/texture path string (`pnl:SetImage("icon16/foo.png")` or a `Material()` handle), not a colon call.

To choose a unit: start from the base container (`DFrame` for a window, `DPanel`/`DScrollPanel` for a region), pick the input/display widget that matches your data (`DButton`, `DLabel`, `DTextEntry`, `DComboBox`, `DCheckBoxLabel`, `DNumSlider`), and reach for the structured views (`DListView`, `DTree`, `DPropertySheet`) when you need rows, hierarchies, or tabs. The "Members" count in each row hints at how much surface a panel exposes; the per-unit file lists the exact methods and the hooks you are expected to override.

## Most-used
- [DFrame](DFrame.md) — the standard movable/closable window; parent for nearly every custom menu.
- [DPanel](DPanel.md) — plain rectangular container, the default thing you parent other elements to and Paint over.
- [DScrollPanel](DScrollPanel.md) — DPanel with a vertical scrollbar; use it whenever content can overflow.
- [DButton](DButton.md) — standard clickable button; wire up `DoClick`.
- [DLabel](DLabel.md) — standard text label; the most common display element.
- [DTextEntry](DTextEntry.md) — single/multi-line text input; the widest API in this category.
- [DComboBox](DComboBox.md) — dropdown of selectable values; read selection via `OnSelect`.
- [DCheckBoxLabel](DCheckBoxLabel.md) — a checkbox paired with a label, with built-in ConVar support.
- [DNumSlider](DNumSlider.md) — slider plus numeric entry for picking a value in a range.
- [DListView](DListView.md) — multi-column row/data view; the go-to for tabular lists.
- [DTree](DTree.md) — collapsible tree view for hierarchical data (DTree_Node holds each node).
- [DPropertySheet](DPropertySheet.md) — tabbed container for organizing multiple sub-panels.
- [DModelPanel](DModelPanel.md) — renders a 3D model onto a 2D panel for previews.
- [DImage](DImage.md) — robust image/material display panel.
- [DMenu](DMenu.md) — right-click/context menu with submenus, icons, and ConVar options.

## Realm notes
- Panels are **CLIENT-only** (a few are also available in the **Menu** realm, shown as "Client, Menu" in the table). They do not exist serverside — never `vgui.Create` on the server.
- Panel rendering inside `Paint` relies on `surface.*`, `draw.*`, and (for 3D panels like DModelPanel) `cam.*`/`render.*`, all of which are likewise client-only.
- "Shared" in the Realm column here means the class is registered/available across realms for lookup, but actual panel instances are still constructed and drawn clientside.
- Image and icon members take a **material/texture path string** (e.g. `"icon16/foo.png"`) or a `Material()` handle — they are not network or sound calls and carry no server cost.
- Networking a UI action to the server is done with shared `net.*` (or `RunConsoleCommand`); the panel itself stays clientside.

**Open the per-unit file for exact signatures — do not guess.**

| Unit | Realm | Members | Description |
|---|---|---|---|
| [AchievementIcon](AchievementIcon.md) | Shared | 0 | Used to show an icon for any of the Garry's Mod Steam achievements. · [wiki](https://wiki.facepunch.com/gmod/AchievementIcon) |
| [AvatarImage](AvatarImage.md) | Shared | 0 | Used to show a player's Steam avatar. · [wiki](https://wiki.facepunch.com/gmod/AvatarImage) |
| [Awesomium](Awesomium.md) | Shared | 0 | Base panel for elements using the Awesomium UI engine. · [wiki](https://wiki.facepunch.com/gmod/Awesomium) |
| [Button](Button.md) | Shared | 0 | Creates a button that players can click on. · [wiki](https://wiki.facepunch.com/gmod/Button) |
| [CheckButton](CheckButton.md) | Shared | 0 | Engine checkbox · [wiki](https://wiki.facepunch.com/gmod/CheckButton) |
| [ContentHeader](ContentHeader.md) | Client | 2 | The ContentHeader is used internally by the Spawnmenu and only use this if you know what you're doing because you can break a few things wi… · [wiki](https://wiki.facepunch.com/gmod/ContentHeader) |
| [ContentIcon](ContentIcon.md) | Client | 12 | The spawn icon used for SWEPs and other SENTs, commonly featured as part of the spawn menu. · [wiki](https://wiki.facepunch.com/gmod/ContentIcon) |
| [ContentSidebar](ContentSidebar.md) | Client | 3 | The ContentSidebar is internally used by the spawnmenu and manages things like the Spawnmenu Toolbar. · [wiki](https://wiki.facepunch.com/gmod/ContentSidebar) |
| [ContentSidebarToolbox](ContentSidebarToolbox.md) | Shared | 0 | The ContentSidebarToolbox is internally used by the ContentSidebar and is used to change the icon of a category. · [wiki](https://wiki.facepunch.com/gmod/ContentSidebarToolbox) |
| [ContextBase](ContextBase.md) | Client | 4 | A base for all context menu panels ( The ones used for tool options in sandbox ) · [wiki](https://wiki.facepunch.com/gmod/ContextBase) |
| [ControlPanel](ControlPanel.md) | Client | 10 | Used by the context menu in sandbox. · [wiki](https://wiki.facepunch.com/gmod/ControlPanel) |
| [ControlPresets](ControlPresets.md) | Client | 13 | A preset manager, found at the top of almost every default tool's C-menu. · [wiki](https://wiki.facepunch.com/gmod/ControlPresets) |
| [CtrlListBox](CtrlListBox.md) | Shared | 0 | A DComboBox based dropdown menu with build in easy ConVar support. · [wiki](https://wiki.facepunch.com/gmod/CtrlListBox) |
| [CtrlNumPad](CtrlNumPad.md) | Client | 6 | CtrlNumPad is a VGUI element designed primarily for SpawnMenu and ControlPanel. · [wiki](https://wiki.facepunch.com/gmod/CtrlNumPad) |
| [DAdjustableModelPanel](DAdjustableModelPanel.md) | Client | 6 | A derivative of the DModelPanel in which the user may modify the perspective of the model with their mouse and keyboard by clicking and dra… · [wiki](https://wiki.facepunch.com/gmod/DAdjustableModelPanel) |
| [DAlphaBar](DAlphaBar.md) | Client, Menu | 5 | A bar to select the opacity (alpha level) of a color. · [wiki](https://wiki.facepunch.com/gmod/DAlphaBar) |
| [DBinder](DBinder.md) | Client | 6 | Input which can bind a command to a key. · [wiki](https://wiki.facepunch.com/gmod/DBinder) |
| [DBubbleContainer](DBubbleContainer.md) | Client | 3 | A transparent gray speech bubble panel made up of a rounded box and point coming from the bottom. · [wiki](https://wiki.facepunch.com/gmod/DBubbleContainer) |
| [DButton](DButton.md) | Client, Menu | 8 | A standard Derma button. · [wiki](https://wiki.facepunch.com/gmod/DButton) |
| [DCategoryHeader](DCategoryHeader.md) | Shared | 0 | Used by DCollapsibleCategory · [wiki](https://wiki.facepunch.com/gmod/DCategoryHeader) |
| [DCategoryList](DCategoryList.md) | Client, Menu | 3 | A host for multiple DCollapsibleCategory panels. · [wiki](https://wiki.facepunch.com/gmod/DCategoryList) |
| [DCheckBox](DCheckBox.md) | Client, Menu | 7 | The DCheckBox is a checkbox. · [wiki](https://wiki.facepunch.com/gmod/DCheckBox) |
| [DCheckBoxLabel](DCheckBoxLabel.md) | Client, Menu | 13 | The DCheckBoxLabel is a DCheckBox with a DLabel next to it. · [wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel) |
| [DCollapsibleCategory](DCollapsibleCategory.md) | Client, Menu | 24 | The collapsible category allows you to create numerous sections of controls, and have the ability to contract/expand them. · [wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory) |
| [DColorButton](DColorButton.md) | Client, Menu | 8 | Colorful buttons. · [wiki](https://wiki.facepunch.com/gmod/DColorButton) |
| [DColorCombo](DColorCombo.md) | Client | 5 | The DColorCombo allows the user to choose color, without alpha, using DColorMixer or DColorPalette in a tabbed view. · [wiki](https://wiki.facepunch.com/gmod/DColorCombo) |
| [DColorCube](DColorCube.md) | Client, Menu | 13 | The DColorCube allows a user to select saturation and value but not hue. · [wiki](https://wiki.facepunch.com/gmod/DColorCube) |
| [DColorMixer](DColorMixer.md) | Client, Menu | 27 | A standard Derma color mixer · [wiki](https://wiki.facepunch.com/gmod/DColorMixer) |
| [DColorPalette](DColorPalette.md) | Client, Menu | 23 | The DColorPalette allows the player to select a color from a list of given colors. · [wiki](https://wiki.facepunch.com/gmod/DColorPalette) |
| [DColumnSheet](DColumnSheet.md) | Client, Menu | 4 | Similar to DPropertySheet, but with tabs on the left. · [wiki](https://wiki.facepunch.com/gmod/DColumnSheet) |
| [DComboBox](DComboBox.md) | Client, Menu | 20 | A field with multiple selectable values. · [wiki](https://wiki.facepunch.com/gmod/DComboBox) |
| [DDragBase](DDragBase.md) | Client, Menu | 13 | A VGUI base panel providing drag/drop functionality. · [wiki](https://wiki.facepunch.com/gmod/DDragBase) |
| [DDrawer](DDrawer.md) | Client, Menu | 7 | A simple Derma Drawer · [wiki](https://wiki.facepunch.com/gmod/DDrawer) |
| [DEntityProperties](DEntityProperties.md) | Client | 5 | A panel used by the Editable Entities system. · [wiki](https://wiki.facepunch.com/gmod/DEntityProperties) |
| [DExpandButton](DExpandButton.md) | Client, Menu | 2 | The little "+" button used by DProperties and DTree_Node. · [wiki](https://wiki.facepunch.com/gmod/DExpandButton) |
| [DFileBrowser](DFileBrowser.md) | Client | 26 | A tree and list-based file browser. · [wiki](https://wiki.facepunch.com/gmod/DFileBrowser) |
| [DForm](DForm.md) | Client, Menu | 18 | An easy form with functions to quickly add form elements · [wiki](https://wiki.facepunch.com/gmod/DForm) |
| [DFrame](DFrame.md) | Client, Menu | 26 | The DFrame is the moma of basically all VGUI elements. · [wiki](https://wiki.facepunch.com/gmod/DFrame) |
| [DGrid](DGrid.md) | Client, Menu | 10 | A really simple grid layout panel. · [wiki](https://wiki.facepunch.com/gmod/DGrid) |
| [DHorizontalDivider](DHorizontalDivider.md) | Client | 19 | Creates an invisible vertical divider between two GUI elements. · [wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider) |
| [DHorizontalScroller](DHorizontalScroller.md) | Client, Menu | 11 | A very basic horizontal scrollable panel, similar to DScrollPanel. · [wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller) |
| [DHScrollBar](DHScrollBar.md) | Client, Menu | 10 | A generic horizontal scrollbar. · [wiki](https://wiki.facepunch.com/gmod/DHScrollBar) |
| [DHTML](DHTML.md) | Client, Menu | 7 | The DHTML control wraps the internal web engine, supports calling Javascript functions from Lua, as well as running Lua from within the HTM… · [wiki](https://wiki.facepunch.com/gmod/DHTML) |
| [DHTMLControls](DHTMLControls.md) | Client, Menu | 6 | An element providing navigation controls for a DHTML window. · [wiki](https://wiki.facepunch.com/gmod/DHTMLControls) |
| [DIconBrowser](DIconBrowser.md) | Client, Menu | 10 | Simply a DIconLayout which automatically displays all of the Silkicons. · [wiki](https://wiki.facepunch.com/gmod/DIconBrowser) |
| [DIconLayout](DIconLayout.md) | Client, Menu | 18 | DIconLayout is what replaced DPanelList in Garry's Mod 13. · [wiki](https://wiki.facepunch.com/gmod/DIconLayout) |
| [DImage](DImage.md) | Client, Menu | 18 | DImage is an advanced, more robust version of the Material panel. · [wiki](https://wiki.facepunch.com/gmod/DImage) |
| [DImageButton](DImageButton.md) | Client, Menu | 13 | An image button. · [wiki](https://wiki.facepunch.com/gmod/DImageButton) |
| [DKillIcon](DKillIcon.md) | Client | 2 | Uses the killicon to persistently draw a killicon. · [wiki](https://wiki.facepunch.com/gmod/DKillIcon) |
| [DLabel](DLabel.md) | Client, Menu | 42 | A standard Derma text label. · [wiki](https://wiki.facepunch.com/gmod/DLabel) |
| [DLabelEditable](DLabelEditable.md) | Client, Menu | 4 | An editable DLabel, double click on it to edit. · [wiki](https://wiki.facepunch.com/gmod/DLabelEditable) |
| [DLabelURL](DLabelURL.md) | Client, Menu | 9 | Underlined link label without a DoClick function. · [wiki](https://wiki.facepunch.com/gmod/DLabelURL) |
| [DListBox](DListBox.md) | Client, Menu | 7 | A simple list box with optional multi-select. · [wiki](https://wiki.facepunch.com/gmod/DListBox) |
| [DListBoxItem](DListBoxItem.md) | Client | 3 |  · [wiki](https://wiki.facepunch.com/gmod/DListBoxItem) |
| [DListLayout](DListLayout.md) | Shared | 0 | A vertical list of panels that optionally allows child elements to be rearranged with the mouse cursor. · [wiki](https://wiki.facepunch.com/gmod/DListLayout) |
| [DListView](DListView.md) | Client, Menu | 36 | A data view with rows and columns. · [wiki](https://wiki.facepunch.com/gmod/DListView) |
| [DListView_Column](DListView_Column.md) | Client, Menu | 17 | A single column, used by DListView. · [wiki](https://wiki.facepunch.com/gmod/DListView_Column) |
| [DListView_ColumnPlain](DListView_ColumnPlain.md) | Shared | 0 |  · [wiki](https://wiki.facepunch.com/gmod/DListView_ColumnPlain) |
| [DListView_DraggerBar](DListView_DraggerBar.md) | Shared | 0 |  · [wiki](https://wiki.facepunch.com/gmod/DListView_DraggerBar) |
| [DListView_Line](DListView_Line.md) | Client, Menu | 17 | A panel used by DListView · [wiki](https://wiki.facepunch.com/gmod/DListView_Line) |
| [DListViewHeaderLabel](DListViewHeaderLabel.md) | Shared | 0 |  · [wiki](https://wiki.facepunch.com/gmod/DListViewHeaderLabel) |
| [DListViewLabel](DListViewLabel.md) | Shared | 0 |  · [wiki](https://wiki.facepunch.com/gmod/DListViewLabel) |
| [DListViewLine](DListViewLine.md) | Shared | 0 |  · [wiki](https://wiki.facepunch.com/gmod/DListViewLine) |
| [DMenu](DMenu.md) | Client, Menu | 27 | A simple menu with sub menu, icon and convar support. · [wiki](https://wiki.facepunch.com/gmod/DMenu) |
| [DMenuBar](DMenuBar.md) | Client, Menu | 9 | A simple menu bar. · [wiki](https://wiki.facepunch.com/gmod/DMenuBar) |
| [DMenuOption](DMenuOption.md) | Client, Menu | 12 | Internal subpanel that represents an option used by DMenu. · [wiki](https://wiki.facepunch.com/gmod/DMenuOption) |
| [DMenuOptionCVar](DMenuOptionCVar.md) | Client | 6 | An internal panel used by DMenu. · [wiki](https://wiki.facepunch.com/gmod/DMenuOptionCVar) |
| [DModelPanel](DModelPanel.md) | Client | 27 | DModelPanel is a VGUI element that projects a 3D model onto a 2D plane. · [wiki](https://wiki.facepunch.com/gmod/DModelPanel) |
| [DModelSelect](DModelSelect.md) | Client | 2 | A vertical list of models. · [wiki](https://wiki.facepunch.com/gmod/DModelSelect) |
| [DModelSelectMulti](DModelSelectMulti.md) | Client, Menu | 1 | A combination of DModelSelect and DPropertySheet. · [wiki](https://wiki.facepunch.com/gmod/DModelSelectMulti) |
| [DNotify](DNotify.md) | Client | 9 | A panel that fades its contents in and out once, like a notification. · [wiki](https://wiki.facepunch.com/gmod/DNotify) |
| [DNumberScratch](DNumberScratch.md) | Client, Menu | 27 | Choose a number from a number line, with zooming for precision. · [wiki](https://wiki.facepunch.com/gmod/DNumberScratch) |
| [DNumberWang](DNumberWang.md) | Client, Menu | 18 | DNumberWang is a VGUI element that allows you to input a numeric value using up and down arrows or direct entry. · [wiki](https://wiki.facepunch.com/gmod/DNumberWang) |
| [DNumPad](DNumPad.md) | Shared | 0 | GMod 12 style "number pad" panel used by tools for binding keys to tool actions. · [wiki](https://wiki.facepunch.com/gmod/DNumPad) |
| [DNumSlider](DNumSlider.md) | Client, Menu | 21 | The DNumSlider allows you to create a slider, allowing the user to slide it to set a value, or changing the value in the box. · [wiki](https://wiki.facepunch.com/gmod/DNumSlider) |
| [DPanel](DPanel.md) | Client, Menu | 13 | A simple rectangular box, commonly used for parenting other elements to. · [wiki](https://wiki.facepunch.com/gmod/DPanel) |
| [DPanelList](DPanelList.md) | Client, Menu | 12 | Displays elements in a horizontal or vertical list. · [wiki](https://wiki.facepunch.com/gmod/DPanelList) |
| [DPanelOverlay](DPanelOverlay.md) | Client, Menu | 6 | Adds curved corners. · [wiki](https://wiki.facepunch.com/gmod/DPanelOverlay) |
| [DPanelSelect](DPanelSelect.md) | Client | 4 | A base panel for things like DModelSelect. · [wiki](https://wiki.facepunch.com/gmod/DPanelSelect) |
| [DPanPanel](DPanPanel.md) | Client, Menu | 5 | A panel similar to DScrollPanel, but that allows the player to pan around, for example a zoomed in image within a small window. · [wiki](https://wiki.facepunch.com/gmod/DPanPanel) |
| [DProgress](DProgress.md) | Client, Menu | 2 | A progressbar, works with a fraction between 0 and 1 where 0 is 0% and 1 is 100%. · [wiki](https://wiki.facepunch.com/gmod/DProgress) |
| [DProperties](DProperties.md) | Client | 3 | A grid for editing the properties of something using names and values. · [wiki](https://wiki.facepunch.com/gmod/DProperties) |
| [DProperty_Boolean](DProperty_Boolean.md) | Shared | 0 | Checkbox control for the DProperties panel. · [wiki](https://wiki.facepunch.com/gmod/DProperty_Boolean) |
| [DProperty_Combo](DProperty_Combo.md) | Client | 4 | DComboBox control for a DProperties panel. · [wiki](https://wiki.facepunch.com/gmod/DProperty_Combo) |
| [DProperty_Entity](DProperty_Entity.md) | Shared | 0 | Entity picker control for the DProperties panel. · [wiki](https://wiki.facepunch.com/gmod/DProperty_Entity) |
| [DProperty_Float](DProperty_Float.md) | Client | 1 | Float control for the DProperties panel. · [wiki](https://wiki.facepunch.com/gmod/DProperty_Float) |
| [DProperty_Generic](DProperty_Generic.md) | Client | 4 | A base for other controls for DProperties. · [wiki](https://wiki.facepunch.com/gmod/DProperty_Generic) |
| [DProperty_Int](DProperty_Int.md) | Shared | 0 | Integer control for the DProperties panel. · [wiki](https://wiki.facepunch.com/gmod/DProperty_Int) |
| [DProperty_VectorColor](DProperty_VectorColor.md) | Client | 2 | Color picker control for a DProperties panel. · [wiki](https://wiki.facepunch.com/gmod/DProperty_VectorColor) |
| [DPropertySheet](DPropertySheet.md) | Client, Menu | 16 | A tab oriented control where you can create multiple tabs with items within. · [wiki](https://wiki.facepunch.com/gmod/DPropertySheet) |
| [DRGBPicker](DRGBPicker.md) | Client, Menu | 4 | DRGBPicker is an interactive panel which can be used to select a color hue. · [wiki](https://wiki.facepunch.com/gmod/DRGBPicker) |
| [DScrollBarGrip](DScrollBarGrip.md) | Shared | 0 | An internal panel used by DVScrollBar as the grip (middle) part of the scrollbar. · [wiki](https://wiki.facepunch.com/gmod/DScrollBarGrip) |
| [DScrollPanel](DScrollPanel.md) | Client, Menu | 10 | DScrollPanel is a VGUI Element similar to DPanel however it has a vertical scrollbar docked to the right which can be used to put more cont… · [wiki](https://wiki.facepunch.com/gmod/DScrollPanel) |
| [DShape](DShape.md) | Client | 6 | Draw a shape on a derma panel. · [wiki](https://wiki.facepunch.com/gmod/DShape) |
| [DSizeToContents](DSizeToContents.md) | Client, Menu | 4 | A helper panel that will automatically resize itself to fit all its children using Panel:SizeToChildren. · [wiki](https://wiki.facepunch.com/gmod/DSizeToContents) |
| [DSlider](DSlider.md) | Client, Menu | 30 | Creates a slider that can be moved along the X and/or Y axis · [wiki](https://wiki.facepunch.com/gmod/DSlider) |
| [DSprite](DSprite.md) | Client | 8 | A panel that draws a sprite on the player's HUD with the given IMaterial, Color and rotation. · [wiki](https://wiki.facepunch.com/gmod/DSprite) |
| [DTab](DTab.md) | Client, Menu | 7 | This element is created within and only used in the DPropertySheet file. · [wiki](https://wiki.facepunch.com/gmod/DTab) |
| [DTextEntry](DTextEntry.md) | Client, Menu | 49 | A form which may be used to display text the player is meant to select and copy or alternately allow them to enter some text of their own. · [wiki](https://wiki.facepunch.com/gmod/DTextEntry) |
| [DTileLayout](DTileLayout.md) | Client | 21 | Similarly to DIconLayout, this lays out panels in two dimensions as tiles. · [wiki](https://wiki.facepunch.com/gmod/DTileLayout) |
| [DTooltip](DTooltip.md) | Client, Menu | 5 | The panel used internally for tooltips. · [wiki](https://wiki.facepunch.com/gmod/DTooltip) |
| [DTree](DTree.md) | Client, Menu | 21 | A tree view element for Derma. · [wiki](https://wiki.facepunch.com/gmod/DTree) |
| [DTree_Node](DTree_Node.md) | Client, Menu | 75 | This panel is created whenever you add a node to a DTree. · [wiki](https://wiki.facepunch.com/gmod/DTree_Node) |
| [DTree_Node_Button](DTree_Node_Button.md) | Shared | 0 | Used by DTree_Node. · [wiki](https://wiki.facepunch.com/gmod/DTree_Node_Button) |
| [DVerticalDivider](DVerticalDivider.md) | Client | 22 | Vertical version of DHorizontalDivider. · [wiki](https://wiki.facepunch.com/gmod/DVerticalDivider) |
| [DVScrollBar](DVScrollBar.md) | Client, Menu | 10 | A generic vertical scrollbar, used in DScrollPanel. · [wiki](https://wiki.facepunch.com/gmod/DVScrollBar) |
| [EditablePanel](EditablePanel.md) | Shared | 0 | Base panel used by DFrame, this panel is needed so that elements such as the TextEntry can obtain focus. · [wiki](https://wiki.facepunch.com/gmod/EditablePanel) |
| [fingerposer](fingerposer.md) | Shared | 0 | A panel used by Sandbox's Finger Poser tool. · [wiki](https://wiki.facepunch.com/gmod/fingerposer) |
| [FingerVar](FingerVar.md) | Shared | 0 | A panel used by Sandbox's Finger Poser tool. · [wiki](https://wiki.facepunch.com/gmod/FingerVar) |
| [Frame](Frame.md) | Shared | 0 | A window that in which you can place just about every other component and even another frame. · [wiki](https://wiki.facepunch.com/gmod/Frame) |
| [HTML](HTML.md) | Client, Menu | 9 | The HTML control can be used to display web pages just like an internet browser. · [wiki](https://wiki.facepunch.com/gmod/HTML) |
| [IconEditor](IconEditor.md) | Client | 12 | An icon editor that permits a user to modify a SpawnIcon and re-render it. · [wiki](https://wiki.facepunch.com/gmod/IconEditor) |
| [ImageCheckBox](ImageCheckBox.md) | Client | 4 | A checkbox panel similar to DCheckBox and DImageButton with customizable checked state image. · [wiki](https://wiki.facepunch.com/gmod/ImageCheckBox) |
| [Label](Label.md) | Shared | 0 | A basic label or "single line text area" that is non-editable. · [wiki](https://wiki.facepunch.com/gmod/Label) |
| [Material](Material.md) | Client | 2 | Material is a VGUI element that renders a VMT material. · [wiki](https://wiki.facepunch.com/gmod/Material) |
| [MatSelect](MatSelect.md) | Client | 13 | The panel used by Material & Lamp Sandbox tools for texture selection. · [wiki](https://wiki.facepunch.com/gmod/MatSelect) |
| [ModelImage](ModelImage.md) | Shared | 0 | Panel used to display models, used by SpawnIcon. · [wiki](https://wiki.facepunch.com/gmod/ModelImage) |
| [PanelList](PanelList.md) | Shared | 0 | A panel list with a custom vertical scroll bar that doesn't have up/down buttons and has a momentum to scrolling. · [wiki](https://wiki.facepunch.com/gmod/PanelList) |
| [PresetEditor](PresetEditor.md) | Shared | 0 | A preset editor, which can be opened by ControlPresets. · [wiki](https://wiki.facepunch.com/gmod/PresetEditor) |
| [PropSelect](PropSelect.md) | Client | 8 | Used in Sandbox tools to allow the player to select models out of a list. · [wiki](https://wiki.facepunch.com/gmod/PropSelect) |
| [RadioButton](RadioButton.md) | Shared | 0 | Currently there are no functions to retrieve checked state of a Radio Button, and their visuals are seemingly broken. · [wiki](https://wiki.facepunch.com/gmod/RadioButton) |
| [RichText](RichText.md) | Shared | 0 | A very versatile text display element that's used to power the default chat and console. · [wiki](https://wiki.facepunch.com/gmod/RichText) |
| [SlideBar](SlideBar.md) | Shared | 0 | Used as scroll bar for PanelList · [wiki](https://wiki.facepunch.com/gmod/SlideBar) |
| [Slider](Slider.md) | Shared | 0 | A simple slider featuring an numeric display. · [wiki](https://wiki.facepunch.com/gmod/Slider) |
| [SpawnIcon](SpawnIcon.md) | Client | 7 | A "spawn icon" displays an image for the given model path. · [wiki](https://wiki.facepunch.com/gmod/SpawnIcon) |
| [SpawnmenuContentPanel](SpawnmenuContentPanel.md) | Client | 4 | The default SpawnmenuContentPanel · [wiki](https://wiki.facepunch.com/gmod/SpawnmenuContentPanel) |
| [TextEntry](TextEntry.md) | Client, Menu | 2 | Basic text input field. · [wiki](https://wiki.facepunch.com/gmod/TextEntry) |
| [TGAImage](TGAImage.md) | Shared | 0 | A panel capable of loading `.tga` images. · [wiki](https://wiki.facepunch.com/gmod/TGAImage) |
| [UGCPublishWindow](UGCPublishWindow.md) | Menu | 8 | A window that is used to publish dupes and saves · [wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow) |
| [URLLabel](URLLabel.md) | Shared | 0 | A panel similar to Label, but can be clicked to open a URL in the Steam Overlay, and appears with an underline. · [wiki](https://wiki.facepunch.com/gmod/URLLabel) |
