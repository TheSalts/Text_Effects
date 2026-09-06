26.2-snapshot-126.2
Profiling the game with Tracy (launching with --tracy) now includes GPU timings.

26.2-snapshot-126.2
Rendering now uses a reversed depth buffer, which helps with Z-fighting on most hardware.

26.1-pre-126.1
Removed the core/rendertype_translucent_moving_block shaders in favor of core/block.

26.1-snapshot-726.1
The block.vsh and terrain.vsh shaders no longer receive the Normal vertex attribute.

26.1-snapshot-626.1
The core/rendertype_item_entity_translucent_cull shaders have been removed in favor of core/entity.

26.1-snapshot-626.1
The core/rendertype_entity_alpha and core/rendertype_entity_decal shaders have been replaced by a DISSOLVE flag implemented by core/entity.

26.1-snapshot-626.1
Rendering of items (in UI and in the world) has been split from core/entity into new core/item shaders.

26.1-snapshot-126.1
The lightmap.fsh shader was significantly modified. The LightmapInfo uniform now has two new fields: BlockLightTint and NightVisionColor. The AmbientLightFactor field was removed. The DarkenWorldFactor was renamed to BossOverlayWorldDarkeningFactor.

26.1-snapshot-126.1
Text and items rendered in UI now use a separate 1x1 white lightmap texture, so the lightmap shader does not always have to keep the 15, 15 pixel purely white.
