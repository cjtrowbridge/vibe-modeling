import bpy
import os

infile = r"C:\Users\CJ\Documents\GitHub\vibe-modeling\output\gigachad_xavier_void\gigachad 2.stl"
outfile = r"C:\Users\CJ\Documents\GitHub\vibe-modeling\output\gigachad_xavier_void\gigachad_voxel_1p0.stl"

bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_mesh.stl(filepath=infile)
obj = bpy.context.selected_objects[0]
bpy.context.view_layer.objects.active = obj
obj.select_set(True)

bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
mod = obj.modifiers.new(name="VoxelRemesh", type='REMESH')
mod.mode = 'VOXEL'
mod.voxel_size = 1.0
if hasattr(mod, 'use_remove_disconnected'):
    mod.use_remove_disconnected = False
bpy.ops.object.modifier_apply(modifier=mod.name)

bpy.ops.object.mode_set(mode='EDIT')
bpy.ops.mesh.select_all(action='SELECT')
bpy.ops.mesh.normals_make_consistent(inside=False)
bpy.ops.object.mode_set(mode='OBJECT')

bpy.ops.export_mesh.stl(filepath=outfile, use_selection=True)
print('WROTE', outfile)
