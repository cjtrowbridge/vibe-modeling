import bpy
import os

INFILE = r"C:\Users\CJ\Documents\GitHub\vibe-modeling\output\gigachad_xavier_void\gigachad 2.stl"
OUTDIR = r"C:\Users\CJ\Documents\GitHub\vibe-modeling\output\gigachad_xavier_void"
VOXELS = [2.0, 1.5, 1.0]


def stl_import(path):
    if hasattr(bpy.ops.wm, 'stl_import'):
        return bpy.ops.wm.stl_import(filepath=path)
    return bpy.ops.import_mesh.stl(filepath=path)


def stl_export(path):
    if hasattr(bpy.ops.wm, 'stl_export'):
        return bpy.ops.wm.stl_export(filepath=path, export_selected_objects=True)
    return bpy.ops.export_mesh.stl(filepath=path, use_selection=True)

for voxel in VOXELS:
    bpy.ops.wm.read_factory_settings(use_empty=True)
    stl_import(INFILE)
    obj = bpy.context.selected_objects[0]
    bpy.context.view_layer.objects.active = obj
    obj.select_set(True)

    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    remesh = obj.modifiers.new(name='VoxelRemesh', type='REMESH')
    remesh.mode = 'VOXEL'
    remesh.voxel_size = voxel
    if hasattr(remesh, 'use_remove_disconnected'):
        remesh.use_remove_disconnected = False
    bpy.ops.object.modifier_apply(modifier=remesh.name)

    bpy.ops.object.mode_set(mode='EDIT')
    bpy.ops.mesh.select_all(action='SELECT')
    bpy.ops.mesh.normals_make_consistent(inside=False)
    bpy.ops.object.mode_set(mode='OBJECT')

    out_name = f"gigachad_voxel_{str(voxel).replace('.', 'p')}.stl"
    out_path = os.path.join(OUTDIR, out_name)
    stl_export(out_path)
    poly_count = len(obj.data.polygons)
    vert_count = len(obj.data.vertices)
    print(f"WROTE {out_name} polys={poly_count} verts={vert_count}")
