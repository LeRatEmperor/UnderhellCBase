#!/usr/bin/env python3
"""
Lua simulation of the CUH stat cache pipeline to find the sensitivity bug.

This simulates:
1. InitStatCache (only caches topLevel, NOT Sensitivity)
2. SetStat (cache + eager write)
3. RestoreStat (only restores if origin is NOT nil)
4. ApplyAttachments (Step 1: RestoreStat all, Step 5: Attach equipped)
5. The scope attachment's Attach/Detach

The bug: when scope is deselected, Sensitivity stays at 0.2 because:
- Sensitivity is NOT in topLevel, so origin is never cached (nil)
- RestoreStat checks 'if origin ~= nil' and SKIPS nil origins
- The stale 0.2 persists in both _statCache and self.Sensitivity
- ScopeTexture also persists (Detach never called, Step 1 doesn't clear it)
"""

# Simulate the weapon table
class Weapon:
    def __init__(self):
        self._statCache = {}
        self._statOrigins = {}
        self.Sensitivity = None  # nil
        self.ScopeTexture = None
        self.ScopeFov = None
        
    def init_stat_cache(self):
        """Simulate InitStatCache — only caches topLevel (NOT Sensitivity)."""
        topLevel = ["ZoomFov", "IronSightTime", "MoveSpeed"]
        for key in topLevel:
            if getattr(self, key, None) is not None:
                self._statCache[key] = getattr(self, key)
                self._statOrigins[key] = getattr(self, key)
        # IronSightsPos/Ang cached separately
        # NOTE: Sensitivity is NOT cached!
        
    def set_stat(self, path, value):
        """Simulate SetStat — cache + eager write."""
        self._statCache[path] = value
        setattr(self, path, value)  # eager write
        
    def restore_stat(self, path):
        """Simulate RestoreStat — only restores if origin is NOT nil."""
        origin = self._statOrigins.get(path)
        if origin is not None:
            self.set_stat(path, origin)
        # If origin is nil, does NOTHING!

    def apply_attachments(self, equipped_scope=None):
        """Simulate ApplyAttachments."""
        # Step 1: Restore ALL cached stats
        for path in list(self._statCache.keys()):
            self.restore_stat(path)
        
        # Step 5: Apply equipped attachments
        if equipped_scope:
            # Apply WeaponTable stats
            self.set_stat("Sensitivity", 0.2)  # from WeaponTable
            self.set_stat("ScopeFov", 7)
            # Call Attach()
            self.ScopeTexture = "kate_rt_scope_35"
            self.ScopeFov = 7


def test_scenario():
    print("=== Scenario: Attach scope, then deselect it ===\n")
    
    wep = Weapon()
    wep.init_stat_cache()
    
    print(f"Initial: Sensitivity={wep.Sensitivity}, ScopeTexture={wep.ScopeTexture}")
    print(f"Stat cache: {wep._statCache}")
    print(f"Stat origins: {wep._statOrigins}")
    print()
    
    # Attach scope
    print("--- Attach scope ---")
    wep.apply_attachments(equipped_scope=True)
    print(f"After attach: Sensitivity={wep.Sensitivity}, ScopeTexture={wep.ScopeTexture}")
    print(f"Stat cache: {wep._statCache}")
    print()
    
    # Deselect scope (set to None/0)
    print("--- Deselect scope (set to 0) ---")
    wep.apply_attachments(equipped_scope=False)
    print(f"After deselect: Sensitivity={wep.Sensitivity}, ScopeTexture={wep.ScopeTexture}")
    print(f"Stat cache: {wep._statCache}")
    print()
    
    # Check the bug
    if wep.Sensitivity is not None:
        print(f"BUG CONFIRMED: Sensitivity is still {wep.Sensitivity} after deselect!")
        print(f"  Root cause: RestoreStat skips nil origins")
        print(f"  _statOrigins['Sensitivity'] = {wep._statOrigins.get('Sensitivity')}")
        print(f"  _statCache['Sensitivity'] = {wep._statCache.get('Sensitivity')}")
        print(f"  ScopeTexture still set: {wep.ScopeTexture} (Detach never called!)")
    else:
        print("No bug — sensitivity properly cleared")
    
    print("\n--- Testing fix: purge BEFORE ApplyAttachments ---")
    
    # Reset
    wep2 = Weapon()
    wep2.init_stat_cache()
    wep2.apply_attachments(equipped_scope=True)
    print(f"After attach: Sensitivity={wep2.Sensitivity}")
    
    # Apply fix: purge Sensitivity BEFORE calling ApplyAttachments
    print("Applying fix: purge Sensitivity before ApplyAttachments")
    wep2._statCache.pop("Sensitivity", None)
    wep2._statOrigins.pop("Sensitivity", None)
    wep2.Sensitivity = None
    wep2.ScopeTexture = None  # also clear this since Detach never runs
    
    wep2.apply_attachments(equipped_scope=False)
    print(f"After deselect with fix: Sensitivity={wep2.Sensitivity}")
    
    if wep2.Sensitivity is None:
        print("FIX WORKS: Sensitivity properly cleared!")
    else:
        print(f"FIX FAILED: Sensitivity is still {wep2.Sensitivity}")


if __name__ == "__main__":
    test_scenario()
