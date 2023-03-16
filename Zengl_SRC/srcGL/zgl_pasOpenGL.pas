(*
 *  Copyright (c) 2022 Serge - SSW
 *
 *  This software is provided 'as-is', without any express or
 *  implied warranty. In no event will the authors be held
 *  liable for any damages arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute
 *  it freely, subject to the following restrictions:
 *
 *  1. The origin of this software must not be misrepresented;
 *     you must not claim that you wrote the original software.
 *     If you use this software in a product, an acknowledgment
 *     in the product documentation would be appreciated but
 *     is not required.
 *
 *  2. Altered source versions must be plainly marked as such,
 *     and must not be misrepresented as being the original software.
 *
 *  3. This notice may not be removed or altered from any
 *     source distribution.
 *)

unit zgl_pasOpenGL;
{$I zgl_config.cfg}
{$I GLdefine.cfg}

{$IfDef UNIX}
  {$DEFINE stdcall := cdecl}
{$EndIf}
{$IFDEF MACOSX}
  {$LINKFRAMEWORK OpenGL}
{$ENDIF}

interface

uses
  {$IFDEF LINUX}
  zgl_glx_wgl,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IfDef FPC}
  Math,
  {$EndIf}
  zgl_gltypeconst;

type
  GLDEBUGPROC = procedure(source: GLenum; _type: GLenum; id: GLuint; severity: GLenum; length: GLsizei; const _message: PGLchar; userParam: PGLvoid); stdcall;
  GLDEBUGPROCARB = procedure(source: GLenum; _type: GLenum; id: GLuint; severity: GLenum; length: GLsizei; const _message: PGLchar; userParam: PGLvoid); stdcall;
  GLVULKANPROCNV = procedure; stdcall;

  // glext
  GLDEBUGPROCAMD = procedure (id: GLuint; category: GLenum; severity: GLenum; length: GLsizei; message: PGLchar; userParam: pointer); stdcall;

var
  GLVersion: array[0..1] of Integer;
  GLUVersion: Integer;
  // версия выбираемая пользователем.
  use_glMinorVer, use_glMajorVer: Integer;
  GL_VERSION_1_0: Boolean;
  GL_VERSION_1_1: Boolean;
  GL_VERSION_1_2: Boolean;
  GL_VERSION_1_3: Boolean;
  GL_VERSION_1_4: Boolean;
  GL_VERSION_1_5: Boolean;
  GL_VERSION_2_0: Boolean;
  GL_VERSION_2_1: Boolean;
  GL_VERSION_3_0: Boolean;
  GL_VERSION_3_1: Boolean;
  GL_VERSION_3_2: Boolean;
  GL_VERSION_3_3: Boolean;
  GL_VERSION_4_0: Boolean;
  GL_VERSION_4_1: Boolean;
  GL_VERSION_4_2: Boolean;
  GL_VERSION_4_3: Boolean;
  GL_VERSION_4_4: Boolean;
  GL_VERSION_4_5: Boolean;
  GL_VERSION_4_6: Boolean;

  // ZenGL ++
  GL_SGIS_generate_mipmap: Boolean;
  GL_EXT_texture_compression_s3tc: Boolean;
  GL_EXT_texture_filter_anisotropic: Boolean;
  GL_EXT_blend_func_separate: Boolean;

  // перечисление всех дефайнов. Большая часть не используется по умолчанию, даже в Кроносе.
  {$If defined(USE_GLCORE) or defined(USE_GLEXT)}
  GL_ARB_ES2_compatibility: Boolean;
  GL_ARB_ES3_1_compatibility: Boolean;
  GL_ARB_ES3_2_compatibility: Boolean;
  GL_ARB_ES3_compatibility: Boolean;
  GL_ARB_arrays_of_arrays: Boolean;
  GL_ARB_base_instance: Boolean;
  GL_ARB_bindless_texture: Boolean;
  GL_ARB_blend_func_extended: Boolean;
  GL_ARB_buffer_storage: Boolean;
  GL_ARB_cl_event: Boolean;
  GL_ARB_clear_buffer_object: Boolean;
  GL_ARB_clear_texture: Boolean;
  GL_ARB_clip_control: Boolean;
  {$IFDEF GL_VERSION_3_0}
  GL_ARB_compatibility: Boolean;
  {$ENDIF}
  {$IFDEF USE_GLEXT}
  GL_ARB_color_buffer_float: Boolean;
  {$EndIf}
  GL_ARB_compressed_texture_pixel_storage: Boolean;
  GL_ARB_compute_shader: Boolean;
  GL_ARB_compute_variable_group_size: Boolean;
  GL_ARB_conditional_render_inverted: Boolean;
  GL_ARB_conservative_depth: Boolean;
  GL_ARB_copy_buffer: Boolean;
  GL_ARB_copy_image: Boolean;
  GL_ARB_cull_distance: Boolean;
  GL_ARB_debug_output: Boolean;
  GL_ARB_depth_buffer_float: Boolean;
  GL_ARB_depth_clamp: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_depth_texture: Boolean;
  {$EndIf}
  GL_ARB_derivative_control: Boolean;
  GL_ARB_direct_state_access: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_draw_buffers: Boolean;
  {$EndIf}
  GL_ARB_draw_buffers_blend: Boolean;
  GL_ARB_draw_elements_base_vertex: Boolean;
  GL_ARB_draw_indirect: Boolean;
  GL_ARB_draw_instanced: Boolean;
  GL_ARB_enhanced_layouts: Boolean;
  GL_ARB_explicit_attrib_location: Boolean;
  GL_ARB_explicit_uniform_location: Boolean;
  GL_ARB_fragment_coord_conventions: Boolean;
  GL_ARB_fragment_layer_viewport: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_fragment_program: Boolean;
  GL_ARB_fragment_program_shadow: Boolean;
  GL_ARB_fragment_shader: Boolean;
  {$EndIf}
  GL_ARB_fragment_shader_interlock: Boolean;
  GL_ARB_framebuffer_no_attachments: Boolean;
  GL_ARB_framebuffer_object: Boolean;
  GL_ARB_framebuffer_sRGB: Boolean;
  GL_ARB_geometry_shader4: Boolean;
  GL_ARB_get_program_binary: Boolean;
  GL_ARB_get_texture_sub_image: Boolean;
  GL_ARB_gl_spirv: Boolean;
  GL_ARB_gpu_shader5: Boolean;
  GL_ARB_gpu_shader_fp64: Boolean;
  GL_ARB_gpu_shader_int64: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_half_float_pixel: Boolean;
  GL_ARB_imaging: Boolean;
  {$EndIf}
  GL_ARB_half_float_vertex: Boolean;
  GL_ARB_indirect_parameters: Boolean;
  GL_ARB_instanced_arrays: Boolean;
  GL_ARB_internalformat_query: Boolean;
  GL_ARB_internalformat_query2: Boolean;
  GL_ARB_invalidate_subdata: Boolean;
  GL_ARB_map_buffer_alignment: Boolean;
  GL_ARB_map_buffer_range: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_matrix_palette: Boolean;
  {$EndIf}
  GL_ARB_multi_bind: Boolean;
  GL_ARB_multi_draw_indirect: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_multisample: Boolean;
  GL_ARB_multitexture: Boolean;
  GL_ARB_occlusion_query: Boolean;
  {$EndIf}
  GL_ARB_occlusion_query2: Boolean;
  GL_ARB_parallel_shader_compile: Boolean;
  GL_ARB_pipeline_statistics_query: Boolean;
  GL_ARB_pixel_buffer_object: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_point_parameters: Boolean;
  GL_ARB_point_sprite: Boolean;
  {$EndIf}
  GL_ARB_polygon_offset_clamp: Boolean;
  GL_ARB_post_depth_coverage: Boolean;
  GL_ARB_program_interface_query: Boolean;
  GL_ARB_provoking_vertex: Boolean;
  GL_ARB_query_buffer_object: Boolean;
  GL_ARB_robust_buffer_access_behavior: Boolean;
  GL_ARB_robustness: Boolean;
  GL_ARB_robustness_isolation: Boolean;
  GL_ARB_sample_locations: Boolean;
  GL_ARB_sample_shading: Boolean;
  GL_ARB_sampler_objects: Boolean;
  GL_ARB_seamless_cube_map: Boolean;
  GL_ARB_seamless_cubemap_per_texture: Boolean;
  GL_ARB_separate_shader_objects: Boolean;
  GL_ARB_shader_atomic_counter_ops: Boolean;
  GL_ARB_shader_atomic_counters: Boolean;
  GL_ARB_shader_ballot: Boolean;
  GL_ARB_shader_bit_encoding: Boolean;
  GL_ARB_shader_clock: Boolean;
  GL_ARB_shader_draw_parameters: Boolean;
  GL_ARB_shader_group_vote: Boolean;
  GL_ARB_shader_image_load_store: Boolean;
  GL_ARB_shader_image_size: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_shader_objects: Boolean;
  {$EndIf}
  GL_ARB_shader_precision: Boolean;
  GL_ARB_shader_stencil_export: Boolean;
  GL_ARB_shader_storage_buffer_object: Boolean;
  GL_ARB_shader_subroutine: Boolean;
  GL_ARB_shader_texture_image_samples: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_shader_texture_lod: Boolean;
  GL_ARB_shading_language_100: Boolean;
  {$EndIf}
  GL_ARB_shader_viewport_layer_array: Boolean;
  GL_ARB_shading_language_420pack: Boolean;
  GL_ARB_shading_language_include: Boolean;
  GL_ARB_shading_language_packing: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_shadow: Boolean;
  GL_ARB_shadow_ambient: Boolean;
  {$EndIf}
  GL_ARB_sparse_buffer: Boolean;
  GL_ARB_sparse_texture: Boolean;
  GL_ARB_sparse_texture2: Boolean;
  GL_ARB_sparse_texture_clamp: Boolean;
  GL_ARB_spirv_extensions: Boolean;
  GL_ARB_stencil_texturing: Boolean;
  GL_ARB_sync: Boolean;
  GL_ARB_tessellation_shader: Boolean;
  GL_ARB_texture_barrier: Boolean;
  GL_ARB_texture_border_clamp: Boolean;
  GL_ARB_texture_buffer_object: Boolean;
  GL_ARB_texture_buffer_object_rgb32: Boolean;
  GL_ARB_texture_buffer_range: Boolean;
  GL_ARB_texture_compression_bptc: Boolean;
  GL_ARB_texture_compression_rgtc: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_texture_compression: Boolean;
  GL_ARB_texture_cube_map: Boolean;
  {$EndIf}
  GL_ARB_texture_cube_map_array: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_texture_env_add: Boolean;
  GL_ARB_texture_env_combine: Boolean;
  GL_ARB_texture_env_crossbar: Boolean;
  GL_ARB_texture_env_dot3: Boolean;
  GL_ARB_texture_float: Boolean;
  {$EndIf}
  GL_ARB_texture_filter_anisotropic: Boolean;
  GL_ARB_texture_filter_minmax: Boolean;
  GL_ARB_texture_gather: Boolean;
  GL_ARB_texture_mirror_clamp_to_edge: Boolean;
  GL_ARB_texture_mirrored_repeat: Boolean;
  GL_ARB_texture_multisample: Boolean;
  GL_ARB_texture_non_power_of_two: Boolean;
  GL_ARB_texture_query_levels: Boolean;
  GL_ARB_texture_query_lod: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_texture_rectangle: Boolean;
  {$EndIf}
  GL_ARB_texture_rg: Boolean;
  GL_ARB_texture_rgb10_a2ui: Boolean;
  GL_ARB_texture_stencil8: Boolean;
  GL_ARB_texture_storage: Boolean;
  GL_ARB_texture_storage_multisample: Boolean;
  GL_ARB_texture_swizzle: Boolean;
  GL_ARB_texture_view: Boolean;
  GL_ARB_timer_query: Boolean;
  GL_ARB_transform_feedback2: Boolean;
  GL_ARB_transform_feedback3: Boolean;
  GL_ARB_transform_feedback_instanced: Boolean;
  GL_ARB_transform_feedback_overflow_query: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_transpose_matrix: Boolean;
  {$EndIf}
  GL_ARB_uniform_buffer_object: Boolean;
  GL_ARB_vertex_array_bgra: Boolean;
  GL_ARB_vertex_array_object: Boolean;
  GL_ARB_vertex_attrib_64bit: Boolean;
  GL_ARB_vertex_attrib_binding: Boolean;
  {$IFDEF USE_GLEXT}
  GL_ARB_vertex_blend: Boolean;
  GL_ARB_vertex_buffer_object: Boolean;
  GL_ARB_vertex_program: Boolean;
  GL_ARB_vertex_shader: Boolean;
  GL_ARB_window_pos: Boolean;
  {$EndIf}
  GL_ARB_vertex_type_10f_11f_11f_rev: Boolean;
  GL_ARB_vertex_type_2_10_10_10_rev: Boolean;
  GL_ARB_viewport_array: Boolean;
  GL_KHR_blend_equation_advanced: Boolean;
  GL_KHR_blend_equation_advanced_coherent: Boolean;
  GL_KHR_context_flush_control: Boolean;
  GL_KHR_debug: Boolean;
  GL_KHR_no_error: Boolean;
  GL_KHR_parallel_shader_compile: Boolean;
  GL_KHR_robust_buffer_access_behavior: Boolean;
  GL_KHR_robustness: Boolean;
  GL_KHR_shader_subgroup: Boolean;
  GL_KHR_texture_compression_astc_hdr: Boolean;
  GL_KHR_texture_compression_astc_ldr: Boolean;
  GL_KHR_texture_compression_astc_sliced_3d: Boolean;
  {$IFDEF USE_GLEXT}
  GL_OES_byte_coordinates: Boolean;
  GL_OES_compressed_paletted_texture: Boolean;
  GL_OES_fixed_point: Boolean;
  GL_OES_query_matrix: Boolean;
  GL_OES_read_format: Boolean;
  GL_OES_single_precision: Boolean;
  GL_3DFX_multisample: Boolean;
  GL_3DFX_tbuffer: Boolean;
  GL_3DFX_texture_compression_FXT1: Boolean;
  GL_AMD_blend_minmax_factor: Boolean;
  GL_AMD_conservative_depth: Boolean;
  GL_AMD_debug_output: Boolean;
  GL_AMD_depth_clamp_separate: Boolean;
  GL_AMD_draw_buffers_blend: Boolean;
  {$EndIf}
  GL_AMD_framebuffer_multisample_advanced: Boolean;
  GL_AMD_gpu_shader_int64: Boolean;                    // хотя это GL_EXT
  {$IFDEF USE_GLEXT}
  GL_AMD_framebuffer_sample_positions: Boolean;
  GL_AMD_gcn_shader: Boolean;
  GL_AMD_gpu_shader_half_float: Boolean;
  GL_AMD_gpu_shader_int16: Boolean;

  GL_AMD_interleaved_elements: Boolean;
  GL_AMD_multi_draw_indirect: Boolean;
  GL_AMD_name_gen_delete: Boolean;
  GL_AMD_occlusion_query_event: Boolean;
  {$EndIf}
  GL_AMD_performance_monitor: Boolean;
  {$IFDEF USE_GLEXT}
  GL_AMD_pinned_memory: Boolean;
  GL_AMD_query_buffer_object: Boolean;
  GL_AMD_sample_positions: Boolean;
  GL_AMD_seamless_cubemap_per_texture: Boolean;
  GL_AMD_shader_atomic_counter_ops: Boolean;
  GL_AMD_shader_ballot: Boolean;
  GL_AMD_shader_explicit_vertex_parameter: Boolean;
  GL_AMD_shader_gpu_shader_half_float_fetch: Boolean;
  GL_AMD_shader_image_load_store_lod: Boolean;
  GL_AMD_shader_stencil_export: Boolean;
  GL_AMD_shader_trinary_minmax: Boolean;
  GL_AMD_sparse_texture: Boolean;
  GL_AMD_stencil_operation_extended: Boolean;
  GL_AMD_texture_gather_bias_lod: Boolean;
  GL_AMD_texture_texture4: Boolean;
  GL_AMD_transform_feedback3_lines_triangles: Boolean;
  GL_AMD_transform_feedback4: Boolean;
  GL_AMD_vertex_shader_layer: Boolean;
  GL_AMD_vertex_shader_tessellator: Boolean;
  GL_AMD_vertex_shader_viewport_index: Boolean;
  GL_APPLE_aux_depth_stencil: Boolean;
  GL_APPLE_client_storage: Boolean;
  GL_APPLE_element_array: Boolean;
  GL_APPLE_fence: Boolean;
  GL_APPLE_float_pixels: Boolean;
  GL_APPLE_flush_buffer_range: Boolean;
  GL_APPLE_object_purgeable: Boolean;
  {$EndIf}
  GL_APPLE_rgb_422: Boolean;
  {$IFDEF USE_GLEXT}
  GL_APPLE_row_bytes: Boolean;
  GL_APPLE_specular_vector: Boolean;
  GL_APPLE_texture_range: Boolean;
  GL_APPLE_transform_hint: Boolean;
  GL_APPLE_vertex_array_object: Boolean;
  GL_APPLE_vertex_array_range: Boolean;
  GL_APPLE_vertex_program_evaluators: Boolean;
  GL_APPLE_ycbcr_422: Boolean;
  GL_ATI_draw_buffers: Boolean;
  GL_ATI_element_array: Boolean;
  GL_ATI_envmap_bumpmap: Boolean;
  GL_ATI_fragment_shader: Boolean;
  GL_ATI_map_object_buffer: Boolean;
  GL_ATI_meminfo: Boolean;
  GL_ATI_pixel_format_float: Boolean;
  GL_ATI_pn_triangles: Boolean;
  GL_ATI_separate_stencil: Boolean;
  GL_ATI_text_fragment_shader: Boolean;
  GL_ATI_texture_env_combine3: Boolean;
  GL_ATI_texture_float: Boolean;
  GL_ATI_texture_mirror_once: Boolean;
  GL_ATI_vertex_array_object: Boolean;
  GL_ATI_vertex_attrib_array_object: Boolean;
  GL_ATI_vertex_streams: Boolean;
  GL_EXT_422_pixels: Boolean;
  {$EndIf}
  GL_EXT_EGL_image_storage: Boolean;
  GL_EXT_EGL_sync: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_abgr: Boolean;
  GL_EXT_bgra: Boolean;
  GL_EXT_bindable_uniform: Boolean;
  GL_EXT_blend_color: Boolean;
  GL_EXT_blend_equation_separate: Boolean;
//  GL_EXT_blend_func_separate: Boolean;
  GL_EXT_blend_logic_op: Boolean;
  GL_EXT_blend_minmax: Boolean;
  GL_EXT_blend_subtract: Boolean;
  GL_EXT_clip_volume_hint: Boolean;
  GL_EXT_cmyka: Boolean;
  GL_EXT_color_subtable: Boolean;
  GL_EXT_compiled_vertex_array: Boolean;
  GL_EXT_convolution: Boolean;
  GL_EXT_coordinate_frame: Boolean;
  GL_EXT_copy_texture: Boolean;
  GL_EXT_cull_vertex: Boolean;
  GL_EXT_depth_bounds_test: Boolean;
  GL_EXT_draw_buffers2: Boolean;
  {$EndIf}
  GL_EXT_debug_label: Boolean;
  GL_EXT_debug_marker: Boolean;
  GL_EXT_direct_state_access: Boolean;
  GL_EXT_draw_instanced: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_draw_range_elements: Boolean;
  GL_EXT_external_buffer: Boolean;
  GL_EXT_fog_coord: Boolean;
  GL_EXT_framebuffer_blit: Boolean;
  GL_EXT_framebuffer_multisample: Boolean;
  GL_EXT_framebuffer_multisample_blit_scaled: Boolean;
  GL_EXT_framebuffer_object: Boolean;
  GL_EXT_framebuffer_sRGB: Boolean;
  GL_EXT_geometry_shader4: Boolean;
  GL_EXT_gpu_program_parameters: Boolean;
  GL_EXT_gpu_shader4: Boolean;
  GL_EXT_histogram: Boolean;
  GL_EXT_index_array_formats: Boolean;
  GL_EXT_index_func: Boolean;
  GL_EXT_index_material: Boolean;
  GL_EXT_index_texture: Boolean;
  GL_EXT_light_texture: Boolean;
  GL_EXT_memory_object: Boolean;
  GL_EXT_memory_object_fd: Boolean;
  GL_EXT_memory_object_win32: Boolean;
  GL_EXT_misc_attribute: Boolean;
  GL_EXT_multi_draw_arrays: Boolean;
  GL_EXT_multisample: Boolean;
  {$EndIf}
  GL_EXT_multiview_tessellation_geometry_shader: Boolean;
  GL_EXT_multiview_texture_multisample: Boolean;
  GL_EXT_multiview_timer_query: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_packed_depth_stencil: Boolean;
  GL_EXT_packed_float: Boolean;
  GL_EXT_packed_pixels: Boolean;
  GL_EXT_paletted_texture: Boolean;
  GL_EXT_pixel_buffer_object: Boolean;
  GL_EXT_pixel_transform: Boolean;
  GL_EXT_pixel_transform_color_table: Boolean;
  GL_EXT_point_parameters: Boolean;
  GL_EXT_polygon_offset: Boolean;
  {$EndIf}
  GL_EXT_polygon_offset_clamp: Boolean;
  GL_EXT_post_depth_coverage: Boolean;
  GL_EXT_raster_multisample: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_provoking_vertex: Boolean;
  GL_EXT_rescale_normal: Boolean;
  GL_EXT_secondary_color: Boolean;
  GL_EXT_semaphore: Boolean;
  GL_EXT_semaphore_fd: Boolean;
  GL_EXT_semaphore_win32: Boolean;
  GL_EXT_separate_specular_color: Boolean;
  {$EndIf}
  GL_EXT_separate_shader_objects: Boolean;
  GL_EXT_shader_framebuffer_fetch: Boolean;
  GL_EXT_shader_framebuffer_fetch_non_coherent: Boolean;
  GL_EXT_shader_integer_mix: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_shader_image_load_formatted: Boolean;
  GL_EXT_shader_image_load_store: Boolean;

  GL_EXT_shadow_funcs: Boolean;
  GL_EXT_shared_texture_palette: Boolean;
  GL_EXT_sparse_texture2: Boolean;
  GL_EXT_stencil_clear_tag: Boolean;
  GL_EXT_stencil_two_side: Boolean;
  GL_EXT_stencil_wrap: Boolean;
  GL_EXT_subtexture: Boolean;
  GL_EXT_texture: Boolean;
  GL_EXT_texture3D: Boolean;
  GL_EXT_texture_array: Boolean;
  GL_EXT_texture_buffer_object: Boolean;
  GL_EXT_texture_compression_latc: Boolean;
  GL_EXT_texture_compression_rgtc: Boolean;
//  GL_EXT_texture_compression_s3tc: Boolean;
  GL_EXT_texture_cube_map: Boolean;
  GL_EXT_texture_env_add: Boolean;
  GL_EXT_texture_env_combine: Boolean;
  GL_EXT_texture_env_dot3: Boolean;
//  GL_EXT_texture_filter_anisotropic: Boolean;
  {$EndIf}
  GL_EXT_texture_filter_minmax: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_texture_integer: Boolean;
  GL_EXT_texture_lod_bias: Boolean;
  GL_EXT_texture_mirror_clamp: Boolean;
  GL_EXT_texture_object: Boolean;
  GL_EXT_texture_perturb_normal: Boolean;
  GL_EXT_texture_sRGB: Boolean;
  {$EndIf}
  GL_EXT_texture_sRGB_R8: Boolean;
  GL_EXT_texture_sRGB_RG8: Boolean;
  GL_EXT_texture_sRGB_decode: Boolean;
  GL_EXT_texture_shadow_lod: Boolean;
  GL_EXT_texture_storage: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_texture_shared_exponent: Boolean;
  GL_EXT_texture_snorm: Boolean;
  GL_EXT_texture_swizzle: Boolean;
  GL_EXT_timer_query: Boolean;
  GL_EXT_transform_feedback: Boolean;
  GL_EXT_vertex_array: Boolean;
  GL_EXT_vertex_array_bgra: Boolean;
  GL_EXT_vertex_attrib_64bit: Boolean;
  GL_EXT_vertex_shader: Boolean;
  GL_EXT_vertex_weighting: Boolean;
  GL_EXT_win32_keyed_mutex: Boolean;
  {$EndIf}
  GL_EXT_window_rectangles: Boolean;
  {$IFDEF USE_GLEXT}
  GL_EXT_x11_sync_object: Boolean;
  GL_GREMEDY_frame_terminator: Boolean;
  GL_GREMEDY_string_marker: Boolean;
  GL_HP_convolution_border_modes: Boolean;
  GL_HP_image_transform: Boolean;
  GL_HP_occlusion_test: Boolean;
  GL_HP_texture_lighting: Boolean;
  GL_IBM_cull_vertex: Boolean;
  GL_IBM_multimode_draw_arrays: Boolean;
  GL_IBM_rasterpos_clip: Boolean;
  GL_IBM_static_data: Boolean;
  GL_IBM_texture_mirrored_repeat: Boolean;
  GL_IBM_vertex_array_lists: Boolean;
  GL_INGR_blend_func_separate: Boolean;
  GL_INGR_color_clamp: Boolean;
  GL_INGR_interlace_read: Boolean;
  {$EndIf}
  GL_INTEL_blackhole_render: Boolean;
  GL_INTEL_conservative_rasterization: Boolean;
  GL_INTEL_framebuffer_CMAA: Boolean;
  {$IFDEF USE_GLEXT}
  GL_INTEL_fragment_shader_ordering: Boolean;
  GL_INTEL_map_texture: Boolean;
  GL_INTEL_parallel_arrays: Boolean;
  GL_MESAX_texture_stack: Boolean;
  {$EndIf}
  GL_INTEL_performance_query: Boolean;
  GL_MESA_framebuffer_flip_x: Boolean;
  GL_MESA_framebuffer_flip_y: Boolean;  
  GL_MESA_framebuffer_swap_xy: Boolean;
  {$IFDEF USE_GLEXT}
  GL_MESA_pack_invert: Boolean;
  GL_MESA_program_binary_formats: Boolean;
  GL_MESA_resize_buffers: Boolean;
  GL_MESA_shader_integer_functions: Boolean;
  GL_MESA_tile_raster_order: Boolean;
  GL_MESA_window_pos: Boolean;
  GL_MESA_ycbcr_texture: Boolean;
  GL_NVX_blend_equation_advanced_multi_draw_buffers: Boolean;
  GL_NVX_conditional_render: Boolean;
  GL_NVX_gpu_memory_info: Boolean;
  GL_NVX_gpu_multicast2: Boolean;
  GL_NVX_linked_gpu_multicast: Boolean;
  GL_NVX_progress_fence: Boolean;
  GL_NV_alpha_to_coverage_dither_control: Boolean;
  {$EndIf}
  GL_NV_bindless_multi_draw_indirect: Boolean;
  GL_NV_bindless_multi_draw_indirect_count: Boolean;
  GL_NV_bindless_texture: Boolean;
  GL_NV_blend_equation_advanced: Boolean;
  GL_NV_blend_equation_advanced_coherent: Boolean;
  GL_NV_blend_minmax_factor: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_blend_square: Boolean;
  GL_NV_compute_program5: Boolean;
  {$EndIf}
  GL_NV_clip_space_w_scaling: Boolean;
  GL_NV_command_list: Boolean;
  GL_NV_compute_shader_derivatives: Boolean;
  GL_NV_conditional_render: Boolean;
  GL_NV_conservative_raster: Boolean;
  GL_NV_conservative_raster_dilate: Boolean;
  GL_NV_conservative_raster_pre_snap: Boolean;
  GL_NV_conservative_raster_pre_snap_triangles: Boolean;
  GL_NV_conservative_raster_underestimation: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_copy_depth_to_color: Boolean;
  GL_NV_copy_image: Boolean;
  GL_NV_deep_texture3D: Boolean;
  GL_NV_depth_clamp: Boolean;
  GL_NV_draw_texture: Boolean;
  {$EndIf}
  GL_NV_depth_buffer_float: Boolean;
  GL_NV_draw_vulkan_image: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_evaluators: Boolean;
  GL_NV_explicit_multisample: Boolean;
  GL_NV_fence: Boolean;
  GL_NV_float_buffer: Boolean;
  GL_NV_fog_distance: Boolean;
  {$EndIf}
  GL_NV_fill_rectangle: Boolean;
  GL_NV_fragment_coverage_to_color: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_fragment_program: Boolean;
  GL_NV_fragment_program2: Boolean;
  GL_NV_fragment_program4: Boolean;
  GL_NV_fragment_program_option: Boolean;
  {$EndIf}
  GL_NV_fragment_shader_barycentric: Boolean;
  GL_NV_fragment_shader_interlock: Boolean;
  GL_NV_framebuffer_mixed_samples: Boolean;
  GL_NV_framebuffer_multisample_coverage: Boolean;
  GL_NV_geometry_shader_passthrough: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_geometry_program4: Boolean;
  GL_NV_geometry_shader4: Boolean;
  GL_NV_gpu_multicast: Boolean;
  GL_NV_gpu_program4: Boolean;
  GL_NV_gpu_program5: Boolean;
  GL_NV_gpu_program5_mem_extended: Boolean;
  {$EndIf}
  // узнать, работает ли эта часть при GLext!!!!
  // хотя функции подменены в другом разделе.
  GL_NV_gpu_shader5: Boolean;
  GL_NV_internalformat_sample_query: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_half_float: Boolean;
  GL_NV_light_max_exponent: Boolean;
  {$EndIf}
  GL_NV_memory_attachment: Boolean;
  GL_NV_memory_object_sparse: Boolean;
  GL_NV_mesh_shader: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_multisample_coverage: Boolean;
  GL_NV_multisample_filter_hint: Boolean;
  GL_NV_occlusion_query: Boolean;
  GL_NV_packed_depth_stencil: Boolean;
  GL_NV_parameter_buffer_object: Boolean;
  GL_NV_parameter_buffer_object2: Boolean;
  {$EndIf}
  GL_NV_path_rendering: Boolean;
  GL_NV_path_rendering_shared_edge: Boolean;
  GL_NV_primitive_shading_rate: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_pixel_data_range: Boolean;
  GL_NV_point_sprite: Boolean;
  GL_NV_present_video: Boolean;
  GL_NV_primitive_restart: Boolean;
  GL_NV_query_resource: Boolean;
  GL_NV_query_resource_tag: Boolean;
  GL_NV_register_combiners: Boolean;
  GL_NV_register_combiners2: Boolean;
  GL_NV_robustness_video_memory_purge: Boolean;
  {$EndIf}
  GL_NV_representative_fragment_test: Boolean;
  GL_NV_sample_locations: Boolean;
  GL_NV_sample_mask_override_coverage: Boolean;
  GL_NV_scissor_exclusive: Boolean;
  GL_NV_shader_atomic_counters: Boolean;
  GL_NV_shader_atomic_float: Boolean;
  GL_NV_shader_atomic_float64: Boolean;
  GL_NV_shader_atomic_fp16_vector: Boolean;
  GL_NV_shader_atomic_int64: Boolean;
  GL_NV_shader_buffer_load: Boolean;
  GL_NV_shader_buffer_store: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_shader_storage_buffer_object: Boolean;
  {$EndIf}
  GL_NV_shader_subgroup_partitioned: Boolean;
  GL_NV_shader_texture_footprint: Boolean;
  GL_NV_shader_thread_group: Boolean;
  GL_NV_shader_thread_shuffle: Boolean;
  GL_NV_shading_rate_image: Boolean;
  GL_NV_texture_barrier: Boolean;     
  GL_NV_texture_rectangle_compressed: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_stereo_view_rendering: Boolean;
  GL_NV_tessellation_program5: Boolean;
  GL_NV_texgen_emboss: Boolean;
  GL_NV_texgen_reflection: Boolean;
  GL_NV_texture_compression_vtc: Boolean;
  GL_NV_texture_env_combine4: Boolean;
  GL_NV_texture_expand_normal: Boolean;
  GL_NV_texture_multisample: Boolean;
  GL_NV_texture_rectangle: Boolean;
  GL_NV_texture_shader: Boolean;
  GL_NV_texture_shader2: Boolean;
  GL_NV_texture_shader3: Boolean;
  GL_NV_timeline_semaphore: Boolean;
  GL_NV_transform_feedback: Boolean;
  GL_NV_transform_feedback2: Boolean;
  GL_NV_vdpau_interop: Boolean;
  GL_NV_vdpau_interop2: Boolean;
  GL_NV_vertex_array_range: Boolean;
  GL_NV_vertex_array_range2: Boolean;
  {$EndIf}
  GL_NV_uniform_buffer_unified_memory: Boolean;
  GL_NV_vertex_attrib_integer_64bit: Boolean;
  GL_NV_vertex_buffer_unified_memory: Boolean;
  {$IFDEF USE_GLEXT}
  GL_NV_vertex_program: Boolean;
  GL_NV_vertex_program1_1: Boolean;
  GL_NV_vertex_program2: Boolean;
  GL_NV_vertex_program2_option: Boolean;
  GL_NV_vertex_program3: Boolean;
  GL_NV_vertex_program4: Boolean;
  GL_NV_video_capture: Boolean;
  GL_OML_interlace: Boolean;
  GL_OML_resample: Boolean;
  GL_OML_subsample: Boolean;
  {$EndIf}
  GL_NV_viewport_array2: Boolean;
  GL_NV_viewport_swizzle: Boolean;
  GL_OVR_multiview: Boolean;
  GL_OVR_multiview2: Boolean;
  {$IFDEF USE_GLEXT}
  GL_PGI_misc_hints: Boolean;
  GL_PGI_vertex_hints: Boolean;
  GL_REND_screen_coordinates: Boolean;
  GL_S3_s3tc: Boolean;
  GL_SGIS_detail_texture: Boolean;
  GL_SGIS_fog_function: Boolean;
//  GL_SGIS_generate_mipmap: Boolean;
  GL_SGIS_multisample: Boolean;
  GL_SGIS_pixel_texture: Boolean;
  GL_SGIS_point_line_texgen: Boolean;
  GL_SGIS_point_parameters: Boolean;
  GL_SGIS_sharpen_texture: Boolean;
  GL_SGIS_texture4D: Boolean;
  GL_SGIS_texture_border_clamp: Boolean;
  GL_SGIS_texture_color_mask: Boolean;
  GL_SGIS_texture_edge_clamp: Boolean;
  GL_SGIS_texture_filter4: Boolean;
  GL_SGIS_texture_lod: Boolean;
  GL_SGIS_texture_select: Boolean;
  GL_SGIX_async: Boolean;
  GL_SGIX_async_histogram: Boolean;
  GL_SGIX_async_pixel: Boolean;
  GL_SGIX_blend_alpha_minmax: Boolean;
  GL_SGIX_calligraphic_fragment: Boolean;
  GL_SGIX_clipmap: Boolean;
  GL_SGIX_convolution_accuracy: Boolean;
  GL_SGIX_depth_pass_instrument: Boolean;
  GL_SGIX_depth_texture: Boolean;
  GL_SGIX_flush_raster: Boolean;
  GL_SGIX_fog_offset: Boolean;
  GL_SGIX_fragment_lighting: Boolean;
  GL_SGIX_framezoom: Boolean;
  GL_SGIX_igloo_interface: Boolean;
  GL_SGIX_instruments: Boolean;
  GL_SGIX_interlace: Boolean;
  GL_SGIX_ir_instrument1: Boolean;
  GL_SGIX_list_priority: Boolean;
  GL_SGIX_pixel_texture: Boolean;
  GL_SGIX_pixel_tiles: Boolean;
  GL_SGIX_polynomial_ffd: Boolean;
  GL_SGIX_reference_plane: Boolean;
  GL_SGIX_resample: Boolean;
  GL_SGIX_scalebias_hint: Boolean;
  GL_SGIX_shadow: Boolean;
  GL_SGIX_shadow_ambient: Boolean;
  GL_SGIX_sprite: Boolean;
  GL_SGIX_subsample: Boolean;
  GL_SGIX_tag_sample_buffer: Boolean;
  GL_SGIX_texture_add_env: Boolean;
  GL_SGIX_texture_coordinate_clamp: Boolean;
  GL_SGIX_texture_lod_bias: Boolean;
  GL_SGIX_texture_multi_buffer: Boolean;
  GL_SGIX_texture_scale_bias: Boolean;
  GL_SGIX_vertex_preclip: Boolean;
  GL_SGIX_ycrcb: Boolean;
  GL_SGIX_ycrcb_subsample: Boolean;
  GL_SGIX_ycrcba: Boolean;
  GL_SGI_color_matrix: Boolean;
  GL_SGI_color_table: Boolean;
  GL_SGI_texture_color_table: Boolean;
  GL_SUNX_constant_data: Boolean;
  GL_SUN_convolution_border_modes: Boolean;
  GL_SUN_global_alpha: Boolean;
  GL_SUN_mesh_array: Boolean;
  GL_SUN_slice_accum: Boolean;
  GL_SUN_triangle_list: Boolean;
  GL_SUN_vertex: Boolean;
  GL_WIN_phong_shading: Boolean;
  GL_WIN_specular_fog: Boolean;
  {$EndIf}
  {$IfEnd}

(*******************************************************************************
*                             deprecated                                       *
*******************************************************************************)
{$IfDef USE_DEPRECATED}
  procedure glAccum(op: GLenum; value: GLfloat); stdcall; external libGL;
//  glAlphaFunc: procedure(func: GLenum; ref: GLclampf); stdcall; external libGL;
  function glAreTexturesResident(n: GLsizei; const textures: PGLuint; residences: PGLboolean): GLboolean; stdcall; external libGL;
//  glArrayElement: procedure(i: GLint); stdcall; external libGL; // + EXT
//  glBegin: procedure(mode: GLenum); stdcall; external libGL;
  procedure glBitmap (width, height: GLsizei; xorig, yorig: GLfloat; xmove, ymove: GLfloat; const bitmap: PGLubyte); stdcall; external libGL;
  procedure glCallList(list: GLuint); stdcall; external libGL;
  procedure glCallLists(n: GLsizei; atype: GLenum; const lists: Pointer); stdcall; external libGL;
  procedure glClearAccum(red, green, blue, alpha: GLfloat); stdcall; external libGL;
  procedure glClearIndex(c: GLfloat); stdcall; external libGL;
  procedure glClipPlane(plane: GLenum; const equation: PGLdouble); stdcall; external libGL;
  procedure glColor3b(red, green, blue: GLbyte); stdcall; external libGL;
  procedure glColor3bv(const v: PGLbyte); stdcall; external libGL;
  procedure glColor3d(red, green, blue: GLdouble); stdcall; external libGL;
  procedure glColor3dv(const v: PGLdouble); stdcall; external libGL;
  procedure glColor3f(red, green, blue: GLfloat); stdcall; external libGL;
  procedure glColor3fv(const v: PGLfloat); stdcall; external libGL;
  procedure glColor3i(red, green, blue: GLint); stdcall; external libGL;
  procedure glColor3iv(const v: PGLint); stdcall; external libGL;
  procedure glColor3s(red, green, blue: GLshort); stdcall; external libGL;
  procedure glColor3sv(const v: PGLshort); stdcall; external libGL;
//  glColor3ub: procedure(red, green, blue: GLubyte); stdcall; external libGL;
//  glColor3ubv: procedure(const v: PGLubyte); stdcall; external libGL;
  procedure glColor3ui(red, green, blue: GLuint); stdcall; external libGL;
  procedure glColor3uiv(const v: PGLuint); stdcall; external libGL;
  procedure glColor3us(red, green, blue: GLushort); stdcall; external libGL;
  procedure glColor3usv(const v: PGLushort); stdcall; external libGL;
  procedure glColor4b(red, green, blue, alpha: GLbyte); stdcall; external libGL;
  procedure glColor4bv(const v: PGLbyte); stdcall; external libGL;
  procedure glColor4d(red, green, blue, alpha: GLdouble); stdcall; external libGL;
  procedure glColor4dv(const v: PGLdouble); stdcall; external libGL;
//  glColor4f: procedure(red, green, blue, alpha: GLfloat); stdcall; external libGL;
//  glColor4fv: procedure(const v: PGLfloat); stdcall; external libGL;
  procedure glColor4i(red, green, blue, alpha: GLint); stdcall; external libGL;
  procedure glColor4iv(const v: PGLint); stdcall; external libGL;
  procedure glColor4s(red, green, blue, alpha: GLshort); stdcall; external libGL;
  procedure glColor4sv(const v: PGLshort); stdcall; external libGL;
//  glColor4ub: procedure(red, green, blue, alpha: GLubyte); stdcall; external libGL;
//  glColor4ubv: procedure(const v: PGLubyte); stdcall; external libGL;
  procedure glColor4ui(red, green, blue, alpha: GLuint); stdcall; external libGL;
  procedure glColor4uiv(const v: PGLuint); stdcall; external libGL;
  procedure glColor4us(red, green, blue, alpha: GLushort); stdcall; external libGL;
  procedure glColor4usv(const v: PGLushort); stdcall; external libGL;
//  glColorMaterial: procedure(face, mode: GLenum); stdcall; external libGL;
//  glColorPointer: procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  procedure glCopyPixels(x, y: GLint; width, height: GLsizei; atype: GLenum); stdcall; external libGL;
  procedure glDeleteLists(list: GLuint; range: GLsizei); stdcall; external libGL;
//  glDisableClientState: procedure(aarray: GLenum); stdcall; external libGL;
  procedure glDrawPixels(width, height: GLsizei; format, atype: GLenum; const pixels: Pointer); stdcall; external libGL;
  procedure glEdgeFlag(flag: GLboolean); stdcall; external libGL;
//  glEdgeFlagPointer: procedure(stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  procedure glEdgeFlagv(const flag: PGLboolean); stdcall; external libGL;
//  glEnableClientState: procedure(aarray: GLenum); stdcall; external libGL;
//  glEnd: procedure; stdcall; external libGL;
  procedure glEndList; stdcall; external libGL;
  procedure glEvalCoord1d(u: GLdouble); stdcall; external libGL;
  procedure glEvalCoord1dv(const u: PGLdouble); stdcall; external libGL;
  procedure glEvalCoord1f(u: GLfloat); stdcall; external libGL;
  procedure glEvalCoord1fv(const u: PGLfloat); stdcall; external libGL;
  procedure glEvalCoord2d(u, v: GLdouble); stdcall; external libGL;
  procedure glEvalCoord2dv(const u: PGLdouble); stdcall; external libGL;
  procedure glEvalCoord2f(u, v: GLfloat); stdcall; external libGL;
  procedure glEvalCoord2fv(const u: PGLfloat); stdcall; external libGL;
  procedure glEvalMesh1(mode: GLenum; i1, i2: GLint); stdcall; external libGL;
  procedure glEvalMesh2(mode: GLenum; i1, i2, j1, j2: GLint); stdcall; external libGL;
  procedure glEvalPoint1(i: GLint); stdcall; external libGL;
  procedure glEvalPoint2(i, j: GLint); stdcall; external libGL;
  procedure glFeedbackBuffer(size: GLsizei; atype: GLenum; buffer: PGLfloat); stdcall; external libGL;
  procedure glFogf(pname: GLenum; param: GLfloat); stdcall; external libGL;
  procedure glFogfv(pname: GLenum; const params: PGLfloat); stdcall; external libGL;
  procedure glFogi(pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glFogiv(pname: GLenum; const params: PGLint); stdcall; external libGL;
//  glFrustum: procedure(left, right, bottom, top, zNear, zFar: GLdouble); stdcall; external libGL;
  function glGenLists(range: GLsizei): GLuint; stdcall; external libGL;
  procedure glGetClipPlane(plane: GLenum; equation: PGLdouble); stdcall; external libGL;
//  glGetLightfv: procedure(light, pname: GLenum; params: PGLfloat); stdcall; external libGL;
//  glGetLightiv: procedure(light, pname: GLenum; params: PGLint); stdcall; external libGL;
  procedure glGetMapdv(target, query: GLenum; v: PGLdouble); stdcall; external libGL;
  procedure glGetMapfv(target, query: GLenum; v: PGLfloat); stdcall; external libGL;
  procedure glGetMapiv(target, query: GLenum; v: PGLint); stdcall; external libGL;
//  glGetMaterialfv: procedure(face, pname: GLenum; params: PGLfloat); stdcall; external libGL;
//  glGetMaterialiv: procedure(face, pname: GLenum; params: PGLint); stdcall; external libGL;
  procedure glGetPixelMapfv(map: GLenum; values: PGLfloat); stdcall; external libGL;
  procedure glGetPixelMapuiv(map: GLenum; values: PGLuint); stdcall; external libGL;
  procedure glGetPixelMapusv(map: GLenum; values: PGLushort); stdcall; external libGL;
  procedure glGetPolygonStipple(mask: PGLubyte); stdcall; external libGL;
  procedure glGetTexEnvfv(target, pname: GLenum; params: PGLfloat); stdcall; external libGL;
  procedure glGetTexEnviv(target, pname: GLenum; params: PGLint); stdcall; external libGL;
  procedure glGetTexGendv(coord, pname: GLenum; params: PGLdouble); stdcall; external libGL;
  procedure glGetTexGenfv(coord, pname: GLenum; params: PGLfloat); stdcall; external libGL;
  procedure glGetTexGeniv(coord, pname: GLenum; params: PGLint); stdcall; external libGL;
  procedure glIndexMask(mask: GLuint); stdcall; external libGL;
  procedure glIndexPointer(atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  procedure glIndexd(c: GLdouble); stdcall; external libGL;
  procedure glIndexdv(const c: PGLdouble); stdcall; external libGL;
  procedure glIndexf(c: GLfloat); stdcall; external libGL;
  procedure glIndexfv(const c: PGLfloat); stdcall; external libGL;
  procedure glIndexi(c: GLint); stdcall; external libGL;
  procedure glIndexiv(const c: PGLint); stdcall; external libGL;
  procedure glIndexs(c: GLshort); stdcall; external libGL;
  procedure glIndexsv(const c: PGLshort); stdcall; external libGL;
  procedure glIndexub(c: GLubyte); stdcall; external libGL;
  procedure glIndexubv(const c: PGLubyte); stdcall; external libGL;
  procedure glInitNames; stdcall; external libGL;
//  glInterleavedArrays: procedure(format: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  function glIsList(list: GLuint): GLboolean; stdcall; external libGL;
//  glLightModelf: procedure(pname: GLenum; param: GLfloat); stdcall; external libGL;
//  glLightModelfv: procedure(pname: GLenum; const params: PGLfloat); stdcall; external libGL;
  procedure glLightModeli(pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glLightModeliv(pname: GLenum; const params: PGLint); stdcall; external libGL;
//  glLightf: procedure(light, pname: GLenum; param: GLfloat); stdcall; external libGL;
//  glLightfv: procedure(light, pname: GLenum; const params: PGLfloat); stdcall; external libGL;
  procedure glLighti(light, pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glLightiv(light, pname: GLenum; const params: PGLint); stdcall; external libGL;
  procedure glLineStipple(factor: GLint; pattern: GLushort); stdcall; external libGL;
  procedure glListBase(base: GLuint); stdcall; external libGL;
//  glLoadIdentity: procedure; stdcall; external libGL;
  procedure glLoadMatrixd(const m: PGLdouble); stdcall; external libGL;
//  glLoadMatrixf: procedure(const m: PGLfloat); stdcall; external libGL;
  procedure glLoadName(name: GLuint); stdcall; external libGL;
  procedure glMap1d(target: GLenum; u1, u2: GLdouble; stride, order: GLint; const points: PGLdouble); stdcall; external libGL;
  procedure glMap1f(target: GLenum; u1, u2: GLfloat; stride, order: GLint; const points: PGLfloat); stdcall; external libGL;
  procedure glMap2d(target: GLenum; u1, u2: GLdouble; ustride, uorder: GLint; v1, v2: GLdouble; vstride, vorder: GLint; const points: PGLdouble); stdcall; external libGL;
  procedure glMap2f(target: GLenum; u1, u2: GLfloat; ustride, uorder: GLint; v1, v2: GLfloat; vstride, vorder: GLint; const points: PGLfloat); stdcall; external libGL;
  procedure glMapGrid1d(un: GLint; u1, u2: GLdouble); stdcall; external libGL;
  procedure glMapGrid1f(un: GLint; u1, u2: GLfloat); stdcall; external libGL;
  procedure glMapGrid2d(un: GLint; u1, u2: GLdouble; vn: GLint; v1, v2: GLdouble); stdcall; external libGL;
  procedure glMapGrid2f(un: GLint; u1, u2: GLfloat; vn: GLint; v1, v2: GLfloat); stdcall; external libGL;
//  glMaterialf: procedure(face, pname: GLenum; param: GLfloat); stdcall; external libGL;
//  glMaterialfv: procedure(face, pname: GLenum; const params: PGLfloat); stdcall; external libGL;
  procedure glMateriali(face, pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glMaterialiv(face, pname: GLenum; const params: PGLint); stdcall; external libGL;
//  glMatrixMode: procedure(mode: GLenum); stdcall; external libGL;
  procedure glMultMatrixd(const m: PGLdouble); stdcall; external libGL;
  procedure glMultMatrixf(const m: PGLfloat); stdcall; external libGL;
  procedure glNewList(list: GLuint; mode: GLenum); stdcall; external libGL;
  procedure glNormal3b(nx, ny, nz: GLbyte); stdcall; external libGL;
  procedure glNormal3bv(const v: PGLbyte); stdcall; external libGL;
  procedure glNormal3d(nx, ny, nz: GLdouble); stdcall; external libGL;
  procedure glNormal3dv(const v: PGLdouble); stdcall; external libGL;
//  glNormal3f: procedure(nx, ny, nz: GLfloat); stdcall; external libGL;
//  glNormal3fv: procedure(const v: PGLfloat); stdcall; external libGL;
  procedure glNormal3i(nx, ny, nz: GLint); stdcall; external libGL;
  procedure glNormal3iv(const v: PGLint); stdcall; external libGL;
  procedure glNormal3s(nx, ny, nz: GLshort); stdcall; external libGL;
  procedure glNormal3sv(const v: PGLshort); stdcall; external libGL;
//  glNormalPointer: procedure(atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
//  glOrtho: procedure(left, right, bottom, top, zNear, zFar: GLdouble); stdcall; external libGL;
  procedure glPassThrough(token: GLfloat); stdcall; external libGL;
  procedure glPixelMapfv(map: GLenum; mapsize: GLint; const values: PGLfloat); stdcall; external libGL;
  procedure glPixelMapuiv(map: GLenum; mapsize: GLint; const values: PGLuint); stdcall; external libGL;
  procedure glPixelMapusv(map: GLenum; mapsize: GLint; const values: PGLushort); stdcall; external libGL;
  procedure glPixelTransferf(pname: GLenum; param: GLfloat); stdcall; external libGL;
  procedure glPixelTransferi(pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glPixelZoom(xfactor, yfactor: GLfloat); stdcall; external libGL;
  procedure glPolygonStipple(const mask: PGLubyte); stdcall; external libGL;
  procedure glPopAttrib; stdcall; external libGL;
  procedure glPopClientAttrib; stdcall; external libGL;
//  glPopMatrix: procedure; stdcall; external libGL;
  procedure glPopName; stdcall; external libGL;
  procedure glPrioritizeTextures(n: GLsizei; const textures: PGLuint; const priorities: PGLclampf); stdcall; external libGL;
  procedure glPushAttrib(mask: GLbitfield); stdcall; external libGL;
  procedure glPushClientAttrib(mask: GLbitfield); stdcall; external libGL;
//  glPushMatrix: procedure; stdcall; external libGL;
  procedure glPushName(name: GLuint); stdcall; external libGL;
  procedure glRasterPos2d(x, y: GLdouble); stdcall; external libGL;
  procedure glRasterPos2dv(const v: PGLdouble); stdcall; external libGL;
  procedure glRasterPos2f(x, y: GLfloat); stdcall; external libGL;
  procedure glRasterPos2fv(const v: PGLfloat); stdcall; external libGL;
  procedure glRasterPos2i(x, y: GLint); stdcall; external libGL;
  procedure glRasterPos2iv(const v: PGLint); stdcall; external libGL;
  procedure glRasterPos2s(x, y: GLshort); stdcall; external libGL;
  procedure glRasterPos2sv(const v: PGLshort); stdcall; external libGL;
  procedure glRasterPos3d(x, y, z: GLdouble); stdcall; external libGL;
  procedure glRasterPos3dv(const v: PGLdouble); stdcall; external libGL;
  procedure glRasterPos3f(x, y, z: GLfloat); stdcall; external libGL;
  procedure glRasterPos3fv(const v: PGLfloat); stdcall; external libGL;
  procedure glRasterPos3i(x, y, z: GLint); stdcall; external libGL;
  procedure glRasterPos3iv(const v: PGLint); stdcall; external libGL;
  procedure glRasterPos3s(x, y, z: GLshort); stdcall; external libGL;
  procedure glRasterPos3sv(const v: PGLshort); stdcall; external libGL;
  procedure glRasterPos4d(x, y, z, w: GLdouble); stdcall; external libGL;
  procedure glRasterPos4dv(const v: PGLdouble); stdcall; external libGL;
  procedure glRasterPos4f(x, y, z, w: GLfloat); stdcall; external libGL;
  procedure glRasterPos4fv(const v: PGLfloat); stdcall; external libGL;
  procedure glRasterPos4i(x, y, z, w: GLint); stdcall; external libGL;
  procedure glRasterPos4iv(const v: PGLint); stdcall; external libGL;
  procedure glRasterPos4s(x, y, z, w: GLshort); stdcall; external libGL;
  procedure glRasterPos4sv(const v: PGLshort); stdcall; external libGL;
  procedure glRectd(x1, y1, x2, y2: GLdouble); stdcall; external libGL;
  procedure glRectdv(const v1: PGLdouble; const v2: PGLdouble); stdcall; external libGL;
  procedure glRectf(x1, y1, x2, y2: GLfloat); stdcall; external libGL;
  procedure glRectfv(const v1: PGLfloat; const v2: PGLfloat); stdcall; external libGL;
  procedure glRecti(x1, y1, x2, y2: GLint); stdcall; external libGL;
  procedure glRectiv(const v1: PGLint; const v2: PGLint); stdcall; external libGL;
  procedure glRects(x1, y1, x2, y2: GLshort); stdcall; external libGL;
  procedure glRectsv(const v1: PGLshort; const v2: PGLshort); stdcall; external libGL;
  function glRenderMode(mode: GLint): GLint; stdcall; external libGL;
  procedure glRotated(angle, x, y, z: GLdouble); stdcall; external libGL;
//  glRotatef: procedure(angle, x, y, z: GLfloat); stdcall; external libGL;
  procedure glScaled(x, y, z: GLdouble); stdcall; external libGL;
//  glScalef: procedure(x, y, z: GLfloat); stdcall; external libGL;
  procedure glSelectBuffer(size: GLsizei; buffer: PGLuint); stdcall; external libGL;
//  glShadeModel: procedure(mode: GLenum); stdcall; external libGL;
  procedure glTexCoord1d(s: GLdouble); stdcall; external libGL;
  procedure glTexCoord1dv(const v: PGLdouble); stdcall; external libGL;
  procedure glTexCoord1f(s: GLfloat); stdcall; external libGL;
  procedure glTexCoord1fv(const v: PGLfloat); stdcall; external libGL;
  procedure glTexCoord1i(s: GLint); stdcall; external libGL;
  procedure glTexCoord1iv(const v: PGLint); stdcall; external libGL;
  procedure glTexCoord1s(s: GLshort); stdcall; external libGL;
  procedure glTexCoord1sv(const v: PGLshort); stdcall; external libGL;
  procedure glTexCoord2d(s, t: GLdouble); stdcall; external libGL;
  procedure glTexCoord2dv(const v: PGLdouble); stdcall; external libGL;
//  glTexCoord2f: procedure(s, t: GLfloat); stdcall; external libGL;
//  glTexCoord2fv: procedure(const v: PGLfloat); stdcall; external libGL;
  procedure glTexCoord2i(s, t: GLint); stdcall; external libGL;
  procedure glTexCoord2iv(const v: PGLint); stdcall; external libGL;
  procedure glTexCoord2s(s, t: GLshort); stdcall; external libGL;
  procedure glTexCoord2sv(const v: PGLshort); stdcall; external libGL;
  procedure glTexCoord3d(s, t, r: GLdouble); stdcall; external libGL;
  procedure glTexCoord3dv(const v: PGLdouble); stdcall; external libGL;
  procedure glTexCoord3f(s, t, r: GLfloat); stdcall; external libGL;
  procedure glTexCoord3fv(const v: PGLfloat); stdcall; external libGL;
  procedure glTexCoord3i(s, t, r: GLint); stdcall; external libGL;
  procedure glTexCoord3iv(const v: PGLint); stdcall; external libGL;
  procedure glTexCoord3s(s, t, r: GLshort); stdcall; external libGL;
  procedure glTexCoord3sv(const v: PGLshort); stdcall; external libGL;
  procedure glTexCoord4d(s, t, r, q: GLdouble); stdcall; external libGL;
  procedure glTexCoord4dv(const v: PGLdouble); stdcall; external libGL;
  procedure glTexCoord4f(s, t, r, q: GLfloat); stdcall; external libGL;
  procedure glTexCoord4fv(const v: PGLfloat); stdcall; external libGL;
  procedure glTexCoord4i(s, t, r, q: GLint); stdcall; external libGL;
  procedure glTexCoord4iv(const v: PGLint); stdcall; external libGL;
  procedure glTexCoord4s(s, t, r, q: GLshort); stdcall; external libGL;
  procedure glTexCoord4sv(const v: PGLshort); stdcall; external libGL;
//  glTexCoordPointer: procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  procedure glTexEnvf(target: GLenum; pname: GLenum; param: GLfloat); stdcall; external libGL;
  procedure glTexEnvfv(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall; external libGL;
//  glTexEnvi: procedure(target: GLenum; pname: GLenum; param: GLint); stdcall; external libGL;
//  glTexEnviv: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall; external libGL;
  procedure glTexGend(coord: GLenum; pname: GLenum; param: GLdouble); stdcall; external libGL;
  procedure glTexGendv(coord: GLenum; pname: GLenum; const params: PGLdouble); stdcall; external libGL;
  procedure glTexGenf(coord: GLenum; pname: GLenum; param: GLfloat); stdcall; external libGL;
  procedure glTexGenfv(coord: GLenum; pname: GLenum; const params: PGLfloat); stdcall; external libGL;
  procedure glTexGeni(coord: GLenum; pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glTexGeniv(coord: GLenum; pname: GLenum; const params: PGLint); stdcall; external libGL;
  procedure glTranslated(x, y, z: GLdouble); stdcall; external libGL;
//  glTranslatef: procedure(x, y, z: GLfloat); stdcall;
  procedure glVertex2d(x, y: GLdouble); stdcall; external libGL;
  procedure glVertex2dv(const v: PGLdouble); stdcall; external libGL;
//  glVertex2f: procedure(x, y: GLfloat); stdcall;
//  glVertex2fv: procedure(const v: PGLfloat); stdcall;
  procedure glVertex2i(x, y: GLint); stdcall; external libGL;
  procedure glVertex2iv(const v: PGLint); stdcall; external libGL;
  procedure glVertex2s(x, y: GLshort); stdcall; external libGL;
  procedure glVertex2sv(const v: PGLshort); stdcall; external libGL;
  procedure glVertex3d(x, y, z: GLdouble); stdcall; external libGL;
  procedure glVertex3dv(const v: PGLdouble); stdcall; external libGL;
//  glVertex3f: procedure(x, y, z: GLfloat); stdcall;
//  glVertex3fv: procedure(const v: PGLfloat); stdcall;
  procedure glVertex3i(x, y, z: GLint); stdcall; external libGL;
  procedure glVertex3iv(const v: PGLint); stdcall; external libGL;
  procedure glVertex3s(x, y, z: GLshort); stdcall; external libGL;
  procedure glVertex3sv(const v: PGLshort); stdcall; external libGL;
  procedure glVertex4d(x, y, z, w: GLdouble); stdcall; external libGL;
  procedure glVertex4dv(const v: PGLdouble); stdcall; external libGL;
  procedure glVertex4f(x, y, z, w: GLfloat); stdcall; external libGL;
  procedure glVertex4fv(const v: PGLfloat); stdcall; external libGL;
  procedure glVertex4i(x, y, z, w: GLint); stdcall; external libGL;
  procedure glVertex4iv(const v: PGLint); stdcall; external libGL;
  procedure glVertex4s(x, y, z, w: GLshort); stdcall; external libGL;
  procedure glVertex4sv(const v: PGLshort); stdcall; external libGL;
//  glVertexPointer: procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall;
{$EndIf}
(*******************************************************************************
*                            end deprecated                                    *
*******************************************************************************)

  {$IfDef GL_VERSION_1_0}
  procedure glCullFace(mode: GLenum); stdcall; external libGL;
  procedure glFrontFace(mode: GLenum); stdcall; external libGL;
//  procedure glHint(target: GLenum; mode: GLenum); stdcall; external libGL;
  procedure glLineWidth(width: GLfloat); stdcall; external libGL;
//  procedure glPointSize(size: GLfloat); stdcall; external libGL;
  procedure glPolygonMode(face: GLenum; mode: GLenum); stdcall; external libGL;
//  procedure glScissor(x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall; external libGL;
//  procedure glTexParameterf(target: GLenum; pname: GLenum; param: GLfloat); stdcall; external libGL;
//  procedure glTexParameterfv(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall; external libGL;
//  procedure glTexParameteri(target: GLenum; pname: GLenum; param: GLint); stdcall; external libGL;
//  procedure glTexParameteriv(target: GLenum; pname: GLenum; const params: PGLint); stdcall; external libGL;
  procedure glTexImage1D(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall; external libGL;
//  procedure glTexImage2D(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall; external libGL;
  procedure glDrawBuffer(buf: GLenum); stdcall; external libGL;
//  procedure glClear(mask: GLbitfield); stdcall; external libGL;
//  procedure glClearColor(red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat); stdcall; external libGL;
  procedure glClearStencil(s: GLint); stdcall; external libGL;
//  procedure glClearDepth(depth: GLdouble); stdcall; external libGL;
  procedure glStencilMask(mask: GLuint); stdcall; external libGL;
//  procedure glColorMask(red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean); stdcall; external libGL;
//  procedure glDepthMask(flag: GLboolean); stdcall; external libGL;
//  procedure glDisable(cap: GLenum); stdcall; external libGL;
//  procedure glEnable(cap: GLenum); stdcall; external libGL;
  procedure glFinish; stdcall; external libGL;
  procedure glFlush; stdcall; external libGL;
//  procedure glBlendFunc(sfactor: GLenum; dfactor: GLenum); stdcall; external libGL;
  procedure glLogicOp(opcode: GLenum); stdcall; external libGL;
  procedure glStencilFunc(func: GLenum; ref: GLint; mask: GLuint); stdcall; external libGL;
  procedure glStencilOp(fail: GLenum; zfail: GLenum; zpass: GLenum); stdcall; external libGL;
//  procedure glDepthFunc(func: GLenum); stdcall; external libGL;
//  procedure glPixelStoref(pname: GLenum; param: GLfloat); stdcall; external libGL;
//  procedure glPixelStorei(pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glReadBuffer(src: GLenum); stdcall; external libGL;
//  procedure glReadPixels(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; pixels: pointer); stdcall; external libGL;
  procedure glGetBooleanv(pname: GLenum; data: PGLboolean); stdcall; external libGL;
  procedure glGetDoublev(pname: GLenum; data: PGLdouble); stdcall; external libGL;
  function glGetError: GLenum; stdcall; external libGL;
//  procedure glGetFloatv(pname: GLenum; data: PGLfloat); stdcall; external libGL;
//  procedure glGetIntegerv(pname: GLenum; data: PGLint); stdcall; external libGL;
//  function glGetString(name: GLenum): PAnsiChar; stdcall; external libGL;
//  procedure glGetTexImage(target: GLenum; level: GLint; format: GLenum; _type: GLenum; pixels: pointer); stdcall; external libGL;
  procedure glGetTexParameterfv(target: GLenum; pname: GLenum; params: PGLfloat); stdcall; external libGL;
  procedure glGetTexParameteriv(target: GLenum; pname: GLenum; params: PGLint); stdcall; external libGL;
  procedure glGetTexLevelParameterfv(target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); stdcall; external libGL;
  procedure glGetTexLevelParameteriv(target: GLenum; level: GLint; pname: GLenum; params: PGLint); stdcall; external libGL;
  function glIsEnabled(cap: GLenum): GLboolean; stdcall; external libGL;
//  procedure glDepthRange(n: GLdouble; f: GLdouble); stdcall; external libGL;
//  procedure glViewport(x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall; external libGL;
  {$EndIf}

  {$IfDef GL_VERSION_1_1}
//  glDrawArrays: procedure(mode: GLenum; first: GLint; count: GLsizei); stdcall;  external libGL;  // + EXT
//  glDrawElements: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer); stdcall; external libGL;
  procedure glGetPointerv(pname: GLenum; params:Ppointer); stdcall; external libGL;
  procedure glPolygonOffset(factor: GLfloat; units: GLfloat); stdcall; external libGL;
  procedure glCopyTexImage1D(target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint); stdcall; external libGL;
  procedure glCopyTexImage2D(target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint); stdcall; external libGL;
  procedure glCopyTexSubImage1D(target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei); stdcall;  external libGL; // +EXT
//  procedure glCopyTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;  external libGL; // + EXT
  procedure glTexSubImage1D(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;  external libGL;     // + EXT
//  procedure glTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;  external libGL; // +EXT
//  procedure glBindTexture(target: GLenum; texture: GLuint); stdcall;  external libGL;        // + EXT
//  procedure glDeleteTextures(n: GLsizei; const textures: PGLuint); stdcall;  external libGL; // + EXT
//  procedure glGenTextures(n: GLsizei; textures: PGLuint); stdcall;  external libGL;          // + EXT
  function glIsTexture(texture: GLuint): GLboolean; stdcall; external libGL;
  {$EndIf}

  {$IfDef GL_VERSION_1_2}
//  procedure glDrawRangeElements(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; _type: GLenum; const indices: pointer); stdcall;  external libGL;// + EXT
  procedure glTexImage3D(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall; external libGL;
  procedure glTexSubImage3D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall; external libGL;
  procedure glCopyTexSubImage3D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall; external libGL;
  {$EndIf}

  {$IfDef GL_VERSION_1_3}
  procedure glActiveTexture(texture: GLenum); stdcall;        external libGL;
  procedure glSampleCoverage(value: GLfloat; invert: GLboolean); stdcall; external libGL;
  procedure glCompressedTexImage3D(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; const data: pointer); stdcall; external libGL;
//  procedure glCompressedTexImage2D(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; const data: pointer); stdcall;  external libGL; // + ARB
  procedure glCompressedTexImage1D(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; const data: pointer); stdcall; external libGL;
  procedure glCompressedTexSubImage3D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall; external libGL;
  procedure glCompressedTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall; external libGL;
  procedure glCompressedTexSubImage1D(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall; external libGL;
  procedure glGetCompressedTexImage(target: GLenum; level: GLint; img: pointer); stdcall; external libGL;
  {$IfNDef USE_GLCORE}
  procedure glClientActiveTexture(texture: GLenum); stdcall; external libGL;
  procedure glMultiTexCoord1d(target: GLenum; s: GLdouble); stdcall; external libGL;
  procedure glMultiTexCoord1dv(target: GLenum; const v: PGLdouble); stdcall; external libGL;
  procedure glMultiTexCoord1f(target: GLenum; s: GLfloat); stdcall; external libGL;
  procedure glMultiTexCoord1fv(target: GLenum; const v: PGLfloat); stdcall; external libGL;
  procedure glMultiTexCoord1i(target: GLenum; s: GLint); stdcall; external libGL;
  procedure glMultiTexCoord1iv(target: GLenum; const v: PGLint); stdcall; external libGL;
  procedure glMultiTexCoord1s(target: GLenum; s: GLshort); stdcall; external libGL;
  procedure glMultiTexCoord1sv(target: GLenum; const v: PGLshort); stdcall; external libGL;
  procedure glMultiTexCoord2d(target: GLenum; s: GLdouble; t: GLdouble); stdcall; external libGL;
  procedure glMultiTexCoord2dv(target: GLenum; const v: PGLdouble); stdcall; external libGL;
  procedure glMultiTexCoord2f(target: GLenum; s: GLfloat; t: GLfloat); stdcall; external libGL;
  procedure glMultiTexCoord2fv(target: GLenum; const v: PGLfloat); stdcall; external libGL;
  procedure glMultiTexCoord2i(target: GLenum; s: GLint; t: GLint); stdcall; external libGL;
  procedure glMultiTexCoord2iv(target: GLenum; const v: PGLint); stdcall; external libGL;
  procedure glMultiTexCoord2s(target: GLenum; s: GLshort; t: GLshort); stdcall; external libGL;
  procedure glMultiTexCoord2sv(target: GLenum; const v: PGLshort); stdcall; external libGL;
  procedure glMultiTexCoord3d(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble); stdcall; external libGL;
  procedure glMultiTexCoord3dv(target: GLenum; const v: PGLdouble); stdcall; external libGL;
  procedure glMultiTexCoord3f(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat); stdcall; external libGL;
  procedure glMultiTexCoord3fv(target: GLenum; const v: PGLfloat); stdcall; external libGL;
  procedure glMultiTexCoord3i(target: GLenum; s: GLint; t: GLint; r: GLint); stdcall; external libGL;
  procedure glMultiTexCoord3iv(target: GLenum; const v: PGLint); stdcall; external libGL;
  procedure glMultiTexCoord3s(target: GLenum; s: GLshort; t: GLshort; r: GLshort); stdcall; external libGL;
  procedure glMultiTexCoord3sv(target: GLenum; const v: PGLshort); stdcall; external libGL;
  procedure glMultiTexCoord4d(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble); stdcall; external libGL;
  procedure glMultiTexCoord4dv(target: GLenum; const v: PGLdouble); stdcall; external libGL;
  procedure glMultiTexCoord4f(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat); stdcall; external libGL;
  procedure glMultiTexCoord4fv(target: GLenum; const v: PGLfloat); stdcall; external libGL;
  procedure glMultiTexCoord4i(target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint); stdcall; external libGL;
  procedure glMultiTexCoord4iv(target: GLenum; const v: PGLint); stdcall; external libGL;
  procedure glMultiTexCoord4s(target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort); stdcall; external libGL;
  procedure glMultiTexCoord4sv(target: GLenum; const v: PGLshort); stdcall; external libGL;
  procedure glLoadTransposeMatrixf(const m: PGLfloat); stdcall; external libGL;
  procedure glLoadTransposeMatrixd(const m: PGLdouble); stdcall; external libGL;
  procedure glMultTransposeMatrixf(const m: PGLfloat); stdcall; external libGL;
  procedure glMultTransposeMatrixd(const m: PGLdouble); stdcall; external libGL;
  {$EndIf}
  {$EndIf}

  {$If defined(GL_VERSION_1_4) or defined(GL_EXT_blend_func_separate)}
//  glBlendFuncSeparate: procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall;
  {$IfEnd}
  {$If defined(GL_VERSION_1_4) or defined(GL_EXT_blend_minmax)}
//  glBlendEquation: procedure(mode: GLenum); stdcall;  // + EXT
  {$IfEnd}
  {$IfDef GL_VERSION_1_4}
var
  glMultiDrawArrays: procedure(mode: GLenum; const first: PGLint; const count: PGLsizei; drawcount: GLsizei); stdcall;
//  glMultiDrawElements: procedure(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: {P}Ppointer; drawcount: GLsizei); stdcall; // + EXT
  glPointParameterf: procedure(pname: GLenum; param: GLfloat); stdcall;
  glPointParameterfv: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  glPointParameteri: procedure(pname: GLenum; param: GLint); stdcall;
  glPointParameteriv: procedure(pname: GLenum; const params: PGLint); stdcall;
  glBlendColor: procedure(red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat); stdcall;      // + GL_EXT_blend_color  + GL_OES_fixed_point
  {$IfNDef USE_GLCORE}
  glFogCoordf: procedure(coord: GLfloat); stdcall;
  glFogCoordfv: procedure(const coord: PGLfloat); stdcall;
  glFogCoordd: procedure(coord: GLdouble); stdcall;
  glFogCoorddv: procedure(const coord: PGLdouble); stdcall;
//  glFogCoordPointer: procedure(_type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall; // + EXT
  glSecondaryColor3b: procedure(red: GLbyte; green: GLbyte; blue: GLbyte); stdcall;
  glSecondaryColor3bv: procedure(const v: PGLbyte); stdcall;
  glSecondaryColor3d: procedure(red: GLdouble; green: GLdouble; blue: GLdouble); stdcall;
  glSecondaryColor3dv: procedure(const v: PGLdouble); stdcall;
  glSecondaryColor3f: procedure(red: GLfloat; green: GLfloat; blue: GLfloat); stdcall;
  glSecondaryColor3fv: procedure(const v: PGLfloat); stdcall;
  glSecondaryColor3i: procedure(red: GLint; green: GLint; blue: GLint); stdcall;
  glSecondaryColor3iv: procedure(const v: PGLint); stdcall;
  glSecondaryColor3s: procedure(red: GLshort; green: GLshort; blue: GLshort); stdcall;
  glSecondaryColor3sv: procedure(const v: PGLshort); stdcall;
  glSecondaryColor3ub: procedure(red: GLubyte; green: GLubyte; blue: GLubyte); stdcall;
  glSecondaryColor3ubv: procedure(const v: PGLubyte); stdcall;
  glSecondaryColor3ui: procedure(red: GLuint; green: GLuint; blue: GLuint); stdcall;
  glSecondaryColor3uiv: procedure(const v: PGLuint); stdcall;
  glSecondaryColor3us: procedure(red: GLushort; green: GLushort; blue: GLushort); stdcall;
  glSecondaryColor3usv: procedure(const v: PGLushort); stdcall;
//  glSecondaryColorPointer: procedure(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall; // + EXT
  glWindowPos2d: procedure(x: GLdouble; y: GLdouble); stdcall;
  glWindowPos2dv: procedure(const v: PGLdouble); stdcall;
  glWindowPos2f: procedure(x: GLfloat; y: GLfloat); stdcall;
  glWindowPos2fv: procedure(const v: PGLfloat); stdcall;
  glWindowPos2i: procedure(x: GLint; y: GLint); stdcall;
  glWindowPos2iv: procedure(const v: PGLint); stdcall;
  glWindowPos2s: procedure(x: GLshort; y: GLshort); stdcall;
  glWindowPos2sv: procedure(const v: PGLshort); stdcall;
  glWindowPos3d: procedure(x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glWindowPos3dv: procedure(const v: PGLdouble); stdcall;
  glWindowPos3f: procedure(x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glWindowPos3fv: procedure(const v: PGLfloat); stdcall;
  glWindowPos3i: procedure(x: GLint; y: GLint; z: GLint); stdcall;
  glWindowPos3iv: procedure(const v: PGLint); stdcall;
  glWindowPos3s: procedure(x: GLshort; y: GLshort; z: GLshort); stdcall;
  glWindowPos3sv: procedure(const v: PGLshort); stdcall;
  {$EndIf}
  {$EndIf}

  {$IfDef GL_VERSION_1_5}
var
  glGenQueries: procedure(n: GLsizei; const ids: PGLuint); stdcall;
  glDeleteQueries: procedure(n: GLsizei; ids: PGLuint); stdcall;
  glIsQuery: function(id: GLuint): GLboolean; stdcall;
  glBeginQuery: procedure(target: GLenum; id: GLuint); stdcall;
  glEndQuery: procedure(target: GLenum); stdcall;
  glGetQueryiv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetQueryObjectiv: procedure(id: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetQueryObjectuiv: procedure(id: GLuint; pname: GLenum; params: PGLuint); stdcall;
  glBindBuffer: procedure(target: GLenum; buffer: GLuint); stdcall;
  glDeleteBuffers: procedure(n: GLsizei; const buffers: PGLuint); stdcall;
  glGenBuffers: procedure(n: GLsizei; buffers: PGLuint); stdcall;
  glIsBuffer: function(buffer: GLuint): GLboolean; stdcall;
  glBufferData: procedure(target: GLenum; size: GLsizeiptr; const data: pointer; usage: GLenum); stdcall;
  glBufferSubData: procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr; const data: pointer); stdcall;
  glGetBufferSubData: procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr; const data: pointer); stdcall;
  glMapBuffer: function(target: GLenum; access: GLenum): pointer; stdcall;
  glUnmapBuffer: function(target: GLenum): GLboolean; stdcall;
  glGetBufferParameteriv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetBufferPointerv: procedure(target: GLenum; pname: GLenum; params:Ppointer); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_2_0}
var
  glBlendEquationSeparate: procedure(modeRGB: GLenum; modeAlpha: GLenum); stdcall; // + GL_EXT_blend_equation_separate
  glDrawBuffers: procedure(n: GLsizei; const bufs: PGLenum); stdcall;
  glStencilOpSeparate: procedure(face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum); stdcall;
  glStencilFuncSeparate: procedure(face: GLenum; func: GLenum; ref: GLint; mask: GLuint); stdcall;
  glStencilMaskSeparate: procedure(face: GLenum; mask: GLuint); stdcall;
  glAttachShader: procedure(_program: GLuint; shader: GLuint); stdcall;
  glBindAttribLocation: procedure(_program: GLuint; index: GLuint; const name: PGLchar); stdcall;
  glCompileShader: procedure(shader: GLuint); stdcall;
  glCreateProgram: function : GLuint; stdcall;
  glCreateShader: function(_type: GLenum): GLuint; stdcall;
  glDeleteProgram: procedure(_program: GLuint); stdcall;
  glDeleteShader: procedure(shader: GLuint); stdcall;
  glDetachShader: procedure(_program: GLuint; shader: GLuint); stdcall;
  glDisableVertexAttribArray: procedure(index: GLuint); stdcall;
  glEnableVertexAttribArray: procedure(index: GLuint); stdcall;
  glGetActiveAttrib: procedure(_program: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLint; _type: PGLenum; name: PGLchar); stdcall;
  glGetActiveUniform: procedure(_program: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLint; _type: PGLenum; name: PGLchar); stdcall;
  glGetAttachedShaders: procedure(_program: GLuint; maxCount: GLsizei; count: PGLsizei; shaders: PGLuint); stdcall;
  glGetAttribLocation: function(_program: GLuint; const name: PGLchar): GLint; stdcall;
  glGetProgramiv: procedure(_program: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetProgramInfoLog: procedure(_program: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); stdcall;
  glGetShaderiv: procedure(shader: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetShaderInfoLog: procedure(shader: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); stdcall;
  glGetShaderSource: procedure(shader: GLuint; bufSize: GLsizei; length: PGLsizei; source: PGLchar); stdcall;
  glGetUniformLocation: function(_program: GLuint; const name: PGLchar): GLint; stdcall;
  glGetUniformfv: procedure(_program: GLuint; location: GLint; params: PGLfloat); stdcall;
  glGetUniformiv: procedure(_program: GLuint; location: GLint; params: PGLint); stdcall;
  glGetVertexAttribdv: procedure(index: GLuint; pname: GLenum; params: PGLdouble); stdcall;
  glGetVertexAttribfv: procedure(index: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetVertexAttribiv: procedure(index: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVertexAttribPointerv: procedure(index: GLuint; pname: GLenum; pointer:Ppointer); stdcall;
  glIsProgram: function(_program: GLuint): GLboolean; stdcall;
  glIsShader: function(shader: GLuint): GLboolean; stdcall;
  glLinkProgram: procedure(_program: GLuint); stdcall;
  glShaderSource: procedure(shader: GLuint; count: GLsizei; const _string: PPGLchar; const length: PGLint); stdcall;
  glUseProgram: procedure(_program: GLuint); stdcall;
  glUniform1f: procedure(location: GLint; v0: GLfloat); stdcall;
  glUniform2f: procedure(location: GLint; v0: GLfloat; v1: GLfloat); stdcall;
  glUniform3f: procedure(location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); stdcall;
  glUniform4f: procedure(location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); stdcall;
  glUniform1i: procedure(location: GLint; v0: GLint); stdcall;
  glUniform2i: procedure(location: GLint; v0: GLint; v1: GLint); stdcall;
  glUniform3i: procedure(location: GLint; v0: GLint; v1: GLint; v2: GLint); stdcall;
  glUniform4i: procedure(location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); stdcall;
  glUniform1fv: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform2fv: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform3fv: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform4fv: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform1iv: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniform2iv: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniform3iv: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniform4iv: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniformMatrix2fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix3fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix4fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glValidateProgram: procedure(_program: GLuint); stdcall;
  glVertexAttrib1d: procedure(index: GLuint; x: GLdouble); stdcall;
  glVertexAttrib1dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib1f: procedure(index: GLuint; x: GLfloat); stdcall;
  glVertexAttrib1fv: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib1s: procedure(index: GLuint; x: GLshort); stdcall;
  glVertexAttrib1sv: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib2d: procedure(index: GLuint; x: GLdouble; y: GLdouble); stdcall;
  glVertexAttrib2dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib2f: procedure(index: GLuint; x: GLfloat; y: GLfloat); stdcall;
  glVertexAttrib2fv: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib2s: procedure(index: GLuint; x: GLshort; y: GLshort); stdcall;
  glVertexAttrib2sv: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib3d: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glVertexAttrib3dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib3f: procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glVertexAttrib3fv: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib3s: procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort); stdcall;
  glVertexAttrib3sv: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4Nbv: procedure(index: GLuint; const v: PGLbyte); stdcall;
  glVertexAttrib4Niv: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttrib4Nsv: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4Nub: procedure(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte); stdcall;
  glVertexAttrib4Nubv: procedure(index: GLuint; const v: PGLubyte); stdcall;
  glVertexAttrib4Nuiv: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttrib4Nusv: procedure(index: GLuint; const v: PGLushort); stdcall;
  glVertexAttrib4bv: procedure(index: GLuint; const v: PGLbyte); stdcall;
  glVertexAttrib4d: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glVertexAttrib4dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib4f: procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glVertexAttrib4fv: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib4iv: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttrib4s: procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort); stdcall;
  glVertexAttrib4sv: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4ubv: procedure(index: GLuint; const v: PGLubyte); stdcall;
  glVertexAttrib4uiv: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttrib4usv: procedure(index: GLuint; const v: PGLushort); stdcall;
  glVertexAttribPointer: procedure(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei; const _pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_2_1}
var
  glUniformMatrix2x3fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix3x2fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix2x4fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix4x2fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix3x4fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix4x3fv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  {$EndIf}

  {$If defined(GL_VERSION_3_0) or defined(GL_EXT_framebuffer_object)}
//var
//  glIsRenderbuffer: function(renderbuffer: GLuint): GLboolean; stdcall;
//  glBindRenderbuffer: procedure(target: GLenum; renderbuffer: GLuint); stdcall;
//  glDeleteRenderbuffers: procedure(n: GLsizei; const renderbuffers: PGLuint); stdcall;
//  glGenRenderbuffers: procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
//  glRenderbufferStorage: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
//  glIsFramebuffer: function(framebuffer: GLuint): GLboolean; stdcall;
//  glBindFramebuffer: procedure(target: GLenum; framebuffer: GLuint); stdcall;
//  glDeleteFramebuffers: procedure(n: GLsizei; const framebuffers: PGLuint); stdcall;
//  glGenFramebuffers: procedure(n: GLsizei; framebuffers: PGLuint); stdcall;
//  glCheckFramebufferStatus: function(target: GLenum): GLenum; stdcall;
//  glFramebufferTexture2D: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
//  glFramebufferRenderbuffer: procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;
  {$IfEnd}

  {$IfDef GL_VERSION_3_0}
var
  glColorMaski: procedure(index: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean); stdcall;
  glGetBooleani_v: procedure(target: GLenum; index: GLuint; data: PGLboolean); stdcall;
  glGetIntegeri_v: procedure(target: GLenum; index: GLuint; data: PGLint); stdcall;
  glEnablei: procedure(target: GLenum; index: GLuint); stdcall;
  glDisablei: procedure(target: GLenum; index: GLuint); stdcall;
  glIsEnabledi: function(target: GLenum; index: GLuint): GLboolean; stdcall;
  glBeginTransformFeedback: procedure(primitiveMode: GLenum); stdcall;
  glEndTransformFeedback: procedure;
  glBindBufferRange: procedure(target: GLenum; index: GLuint; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); stdcall;
  glBindBufferBase: procedure(target: GLenum; index: GLuint; buffer: GLuint); stdcall;
  glTransformFeedbackVaryings: procedure(_program: GLuint; count: GLsizei; const varyings: PPGLchar; bufferMode: GLenum); stdcall;
  glGetTransformFeedbackVarying: procedure(_program: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; _type: PGLenum; name: PGLchar); stdcall;
  glClampColor: procedure(target: GLenum; clamp: GLenum); stdcall;
  glBeginConditionalRender: procedure(id: GLuint; mode: GLenum); stdcall;
  glEndConditionalRender: procedure;
  glVertexAttribIPointer: procedure(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glGetVertexAttribIiv: procedure(index: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVertexAttribIuiv: procedure(index: GLuint; pname: GLenum; params: PGLuint); stdcall;
  glVertexAttribI1i: procedure(index: GLuint; x: GLint); stdcall;
  glVertexAttribI2i: procedure(index: GLuint; x: GLint; y: GLint); stdcall;
  glVertexAttribI3i: procedure(index: GLuint; x: GLint; y: GLint; z: GLint); stdcall;
  glVertexAttribI4i: procedure(index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); stdcall;
  glVertexAttribI1ui: procedure(index: GLuint; x: GLuint); stdcall;
  glVertexAttribI2ui: procedure(index: GLuint; x: GLuint; y: GLuint); stdcall;
  glVertexAttribI3ui: procedure(index: GLuint; x: GLuint; y: GLuint; z: GLuint); stdcall;
  glVertexAttribI4ui: procedure(index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); stdcall;
  glVertexAttribI1iv: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI2iv: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI3iv: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI4iv: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI1uiv: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI2uiv: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI3uiv: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI4uiv: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI4bv: procedure(index: GLuint; const v: PGLbyte); stdcall;
  glVertexAttribI4sv: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttribI4ubv: procedure(index: GLuint; const v: PGLubyte); stdcall;
  glVertexAttribI4usv: procedure(index: GLuint; const v: PGLushort); stdcall;
  glGetUniformuiv: procedure(_program: GLuint; location: GLint; params: PGLuint); stdcall;
  glBindFragDataLocation: procedure(_program: GLuint; color: GLuint; const name: PGLchar); stdcall;
  glGetFragDataLocation: function(_program: GLuint; const name: PGLchar): GLint; stdcall;
  glUniform1ui: procedure(location: GLint; v0: GLuint); stdcall;
  glUniform2ui: procedure(location: GLint; v0: GLuint; v1: GLuint); stdcall;
  glUniform3ui: procedure(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); stdcall;
  glUniform4ui: procedure(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); stdcall;
  glUniform1uiv: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glUniform2uiv: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glUniform3uiv: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glUniform4uiv: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glTexParameterIiv: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glTexParameterIuiv: procedure(target: GLenum; pname: GLenum; const params: PGLuint); stdcall;
  glGetTexParameterIiv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetTexParameterIuiv: procedure(target: GLenum; pname: GLenum; params: PGLuint); stdcall;
  glClearBufferiv: procedure(buffer: GLenum; drawbuffer: GLint; const value: PGLint); stdcall;
  glClearBufferuiv: procedure(buffer: GLenum; drawbuffer: GLint; const value: PGLuint); stdcall;
  glClearBufferfv: procedure(buffer: GLenum; drawbuffer: GLint; const value: PGLfloat); stdcall;
  glClearBufferfi: procedure(buffer: GLenum; drawbuffer: GLint; depth: GLfloat; stencil: GLint); stdcall;
  glGetStringi: function(name: GLenum; index: GLuint): PGLubyte; stdcall;
//  glIsRenderbuffer: function(renderbuffer: GLuint): GLboolean; stdcall;
//  glBindRenderbuffer: procedure(target: GLenum; renderbuffer: GLuint); stdcall;
//  glDeleteRenderbuffers: procedure(n: GLsizei; const renderbuffers: PGLuint); stdcall;
//  glGenRenderbuffers: procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
//  glRenderbufferStorage: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glGetRenderbufferParameteriv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
//  glIsFramebuffer: function(framebuffer: GLuint): GLboolean; stdcall;
//  glBindFramebuffer: procedure(target: GLenum; framebuffer: GLuint); stdcall;
//  glDeleteFramebuffers: procedure(n: GLsizei; const framebuffers: PGLuint); stdcall;
//  glGenFramebuffers: procedure(n: GLsizei; framebuffers: PGLuint); stdcall;
//  glCheckFramebufferStatus: function(target: GLenum): GLenum; stdcall;
  glFramebufferTexture1D: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
//  glFramebufferTexture2D: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
  glFramebufferTexture3D: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint); stdcall;
//  glFramebufferRenderbuffer: procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;
  glGetFramebufferAttachmentParameteriv: procedure(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGenerateMipmap: procedure(target: GLenum); stdcall;
  glBlitFramebuffer: procedure(srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); stdcall;
  glRenderbufferStorageMultisample: procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glFramebufferTextureLayer: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); stdcall;
  glMapBufferRange: function(target: GLenum; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): pointer; stdcall;
  glFlushMappedBufferRange: procedure(target: GLenum; offset: GLintptr; length: GLsizeiptr); stdcall;
  glBindVertexArray: procedure(_array: GLuint); stdcall;
  glDeleteVertexArrays: procedure(n: GLsizei; const arrays: PGLuint); stdcall;
  glGenVertexArrays: procedure(n: GLsizei; arrays: PGLuint); stdcall;
  glIsVertexArray: function(_array: GLuint): GLboolean; stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_3_1}
var
  glDrawArraysInstanced: procedure(mode: GLenum; first: GLint; count: GLsizei; instancecount: GLsizei); stdcall;
  glDrawElementsInstanced: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer; instancecount: GLsizei); stdcall;
  glTexBuffer: procedure(target: GLenum; internalformat: GLenum; buffer: GLuint); stdcall;
  glPrimitiveRestartIndex: procedure(index: GLuint); stdcall;
  glCopyBufferSubData: procedure(readTarget: GLenum; writeTarget: GLenum; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr); stdcall;
  glGetUniformIndices: procedure(_program: GLuint; uniformCount: GLsizei; const uniformNames: PPGLchar; uniformIndices: PGLuint); stdcall;
  glGetActiveUniformsiv: procedure(_program: GLuint; uniformCount: GLsizei; const uniformIndices: PGLuint; pname: GLenum; params: PGLint); stdcall;
  glGetActiveUniformName: procedure(_program: GLuint; uniformIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformName: PGLchar); stdcall;
  glGetUniformBlockIndex: function(_program: GLuint; const uniformBlockName: PGLchar): GLuint; stdcall;
  glGetActiveUniformBlockiv: procedure(_program: GLuint; uniformBlockIndex: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetActiveUniformBlockName: procedure(_program: GLuint; uniformBlockIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformBlockName: PGLchar); stdcall;
  glUniformBlockBinding: procedure(_program: GLuint; uniformBlockIndex: GLuint; uniformBlockBinding: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_3_2}
var
  glDrawElementsBaseVertex: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer; basevertex: GLint); stdcall;
  glDrawRangeElementsBaseVertex: procedure(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; _type: GLenum; const indices: pointer; basevertex: GLint); stdcall;
  glDrawElementsInstancedBaseVertex: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer; instancecount: GLsizei; basevertex: GLint); stdcall;
  glMultiDrawElementsBaseVertex: procedure(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: {P}Ppointer; drawcount: GLsizei; const basevertex: PGLint); stdcall;
  glProvokingVertex: procedure(mode: GLenum); stdcall;
  glFenceSync: function(condition: GLenum; flags: GLbitfield): GLsync; stdcall;
  glIsSync: function(sync: GLsync): GLboolean; stdcall;
  glDeleteSync: procedure(sync: GLsync); stdcall;
  glClientWaitSync: function(sync: GLsync; flags: GLbitfield; timeout: GLuint64): GLenum; stdcall;
  glWaitSync: procedure(sync: GLsync; flags: GLbitfield; timeout: GLuint64); stdcall;
  glGetInteger64v: procedure(pname: GLenum; data: PGLint64); stdcall;
  glGetSynciv: procedure(sync: GLsync; pname: GLenum; count: GLsizei; length: PGLsizei; values: PGLint); stdcall;
  glGetInteger64i_v: procedure(target: GLenum; index: GLuint; data: PGLint64); stdcall;
  glGetBufferParameteri64v: procedure(target: GLenum; pname: GLenum; params: PGLint64); stdcall;
  glFramebufferTexture: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); stdcall;
  glTexImage2DMultisample: procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glTexImage3DMultisample: procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glGetMultisamplefv: procedure(pname: GLenum; index: GLuint; val: PGLfloat); stdcall;
  glSampleMaski: procedure(maskNumber: GLuint; mask: GLbitfield); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_3_3}
var
  glBindFragDataLocationIndexed: procedure(_program: GLuint; colorNumber: GLuint; index: GLuint; const name: PGLchar); stdcall;
  glGetFragDataIndex: function(_program: GLuint; const name: PGLchar): GLint; stdcall;
  glGenSamplers: procedure(count: GLsizei; samplers: PGLuint); stdcall;
  glDeleteSamplers: procedure(count: GLsizei; const samplers: PGLuint); stdcall;
  glIsSampler: function(sampler: GLuint): GLboolean; stdcall;
  glBindSampler: procedure(_unit: GLuint; sampler: GLuint); stdcall;
  glSamplerParameteri: procedure(sampler: GLuint; pname: GLenum; param: GLint); stdcall;
  glSamplerParameteriv: procedure(sampler: GLuint; pname: GLenum; const param: PGLint); stdcall;
  glSamplerParameterf: procedure(sampler: GLuint; pname: GLenum; param: GLfloat); stdcall;
  glSamplerParameterfv: procedure(sampler: GLuint; pname: GLenum; const param: PGLfloat); stdcall;
  glSamplerParameterIiv: procedure(sampler: GLuint; pname: GLenum; const param: PGLint); stdcall;
  glSamplerParameterIuiv: procedure(sampler: GLuint; pname: GLenum; const param: PGLuint); stdcall;
  glGetSamplerParameteriv: procedure(sampler: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetSamplerParameterIiv: procedure(sampler: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetSamplerParameterfv: procedure(sampler: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetSamplerParameterIuiv: procedure(sampler: GLuint; pname: GLenum; params: PGLuint); stdcall;
  glQueryCounter: procedure(id: GLuint; target: GLenum); stdcall;
  glGetQueryObjecti64v: procedure(id: GLuint; pname: GLenum; params: PGLint64); stdcall;
  glGetQueryObjectui64v: procedure(id: GLuint; pname: GLenum; params: PGLuint64); stdcall;
  glVertexAttribDivisor: procedure(index: GLuint; divisor: GLuint); stdcall;
  glVertexAttribP1ui: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; value: GLuint); stdcall;
  glVertexAttribP1uiv: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; const value: PGLuint); stdcall;
  glVertexAttribP2ui: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; value: GLuint); stdcall;
  glVertexAttribP2uiv: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; const value: PGLuint); stdcall;
  glVertexAttribP3ui: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; value: GLuint); stdcall;
  glVertexAttribP3uiv: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; const value: PGLuint); stdcall;
  glVertexAttribP4ui: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; value: GLuint); stdcall;
  glVertexAttribP4uiv: procedure(index: GLuint; _type: GLenum; normalized: GLboolean; const value: PGLuint); stdcall;
  {$IfNDef USE_GLCORE}
  glVertexP2ui: procedure(_type: GLenum; value: GLuint); stdcall;
  glVertexP2uiv: procedure(_type: GLenum; const value: PGLuint); stdcall;
  glVertexP3ui: procedure(_type: GLenum; value: GLuint); stdcall;
  glVertexP3uiv: procedure(_type: GLenum; const value: PGLuint); stdcall;
  glVertexP4ui: procedure(_type: GLenum; value: GLuint); stdcall;
  glVertexP4uiv: procedure(_type: GLenum; const value: PGLuint); stdcall;
  glTexCoordP1ui: procedure(_type: GLenum; coords: GLuint); stdcall;
  glTexCoordP1uiv: procedure(_type: GLenum; const coords: PGLuint); stdcall;
  glTexCoordP2ui: procedure(_type: GLenum; coords: GLuint); stdcall;
  glTexCoordP2uiv: procedure(_type: GLenum; const coords: PGLuint); stdcall;
  glTexCoordP3ui: procedure(_type: GLenum; coords: GLuint); stdcall;
  glTexCoordP3uiv: procedure(_type: GLenum; const coords: PGLuint); stdcall;
  glTexCoordP4ui: procedure(_type: GLenum; coords: GLuint); stdcall;
  glTexCoordP4uiv: procedure(_type: GLenum; const coords: PGLuint); stdcall;
  glMultiTexCoordP1ui: procedure(texture: GLenum; _type: GLenum; coords: GLuint); stdcall;
  glMultiTexCoordP1uiv: procedure(texture: GLenum; _type: GLenum; const coords: PGLuint); stdcall;
  glMultiTexCoordP2ui: procedure(texture: GLenum; _type: GLenum; coords: GLuint); stdcall;
  glMultiTexCoordP2uiv: procedure(texture: GLenum; _type: GLenum; const coords: PGLuint); stdcall;
  glMultiTexCoordP3ui: procedure(texture: GLenum; _type: GLenum; coords: GLuint); stdcall;
  glMultiTexCoordP3uiv: procedure(texture: GLenum; _type: GLenum; const coords: PGLuint); stdcall;
  glMultiTexCoordP4ui: procedure(texture: GLenum; _type: GLenum; coords: GLuint); stdcall;
  glMultiTexCoordP4uiv: procedure(texture: GLenum; _type: GLenum; const coords: PGLuint); stdcall;
  glNormalP3ui: procedure(_type: GLenum; coords: GLuint); stdcall;
  glNormalP3uiv: procedure(_type: GLenum; const coords: PGLuint); stdcall;
  glColorP3ui: procedure(_type: GLenum; color: GLuint); stdcall;
  glColorP3uiv: procedure(_type: GLenum; const color: PGLuint); stdcall;
  glColorP4ui: procedure(_type: GLenum; color: GLuint); stdcall;
  glColorP4uiv: procedure(_type: GLenum; const color: PGLuint); stdcall;
  glSecondaryColorP3ui: procedure(_type: GLenum; color: GLuint); stdcall;
  glSecondaryColorP3uiv: procedure(_type: GLenum; const color: PGLuint); stdcall;
  {$EndIf}
  {$EndIf}

  {$IfDef GL_VERSION_4_0}
var
  glMinSampleShading: procedure(value: GLfloat); stdcall;
  glBlendEquationi: procedure(buf: GLuint; mode: GLenum); stdcall;
  glBlendEquationSeparatei: procedure(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); stdcall;
  glBlendFunci: procedure(buf: GLuint; src: GLenum; dst: GLenum); stdcall;
  glBlendFuncSeparatei: procedure(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); stdcall;
  glDrawArraysIndirect: procedure(mode: GLenum; const indirect: pointer); stdcall;
  glDrawElementsIndirect: procedure(mode: GLenum; _type: GLenum; const indirect: pointer); stdcall;
  glUniform1d: procedure(location: GLint; x: GLdouble); stdcall;
  glUniform2d: procedure(location: GLint; x: GLdouble; y: GLdouble); stdcall;
  glUniform3d: procedure(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glUniform4d: procedure(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glUniform1dv: procedure(location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glUniform2dv: procedure(location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glUniform3dv: procedure(location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glUniform4dv: procedure(location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glUniformMatrix2dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix3dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix4dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix2x3dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix2x4dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix3x2dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix3x4dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix4x2dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glUniformMatrix4x3dv: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glGetUniformdv: procedure(_program: GLuint; location: GLint; params: PGLdouble); stdcall;
  glGetSubroutineUniformLocation: function(_program: GLuint; shadertype: GLenum; const name: PGLchar): GLint; stdcall;
  glGetSubroutineIndex: function(_program: GLuint; shadertype: GLenum; const name: PGLchar): GLuint; stdcall;
  glGetActiveSubroutineUniformiv: procedure(_program: GLuint; shadertype: GLenum; index: GLuint; pname: GLenum; values: PGLint); stdcall;
  glGetActiveSubroutineUniformName: procedure(_program: GLuint; shadertype: GLenum; index: GLuint; bufSize: GLsizei; length: PGLsizei; name: PGLchar); stdcall;
  glGetActiveSubroutineName: procedure(_program: GLuint; shadertype: GLenum; index: GLuint; bufSize: GLsizei; length: PGLsizei; name: PGLchar); stdcall;
  glUniformSubroutinesuiv: procedure(shadertype: GLenum; count: GLsizei; const indices: PGLuint); stdcall;
  glGetUniformSubroutineuiv: procedure(shadertype: GLenum; location: GLint; params: PGLuint); stdcall;
  glGetProgramStageiv: procedure(_program: GLuint; shadertype: GLenum; pname: GLenum; values: PGLint); stdcall;
  glPatchParameteri: procedure(pname: GLenum; value: GLint); stdcall;
  glPatchParameterfv: procedure(pname: GLenum; const values: PGLfloat); stdcall;
  glBindTransformFeedback: procedure(target: GLenum; id: GLuint); stdcall;
  glDeleteTransformFeedbacks: procedure(n: GLsizei; const ids: PGLuint); stdcall;
  glGenTransformFeedbacks: procedure(n: GLsizei; ids: PGLuint); stdcall;
  glIsTransformFeedback: function(id: GLuint): GLboolean; stdcall;
  glPauseTransformFeedback: procedure; stdcall;
  glResumeTransformFeedback: procedure; stdcall;
  glDrawTransformFeedback: procedure(mode: GLenum; id: GLuint); stdcall;
  glDrawTransformFeedbackStream: procedure(mode: GLenum; id: GLuint; stream: GLuint); stdcall;
  glBeginQueryIndexed: procedure(target: GLenum; index: GLuint; id: GLuint); stdcall;
  glEndQueryIndexed: procedure(target: GLenum; index: GLuint); stdcall;
  glGetQueryIndexediv: procedure(target: GLenum; index: GLuint; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_4_1}
var
  glReleaseShaderCompiler: procedure; stdcall;
  glShaderBinary: procedure(count: GLsizei; const shaders: PGLuint; binaryFormat: GLenum; const binary: pointer; length: GLsizei); stdcall;
  glGetShaderPrecisionFormat: procedure(shadertype: GLenum; precisiontype: GLenum; range: PGLint; precision: PGLint); stdcall;
  glDepthRangef: procedure(n: GLfloat; f: GLfloat); stdcall;
  glClearDepthf: procedure(d: GLfloat); stdcall;
  glGetProgramBinary: procedure(_program: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: pointer); stdcall;
  glProgramBinary: procedure(_program: GLuint; binaryFormat: GLenum; const binary: pointer; length: GLsizei); stdcall;
  glProgramParameteri: procedure(_program: GLuint; pname: GLenum; value: GLint); stdcall;
  glUseProgramStages: procedure(pipeline: GLuint; stages: GLbitfield; _program: GLuint); stdcall;
  glActiveShaderProgram: procedure(pipeline: GLuint; _program: GLuint); stdcall;
  glCreateShaderProgramv: function(_type: GLenum; count: GLsizei; const strings: PPGLchar): GLuint; stdcall;
  glBindProgramPipeline: procedure(pipeline: GLuint); stdcall;
  glDeleteProgramPipelines: procedure(n: GLsizei; const pipelines: PGLuint); stdcall;
  glGenProgramPipelines: procedure(n: GLsizei; pipelines: PGLuint); stdcall;
  glIsProgramPipeline: function(pipeline: GLuint): GLboolean; stdcall;
  glGetProgramPipelineiv: procedure(pipeline: GLuint; pname: GLenum; params: PGLint); stdcall;
  glProgramUniform1i: procedure(_program: GLuint; location: GLint; v0: GLint); stdcall;
  glProgramUniform1iv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniform1f: procedure(_program: GLuint; location: GLint; v0: GLfloat); stdcall;
  glProgramUniform1fv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform1d: procedure(_program: GLuint; location: GLint; v0: GLdouble); stdcall;
  glProgramUniform1dv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniform1ui: procedure(_program: GLuint; location: GLint; v0: GLuint); stdcall;
  glProgramUniform1uiv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glProgramUniform2i: procedure(_program: GLuint; location: GLint; v0: GLint; v1: GLint); stdcall;
  glProgramUniform2iv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniform2f: procedure(_program: GLuint; location: GLint; v0: GLfloat; v1: GLfloat); stdcall;
  glProgramUniform2fv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform2d: procedure(_program: GLuint; location: GLint; v0: GLdouble; v1: GLdouble); stdcall;
  glProgramUniform2dv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniform2ui: procedure(_program: GLuint; location: GLint; v0: GLuint; v1: GLuint); stdcall;
  glProgramUniform2uiv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glProgramUniform3i: procedure(_program: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint); stdcall;
  glProgramUniform3iv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniform3f: procedure(_program: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); stdcall;
  glProgramUniform3fv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform3d: procedure(_program: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble); stdcall;
  glProgramUniform3dv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniform3ui: procedure(_program: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); stdcall;
  glProgramUniform3uiv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glProgramUniform4i: procedure(_program: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); stdcall;
  glProgramUniform4iv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniform4f: procedure(_program: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); stdcall;
  glProgramUniform4fv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform4d: procedure(_program: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble; v3: GLdouble); stdcall;
  glProgramUniform4dv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniform4ui: procedure(_program: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); stdcall;
  glProgramUniform4uiv: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glProgramUniformMatrix2fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix3fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix4fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix2dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix3dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix4dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix2x3fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix3x2fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix2x4fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix4x2fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix3x4fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix4x3fv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix2x3dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix3x2dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix2x4dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix4x2dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix3x4dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix4x3dv: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glValidateProgramPipeline: procedure(pipeline: GLuint); stdcall;
  glGetProgramPipelineInfoLog: procedure(pipeline: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); stdcall;
  glVertexAttribL1d: procedure(index: GLuint; x: GLdouble); stdcall;
  glVertexAttribL2d: procedure(index: GLuint; x: GLdouble; y: GLdouble); stdcall;
  glVertexAttribL3d: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glVertexAttribL4d: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glVertexAttribL1dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribL2dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribL3dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribL4dv: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribLPointer: procedure(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glGetVertexAttribLdv: procedure(index: GLuint; pname: GLenum; params: PGLdouble); stdcall;
  glViewportArrayv: procedure(first: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glViewportIndexedf: procedure(index: GLuint; x: GLfloat; y: GLfloat; w: GLfloat; h: GLfloat); stdcall;
  glViewportIndexedfv: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glScissorArrayv: procedure(first: GLuint; count: GLsizei; const v: PGLint); stdcall;
  glScissorIndexed: procedure(index: GLuint; left: GLint; bottom: GLint; width: GLsizei; height: GLsizei); stdcall;
  glScissorIndexedv: procedure(index: GLuint; const v: PGLint); stdcall;
  glDepthRangeArrayv: procedure(first: GLuint; count: GLsizei; const v: PGLdouble); stdcall;
  glDepthRangeIndexed: procedure(index: GLuint; n: GLdouble; f: GLdouble); stdcall;
  glGetFloati_v: procedure(target: GLenum; index: GLuint; data: PGLfloat); stdcall;
  glGetDoublei_v: procedure(target: GLenum; index: GLuint; data: PGLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_4_2}
var
  glDrawArraysInstancedBaseInstance: procedure(mode: GLenum; first: GLint; count: GLsizei; instancecount: GLsizei; baseinstance: GLuint);
  glDrawElementsInstancedBaseInstance: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer; instancecount: GLsizei; baseinstance: GLuint); stdcall;
  glDrawElementsInstancedBaseVertexBaseInstance: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer; instancecount: GLsizei; basevertex: GLint; baseinstance: GLuint); stdcall;
  glGetInternalformativ: procedure(target: GLenum; internalformat: GLenum; pname: GLenum; count: GLsizei; params: PGLint); stdcall;
  glGetActiveAtomicCounterBufferiv: procedure(_program: GLuint; bufferIndex: GLuint; pname: GLenum; params: PGLint); stdcall;
  glBindImageTexture: procedure(_unit: GLuint; texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; access: GLenum; format: GLenum); stdcall;
  glMemoryBarrier: procedure(barriers: GLbitfield); stdcall;
  glTexStorage1D: procedure(target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei); stdcall;
  glTexStorage2D: procedure(target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glTexStorage3D: procedure(target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei); stdcall;
  glDrawTransformFeedbackInstanced: procedure(mode: GLenum; id: GLuint; instancecount: GLsizei); stdcall;
  glDrawTransformFeedbackStreamInstanced: procedure(mode: GLenum; id: GLuint; stream: GLuint; instancecount: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_4_3}
var
  glClearBufferData: procedure(target: GLenum; internalformat: GLenum; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glClearBufferSubData: procedure(target: GLenum; internalformat: GLenum; offset: GLintptr; size: GLsizeiptr; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glDispatchCompute: procedure(num_groups_x: GLuint; num_groups_y: GLuint; num_groups_z: GLuint); stdcall;
  glDispatchComputeIndirect: procedure(indirect: GLintptr); stdcall;
  glCopyImageSubData: procedure(srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; srcWidth: GLsizei; srcHeight: GLsizei; srcDepth: GLsizei); stdcall;
  glFramebufferParameteri: procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;
  glGetFramebufferParameteriv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetInternalformati64v: procedure(target: GLenum; internalformat: GLenum; pname: GLenum; count: GLsizei; params: PGLint64); stdcall;
  glInvalidateTexSubImage: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei); stdcall;
  glInvalidateTexImage: procedure(texture: GLuint; level: GLint); stdcall;
  glInvalidateBufferSubData: procedure(buffer: GLuint; offset: GLintptr; length: GLsizeiptr); stdcall;
  glInvalidateBufferData: procedure(buffer: GLuint); stdcall;
  glInvalidateFramebuffer: procedure(target: GLenum; numAttachments: GLsizei; const attachments: PGLenum); stdcall;
  glInvalidateSubFramebuffer: procedure(target: GLenum; numAttachments: GLsizei; const attachments: PGLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glMultiDrawArraysIndirect: procedure(mode: GLenum; const indirect: pointer; drawcount: GLsizei; stride: GLsizei); stdcall;
  glMultiDrawElementsIndirect: procedure(mode: GLenum; _type: GLenum; const indirect: pointer; drawcount: GLsizei; stride: GLsizei); stdcall;
  glGetProgramInterfaceiv: procedure(_program: GLuint; programInterface: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetProgramResourceIndex: function(_program: GLuint; programInterface: GLenum; const name: PGLchar): GLuint; stdcall;
  glGetProgramResourceName: procedure(_program: GLuint; programInterface: GLenum; index: GLuint; bufSize: GLsizei; length: PGLsizei; name: PGLchar); stdcall;
  glGetProgramResourceiv: procedure(_program: GLuint; programInterface: GLenum; index: GLuint; propCount: GLsizei; const props: PGLenum; count: GLsizei; length: PGLsizei; params: PGLint); stdcall;
  glGetProgramResourceLocation: function(_program: GLuint; programInterface: GLenum; const name: PGLchar): GLint; stdcall;
  glGetProgramResourceLocationIndex: function(_program: GLuint; programInterface: GLenum; const name: PGLchar): GLint; stdcall;
  glShaderStorageBlockBinding: procedure(_program: GLuint; storageBlockIndex: GLuint; storageBlockBinding: GLuint); stdcall;
  glTexBufferRange: procedure(target: GLenum; internalformat: GLenum; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); stdcall;
  glTexStorage2DMultisample: procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glTexStorage3DMultisample: procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glTextureView: procedure(texture: GLuint; target: GLenum; origtexture: GLuint; internalformat: GLenum; minlevel: GLuint; numlevels: GLuint; minlayer: GLuint; numlayers: GLuint); stdcall;
  glBindVertexBuffer: procedure(bindingindex: GLuint; buffer: GLuint; offset: GLintptr; stride: GLsizei); stdcall;
  glVertexAttribFormat: procedure(attribindex: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; relativeoffset: GLuint); stdcall;
  glVertexAttribIFormat: procedure(attribindex: GLuint; size: GLint; _type: GLenum; relativeoffset: GLuint); stdcall;
  glVertexAttribLFormat: procedure(attribindex: GLuint; size: GLint; _type: GLenum; relativeoffset: GLuint); stdcall;
  glVertexAttribBinding: procedure(attribindex: GLuint; bindingindex: GLuint); stdcall;
  glVertexBindingDivisor: procedure(bindingindex: GLuint; divisor: GLuint); stdcall;
  glDebugMessageControl: procedure(source: GLenum; _type: GLenum; severity: GLenum; count: GLsizei; const ids: PGLuint; enabled: GLboolean); stdcall;
  glDebugMessageInsert: procedure(source: GLenum; _type: GLenum; id: GLuint; severity: GLenum; length: GLsizei; const buf: PGLchar); stdcall;
  glDebugMessageCallback: procedure(callback: GLDEBUGPROC; const userParam: pointer); stdcall;
  glGetDebugMessageLog: function(count: GLuint; bufSize: GLsizei; sources: PGLenum; types: PGLenum; ids: PGLuint; severities: PGLenum; lengths: PGLsizei; messageLog: PGLchar): GLuint; stdcall;
  glPushDebugGroup: procedure(source: GLenum; id: GLuint; length: GLsizei; const message: PGLchar); stdcall;
  glPopDebugGroup: procedure; stdcall;
  glObjectLabel: procedure(identifier: GLenum; name: GLuint; length: GLsizei; const _label: PGLchar); stdcall;
  glGetObjectLabel: procedure(identifier: GLenum; name: GLuint; bufSize: GLsizei; length: PGLsizei; _label: PGLchar); stdcall;
  glObjectPtrLabel: procedure(const ptr: pointer; length: GLsizei; const _label: PGLchar); stdcall;
  glGetObjectPtrLabel: procedure(const ptr: pointer; bufSize: GLsizei; length: PGLsizei; _label: PGLchar); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_4_4}
var
  glBufferStorage: procedure(target: GLenum; size: GLsizeiptr; const data: pointer; flags: GLbitfield); stdcall;
  glClearTexImage: procedure(texture: GLuint; level: GLint; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glClearTexSubImage: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glBindBuffersBase: procedure(target: GLenum; first: GLuint; count: GLsizei; const buffers: PGLuint); stdcall;
  glBindBuffersRange: procedure(target: GLenum; first: GLuint; count: GLsizei; const buffers: PGLuint; const offsets: PGLintptr; const sizes: PGLsizeiptr); stdcall;
  glBindTextures: procedure(first: GLuint; count: GLsizei; const textures: PGLuint); stdcall;
  glBindSamplers: procedure(first: GLuint; count: GLsizei; const samplers: PGLuint); stdcall;
  glBindImageTextures: procedure(first: GLuint; count: GLsizei; const textures: PGLuint); stdcall;
  glBindVertexBuffers: procedure(first: GLuint; count: GLsizei; const buffers: PGLuint; const offsets: PGLintptr; const strides: PGLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_VERSION_4_5}
var
  glClipControl: procedure(origin: GLenum; depth: GLenum); stdcall;
  glCreateTransformFeedbacks: procedure(n: GLsizei; ids: PGLuint); stdcall;
  glTransformFeedbackBufferBase: procedure(xfb: GLuint; index: GLuint; buffer: GLuint); stdcall;
  glTransformFeedbackBufferRange: procedure(xfb: GLuint; index: GLuint; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); stdcall;
  glGetTransformFeedbackiv: procedure(xfb: GLuint; pname: GLenum; param: PGLint); stdcall;
  glGetTransformFeedbacki_v: procedure(xfb: GLuint; pname: GLenum; index: GLuint; param: PGLint); stdcall;
  glGetTransformFeedbacki64_v: procedure(xfb: GLuint; pname: GLenum; index: GLuint; param: PGLint64); stdcall;
  glCreateBuffers: procedure(n: GLsizei; buffers: PGLuint); stdcall;
  glNamedBufferStorage: procedure(buffer: GLuint; size: GLsizeiptr; const data: pointer; flags: GLbitfield); stdcall;
  glNamedBufferData: procedure(buffer: GLuint; size: GLsizeiptr; const data: pointer; usage: GLenum); stdcall;
  glNamedBufferSubData: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; const data: pointer); stdcall;
  glCopyNamedBufferSubData: procedure(readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr); stdcall;
  glClearNamedBufferData: procedure(buffer: GLuint; internalformat: GLenum; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glClearNamedBufferSubData: procedure(buffer: GLuint; internalformat: GLenum; offset: GLintptr; size: GLsizeiptr; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glMapNamedBuffer: function(buffer: GLuint; access: GLenum): pointer; stdcall;
  glMapNamedBufferRange: function(buffer: GLuint; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): pointer; stdcall;
  glUnmapNamedBuffer: function(buffer: GLuint): GLboolean; stdcall;
  glFlushMappedNamedBufferRange: procedure(buffer: GLuint; offset: GLintptr; length: GLsizeiptr); stdcall;
  glGetNamedBufferParameteriv: procedure(buffer: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetNamedBufferParameteri64v: procedure(buffer: GLuint; pname: GLenum; params: PGLint64); stdcall;
  glGetNamedBufferPointerv: procedure(buffer: GLuint; pname: GLenum; params:Ppointer); stdcall;
  glGetNamedBufferSubData: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; data: pointer); stdcall;
  glCreateFramebuffers: procedure(n: GLsizei; framebuffers: PGLuint); stdcall;
  glNamedFramebufferRenderbuffer: procedure(framebuffer: GLuint; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;
  glNamedFramebufferParameteri: procedure(framebuffer: GLuint; pname: GLenum; param: GLint); stdcall;
  glNamedFramebufferTexture: procedure(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint); stdcall;
  glNamedFramebufferTextureLayer: procedure(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); stdcall;
  glNamedFramebufferDrawBuffer: procedure(framebuffer: GLuint; buf: GLenum); stdcall;
  glNamedFramebufferDrawBuffers: procedure(framebuffer: GLuint; n: GLsizei; const bufs: PGLenum); stdcall;
  glNamedFramebufferReadBuffer: procedure(framebuffer: GLuint; src: GLenum); stdcall;
  glInvalidateNamedFramebufferData: procedure(framebuffer: GLuint; numAttachments: GLsizei; const attachments: PGLenum); stdcall;
  glInvalidateNamedFramebufferSubData: procedure(framebuffer: GLuint; numAttachments: GLsizei; const attachments: PGLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glClearNamedFramebufferiv: procedure(framebuffer: GLuint; buffer: GLenum; drawbuffer: GLint; const value: PGLint); stdcall;
  glClearNamedFramebufferuiv: procedure(framebuffer: GLuint; buffer: GLenum; drawbuffer: GLint; const value: PGLuint); stdcall;
  glClearNamedFramebufferfv: procedure(framebuffer: GLuint; buffer: GLenum; drawbuffer: GLint; const value: PGLfloat); stdcall;
  glClearNamedFramebufferfi: procedure(framebuffer: GLuint; buffer: GLenum; drawbuffer: GLint; depth: GLfloat; stencil: GLint); stdcall;
  glBlitNamedFramebuffer: procedure(readFramebuffer: GLuint; drawFramebuffer: GLuint; srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); stdcall;
  glCheckNamedFramebufferStatus: function(framebuffer: GLuint; target: GLenum): GLenum; stdcall;
  glGetNamedFramebufferParameteriv: procedure(framebuffer: GLuint; pname: GLenum; param: PGLint); stdcall;
  glGetNamedFramebufferAttachmentParameteriv: procedure(framebuffer: GLuint; attachment: GLenum; pname: GLenum; params: PGLint); stdcall;
  glCreateRenderbuffers: procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
  glNamedRenderbufferStorage: procedure(renderbuffer: GLuint; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glNamedRenderbufferStorageMultisample: procedure(renderbuffer: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glGetNamedRenderbufferParameteriv: procedure(renderbuffer: GLuint; pname: GLenum; params: PGLint); stdcall;
  glCreateTextures: procedure(target: GLenum; n: GLsizei; textures: PGLuint); stdcall;
  glTextureBuffer: procedure(texture: GLuint; internalformat: GLenum; buffer: GLuint); stdcall;
  glTextureBufferRange: procedure(texture: GLuint; internalformat: GLenum; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); stdcall;
  glTextureStorage1D: procedure(texture: GLuint; levels: GLsizei; internalformat: GLenum; width: GLsizei); stdcall;
  glTextureStorage2D: procedure(texture: GLuint; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glTextureStorage3D: procedure(texture: GLuint; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei); stdcall;
  glTextureStorage2DMultisample: procedure(texture: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glTextureStorage3DMultisample: procedure(texture: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glTextureSubImage1D: procedure(texture: GLuint; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTextureSubImage2D: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTextureSubImage3D: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glCompressedTextureSubImage1D: procedure(texture: GLuint; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall;
  glCompressedTextureSubImage2D: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall;
  glCompressedTextureSubImage3D: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall;
  glCopyTextureSubImage1D: procedure(texture: GLuint; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei); stdcall;
  glCopyTextureSubImage2D: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glCopyTextureSubImage3D: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glTextureParameterf: procedure(texture: GLuint; pname: GLenum; param: GLfloat); stdcall;
  glTextureParameterfv: procedure(texture: GLuint; pname: GLenum; const param: PGLfloat); stdcall;
  glTextureParameteri: procedure(texture: GLuint; pname: GLenum; param: GLint); stdcall;
  glTextureParameterIiv: procedure(texture: GLuint; pname: GLenum; const params: PGLint); stdcall;
  glTextureParameterIuiv: procedure(texture: GLuint; pname: GLenum; const params: PGLuint); stdcall;
  glTextureParameteriv: procedure(texture: GLuint; pname: GLenum; const param: PGLint); stdcall;
  glGenerateTextureMipmap: procedure(texture: GLuint); stdcall;
  glBindTextureUnit: procedure(_unit: GLuint; texture: GLuint); stdcall;
  glGetTextureImage: procedure(texture: GLuint; level: GLint; format: GLenum; _type: GLenum; bufSize: GLsizei; pixels: pointer); stdcall;
  glGetCompressedTextureImage: procedure(texture: GLuint; level: GLint; bufSize: GLsizei; pixels: pointer); stdcall;
  glGetTextureLevelParameterfv: procedure(texture: GLuint; level: GLint; pname: GLenum; params: PGLfloat); stdcall;
  glGetTextureLevelParameteriv: procedure(texture: GLuint; level: GLint; pname: GLenum; params: PGLint); stdcall;
  glGetTextureParameterfv: procedure(texture: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetTextureParameterIiv: procedure(texture: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetTextureParameterIuiv: procedure(texture: GLuint; pname: GLenum; params: PGLuint); stdcall;
  glGetTextureParameteriv: procedure(texture: GLuint; pname: GLenum; params: PGLint); stdcall;
  glCreateVertexArrays: procedure(n: GLsizei; arrays: PGLuint); stdcall;
  glDisableVertexArrayAttrib: procedure(vaobj: GLuint; index: GLuint); stdcall;
  glEnableVertexArrayAttrib: procedure(vaobj: GLuint; index: GLuint); stdcall;
  glVertexArrayElementBuffer: procedure(vaobj: GLuint; buffer: GLuint); stdcall;
  glVertexArrayVertexBuffer: procedure(vaobj: GLuint; bindingindex: GLuint; buffer: GLuint; offset: GLintptr; stride: GLsizei); stdcall;
  glVertexArrayVertexBuffers: procedure(vaobj: GLuint; first: GLuint; count: GLsizei; const buffers: PGLuint; const offsets: PGLintptr; const strides: PGLsizei); stdcall;
  glVertexArrayAttribBinding: procedure(vaobj: GLuint; attribindex: GLuint; bindingindex: GLuint); stdcall;
  glVertexArrayAttribFormat: procedure(vaobj: GLuint; attribindex: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; relativeoffset: GLuint); stdcall;
  glVertexArrayAttribIFormat: procedure(vaobj: GLuint; attribindex: GLuint; size: GLint; _type: GLenum; relativeoffset: GLuint); stdcall;
  glVertexArrayAttribLFormat: procedure(vaobj: GLuint; attribindex: GLuint; size: GLint; _type: GLenum; relativeoffset: GLuint); stdcall;
  glVertexArrayBindingDivisor: procedure(vaobj: GLuint; bindingindex: GLuint; divisor: GLuint); stdcall;
  glGetVertexArrayiv: procedure(vaobj: GLuint; pname: GLenum; param: PGLint); stdcall;
  glGetVertexArrayIndexediv: procedure(vaobj: GLuint; index: GLuint; pname: GLenum; param: PGLint); stdcall;
  glGetVertexArrayIndexed64iv: procedure(vaobj: GLuint; index: GLuint; pname: GLenum; param: PGLint64); stdcall;
  glCreateSamplers: procedure(n: GLsizei; samplers: PGLuint); stdcall;
  glCreateProgramPipelines: procedure(n: GLsizei; pipelines: PGLuint); stdcall;
  glCreateQueries: procedure(target: GLenum; n: GLsizei; ids: PGLuint); stdcall;
  glGetQueryBufferObjecti64v: procedure(id: GLuint; buffer: GLuint; pname: GLenum; offset: GLintptr); stdcall;
  glGetQueryBufferObjectiv: procedure(id: GLuint; buffer: GLuint; pname: GLenum; offset: GLintptr); stdcall;
  glGetQueryBufferObjectui64v: procedure(id: GLuint; buffer: GLuint; pname: GLenum; offset: GLintptr); stdcall;
  glGetQueryBufferObjectuiv: procedure(id: GLuint; buffer: GLuint; pname: GLenum; offset: GLintptr); stdcall;
  glMemoryBarrierByRegion: procedure(barriers: GLbitfield); stdcall;
  glGetTextureSubImage: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; bufSize: GLsizei; pixels: pointer); stdcall;
  glGetCompressedTextureSubImage: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; bufSize: GLsizei; pixels: pointer); stdcall;
  glGetGraphicsResetStatus: function: GLenum; stdcall;
  glGetnCompressedTexImage: procedure(target: GLenum; lod: GLint; bufSize: GLsizei; pixels: pointer); stdcall;
  glGetnTexImage: procedure(target: GLenum; level: GLint; format: GLenum; _type: GLenum; bufSize: GLsizei; pixels: pointer); stdcall;
  glGetnUniformdv: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLdouble); stdcall;
  glGetnUniformfv: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLfloat); stdcall;
  glGetnUniformiv: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLint); stdcall;
  glGetnUniformuiv: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLuint); stdcall;
  glReadnPixels: procedure(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; bufSize: GLsizei; data: pointer); stdcall;
  glTextureBarrier: procedure; stdcall;
  {$IfNDef USE_GLCORE}
  glGetnMapdv: procedure(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLdouble); stdcall;
  glGetnMapfv: procedure(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLfloat); stdcall;
  glGetnMapiv: procedure(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLint); stdcall;
  glGetnPixelMapfv: procedure(map: GLenum; bufSize: GLsizei; values: PGLfloat); stdcall;
  glGetnPixelMapuiv: procedure(map: GLenum; bufSize: GLsizei; values: PGLuint); stdcall;
  glGetnPixelMapusv: procedure(map: GLenum; bufSize: GLsizei; values: PGLushort); stdcall;
  glGetnPolygonStipple: procedure(bufSize: GLsizei; pattern: PGLubyte); stdcall;
  glGetnColorTable: procedure(target: GLenum; format: GLenum; _type: GLenum; bufSize: GLsizei; table: pointer); stdcall;
  glGetnConvolutionFilter: procedure(target: GLenum; format: GLenum; _type: GLenum; bufSize: GLsizei; image: pointer); stdcall;
  glGetnSeparableFilter: procedure(target: GLenum; format: GLenum; _type: GLenum; rowBufSize: GLsizei; row: pointer; columnBufSize: GLsizei; column: pointer; span: pointer); stdcall;
  glGetnHistogram: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; bufSize: GLsizei; values: pointer); stdcall;
  glGetnMinmax: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; bufSize: GLsizei; values: pointer); stdcall;
  {$EndIf}
  {$EndIf}

  {$IfDef GL_VERSION_4_6}
var
  glSpecializeShader: procedure(shader: GLuint; const pEntryPoint: PGLchar; numSpecializationConstants: GLuint; const pConstantIndex: PGLuint; const pConstantValue: PGLuint); stdcall;
  glMultiDrawArraysIndirectCount: procedure(mode: GLenum; const indirect: pointer; drawcount: GLintptr; maxdrawcount: GLsizei; stride: GLsizei); stdcall;
  glMultiDrawElementsIndirectCount: procedure(mode: GLenum; _type: GLenum; const indirect: pointer; drawcount: GLintptr; maxdrawcount: GLsizei; stride: GLsizei); stdcall;
  glPolygonOffsetClamp: procedure(factor: GLfloat; units: GLfloat; clamp: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_ES3_2_compatibility}
  glPrimitiveBoundingBoxARB: procedure(minX: GLfloat; minY: GLfloat; minZ: GLfloat; minW: GLfloat; maxX: GLfloat; maxY: GLfloat; maxZ: GLfloat; maxW: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_bindless_texture}
  glGetTextureHandleARB: function(texture: GLuint): GLuint64; stdcall;
  glGetTextureSamplerHandleARB: function(texture: GLuint; sampler: GLuint): GLuint64; stdcall;
  glMakeTextureHandleResidentARB: procedure(handle: GLuint64); stdcall;
  glMakeTextureHandleNonResidentARB: procedure(handle: GLuint64); stdcall;
  glGetImageHandleARB: function(texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; format: GLenum): GLuint64; stdcall;
  glMakeImageHandleResidentARB: procedure(handle: GLuint64; access: GLenum); stdcall;
  glMakeImageHandleNonResidentARB: procedure(handle: GLuint64); stdcall;
  glUniformHandleui64ARB: procedure(location: GLint; value: GLuint64); stdcall;
  glUniformHandleui64vARB: procedure(location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glProgramUniformHandleui64ARB: procedure(_program: GLuint; location: GLint; value: GLuint64); stdcall;
  glProgramUniformHandleui64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const values: PGLuint64); stdcall;
  glIsTextureHandleResidentARB: function(handle: GLuint64): GLboolean; stdcall;
  glIsImageHandleResidentARB: function(handle: GLuint64): GLboolean; stdcall;
  glVertexAttribL1ui64ARB: procedure(index: GLuint; x: GLuint64EXT); stdcall;
  glVertexAttribL1ui64vARB: procedure(index: GLuint; const v: PGLuint64EXT); stdcall;
  glGetVertexAttribLui64vARB: procedure(index: GLuint; pname: GLenum; params: PGLuint64EXT); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_cl_event}
  glCreateSyncFromCLeventARB: function(context:P_cl_context; event:P_cl_event; flags: GLbitfield): GLsync; stdcall;
  {$EndIf}

  {$IfDef GL_ARB_color_buffer_float}
  glClampColorARB: procedure(target: GLenum; clamp: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_compute_variable_group_size}
  glDispatchComputeGroupSizeARB: procedure(num_groups_x: GLuint; num_groups_y: GLuint; num_groups_z: GLuint; group_size_x: GLuint; group_size_y: GLuint; group_size_z: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_debug_output}
  glDebugMessageControlARB: procedure(source: GLenum; _type: GLenum; severity: GLenum; count: GLsizei; const ids: PGLuint; enabled: GLboolean); stdcall;
  glDebugMessageInsertARB: procedure(source: GLenum; _type: GLenum; id: GLuint; severity: GLenum; length: GLsizei; const buf: PGLchar); stdcall;
  glDebugMessageCallbackARB: procedure(callback: GLDEBUGPROCARB; const userParam: pointer); stdcall;
  glGetDebugMessageLogARB: function(count: GLuint; bufSize: GLsizei; sources: PGLenum; types: PGLenum; ids: PGLuint; severities: PGLenum; lengths: PGLsizei; messageLog: PGLchar): GLuint; stdcall;
  {$EndIf}

  {$IfDef GL_ARB_draw_buffers}
  glDrawBuffersARB: procedure(n: GLsizei; const bufs: PGLenum); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_draw_buffers_blend}
  glBlendEquationiARB: procedure(buf: GLuint; mode: GLenum); stdcall;
  glBlendEquationSeparateiARB: procedure(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); stdcall;
  glBlendFunciARB: procedure(buf: GLuint; src: GLenum; dst: GLenum); stdcall;
  glBlendFuncSeparateiARB: procedure(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_draw_instanced}
  glDrawArraysInstancedARB: procedure(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei); stdcall;
  glDrawElementsInstancedARB: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer; primcount: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_fragment_program}
  glProgramStringARB: procedure(target: GLenum; format: GLenum; len: GLsizei; const _string: pointer); stdcall;
  glBindProgramARB: procedure(target: GLenum; _program: GLuint); stdcall;
  glDeleteProgramsARB: procedure(n: GLsizei; const programs: PGLuint); stdcall;
  glGenProgramsARB: procedure(n: GLsizei; programs: PGLuint); stdcall;
  glProgramEnvParameter4dARB: procedure(target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glProgramEnvParameter4dvARB: procedure(target: GLenum; index: GLuint; const params: PGLdouble); stdcall;
  glProgramEnvParameter4fARB: procedure(target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glProgramEnvParameter4fvARB: procedure(target: GLenum; index: GLuint; const params: PGLfloat); stdcall;
  glProgramLocalParameter4dARB: procedure(target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glProgramLocalParameter4dvARB: procedure(target: GLenum; index: GLuint; const params: PGLdouble); stdcall;
  glProgramLocalParameter4fARB: procedure(target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glProgramLocalParameter4fvARB: procedure(target: GLenum; index: GLuint; const params: PGLfloat); stdcall;
  glGetProgramEnvParameterdvARB: procedure(target: GLenum; index: GLuint; params: PGLdouble); stdcall;
  glGetProgramEnvParameterfvARB: procedure(target: GLenum; index: GLuint; params: PGLfloat); stdcall;
  glGetProgramLocalParameterdvARB: procedure(target: GLenum; index: GLuint; params: PGLdouble); stdcall;
  glGetProgramLocalParameterfvARB: procedure(target: GLenum; index: GLuint; params: PGLfloat); stdcall;
  glGetProgramivARB: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetProgramStringARB: procedure(target: GLenum; pname: GLenum; _string: pointer); stdcall;
  glIsProgramARB: function(_program: GLuint): GLboolean; stdcall;
  {$EndIf}

  {$IfDef GL_ARB_geometry_shader4}
  glProgramParameteriARB: procedure(_program: GLuint; pname: GLenum; value: GLint); stdcall;
  glFramebufferTextureARB: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); stdcall;
  glFramebufferTextureLayerARB: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); stdcall;
  glFramebufferTextureFaceARB: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_gl_spirv}
  glSpecializeShaderARB: procedure(shader: GLuint; const pEntryPoint: PGLchar; numSpecializationConstants: GLuint; const pConstantIndex: PGLuint; const pConstantValue: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_gpu_shader_int64}
  glUniform1i64ARB: procedure(location: GLint; x: GLint64); stdcall;
  glUniform2i64ARB: procedure(location: GLint; x: GLint64; y: GLint64); stdcall;
  glUniform3i64ARB: procedure(location: GLint; x: GLint64; y: GLint64; z: GLint64); stdcall;
  glUniform4i64ARB: procedure(location: GLint; x: GLint64; y: GLint64; z: GLint64; w: GLint64); stdcall;
  glUniform1i64vARB: procedure(location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glUniform2i64vARB: procedure(location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glUniform3i64vARB: procedure(location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glUniform4i64vARB: procedure(location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glUniform1ui64ARB: procedure(location: GLint; x: GLuint64); stdcall;
  glUniform2ui64ARB: procedure(location: GLint; x: GLuint64; y: GLuint64); stdcall;
  glUniform3ui64ARB: procedure(location: GLint; x: GLuint64; y: GLuint64; z: GLuint64); stdcall;
  glUniform4ui64ARB: procedure(location: GLint; x: GLuint64; y: GLuint64; z: GLuint64; w: GLuint64); stdcall;
  glUniform1ui64vARB: procedure(location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glUniform2ui64vARB: procedure(location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glUniform3ui64vARB: procedure(location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glUniform4ui64vARB: procedure(location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glGetUniformi64vARB: procedure(_program: GLuint; location: GLint; params: PGLint64); stdcall;
  glGetUniformui64vARB: procedure(_program: GLuint; location: GLint; params: PGLuint64); stdcall;
  glGetnUniformi64vARB: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLint64); stdcall;
  glGetnUniformui64vARB: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLuint64); stdcall;
  glProgramUniform1i64ARB: procedure(_program: GLuint; location: GLint; x: GLint64); stdcall;
  glProgramUniform2i64ARB: procedure(_program: GLuint; location: GLint; x: GLint64; y: GLint64); stdcall;
  glProgramUniform3i64ARB: procedure(_program: GLuint; location: GLint; x: GLint64; y: GLint64; z: GLint64); stdcall;
  glProgramUniform4i64ARB: procedure(_program: GLuint; location: GLint; x: GLint64; y: GLint64; z: GLint64; w: GLint64); stdcall;
  glProgramUniform1i64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glProgramUniform2i64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glProgramUniform3i64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glProgramUniform4i64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64); stdcall;
  glProgramUniform1ui64ARB: procedure(_program: GLuint; location: GLint; x: GLuint64); stdcall;
  glProgramUniform2ui64ARB: procedure(_program: GLuint; location: GLint; x: GLuint64; y: GLuint64); stdcall;
  glProgramUniform3ui64ARB: procedure(_program: GLuint; location: GLint; x: GLuint64; y: GLuint64; z: GLuint64); stdcall;
  glProgramUniform4ui64ARB: procedure(_program: GLuint; location: GLint; x: GLuint64; y: GLuint64; z: GLuint64; w: GLuint64); stdcall;
  glProgramUniform1ui64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glProgramUniform2ui64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glProgramUniform3ui64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glProgramUniform4ui64vARB: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_imaging}
  glColorTable: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; const table: pointer); stdcall;
  glColorTableParameterfv: procedure(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glColorTableParameteriv: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glCopyColorTable: procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei); stdcall;
  glGetColorTable: procedure(target: GLenum; format: GLenum; _type: GLenum; table: pointer); stdcall;
  glGetColorTableParameterfv: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetColorTableParameteriv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glColorSubTable: procedure(target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glCopyColorSubTable: procedure(target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei); stdcall;
  glConvolutionFilter1D: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; const image: pointer); stdcall;
  glConvolutionFilter2D: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const image: pointer); stdcall;
  glConvolutionParameterf: procedure(target: GLenum; pname: GLenum; params: GLfloat); stdcall;
  glConvolutionParameterfv: procedure(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glConvolutionParameteri: procedure(target: GLenum; pname: GLenum; params: GLint); stdcall;
  glConvolutionParameteriv: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glCopyConvolutionFilter1D: procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei); stdcall;
  glCopyConvolutionFilter2D: procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glGetConvolutionFilter: procedure(target: GLenum; format: GLenum; _type: GLenum; image: pointer); stdcall;
  glGetConvolutionParameterfv: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetConvolutionParameteriv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetSeparableFilter: procedure(target: GLenum; format: GLenum; _type: GLenum; row: pointer; column: pointer; span: pointer); stdcall;
  glSeparableFilter2D: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const row: pointer; const column: pointer); stdcall;
  glGetHistogram: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: pointer); stdcall;
  glGetHistogramParameterfv: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetHistogramParameteriv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetMinmax: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: pointer); stdcall;
  glGetMinmaxParameterfv: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetMinmaxParameteriv: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glHistogram: procedure(target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean); stdcall;
  glMinmax: procedure(target: GLenum; internalformat: GLenum; sink: GLboolean); stdcall;
  glResetHistogram: procedure(target: GLenum); stdcall;
  glResetMinmax: procedure(target: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_indirect_parameters}
  glMultiDrawArraysIndirectCountARB: procedure(mode: GLenum; const indirect: pointer; drawcount: GLintptr; maxdrawcount: GLsizei; stride: GLsizei); stdcall;
  glMultiDrawElementsIndirectCountARB: procedure(mode: GLenum; _type: GLenum; const indirect: pointer; drawcount: GLintptr; maxdrawcount: GLsizei; stride: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_instanced_arrays}
  glVertexAttribDivisorARB: procedure(index: GLuint; divisor: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_matrix_palette}
  glCurrentPaletteMatrixARB: procedure(index: GLint); stdcall;
  glMatrixIndexubvARB: procedure(size: GLint; const indices: PGLubyte); stdcall;
  glMatrixIndexusvARB: procedure(size: GLint; const indices: PGLushort); stdcall;
  glMatrixIndexuivARB: procedure(size: GLint; const indices: PGLuint); stdcall;
  glMatrixIndexPointerARB: procedure(size: GLint; _type: GLenum; stride: GLsizei; const pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_multisample}
  glSampleCoverageARB: procedure(value: GLfloat; invert: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_multitexture}
  glActiveTextureARB: procedure(texture: GLenum); stdcall;
  glClientActiveTextureARB: procedure(texture: GLenum); stdcall;
  glMultiTexCoord1dARB: procedure(target: GLenum; s: GLdouble); stdcall;
  glMultiTexCoord1dvARB: procedure(target: GLenum; const v: PGLdouble); stdcall;
  glMultiTexCoord1fARB: procedure(target: GLenum; s: GLfloat); stdcall;
  glMultiTexCoord1fvARB: procedure(target: GLenum; const v: PGLfloat); stdcall;
  glMultiTexCoord1iARB: procedure(target: GLenum; s: GLint); stdcall;
  glMultiTexCoord1ivARB: procedure(target: GLenum; const v: PGLint); stdcall;
  glMultiTexCoord1sARB: procedure(target: GLenum; s: GLshort); stdcall;
  glMultiTexCoord1svARB: procedure(target: GLenum; const v: PGLshort); stdcall;
  glMultiTexCoord2dARB: procedure(target: GLenum; s: GLdouble; t: GLdouble); stdcall;
  glMultiTexCoord2dvARB: procedure(target: GLenum; const v: PGLdouble); stdcall;
  glMultiTexCoord2fARB: procedure(target: GLenum; s: GLfloat; t: GLfloat); stdcall;
  glMultiTexCoord2fvARB: procedure(target: GLenum; const v: PGLfloat); stdcall;
  glMultiTexCoord2iARB: procedure(target: GLenum; s: GLint; t: GLint); stdcall;
  glMultiTexCoord2ivARB: procedure(target: GLenum; const v: PGLint); stdcall;
  glMultiTexCoord2sARB: procedure(target: GLenum; s: GLshort; t: GLshort); stdcall;
  glMultiTexCoord2svARB: procedure(target: GLenum; const v: PGLshort); stdcall;
  glMultiTexCoord3dARB: procedure(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble); stdcall;
  glMultiTexCoord3dvARB: procedure(target: GLenum; const v: PGLdouble); stdcall;
  glMultiTexCoord3fARB: procedure(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat); stdcall;
  glMultiTexCoord3fvARB: procedure(target: GLenum; const v: PGLfloat); stdcall;
  glMultiTexCoord3iARB: procedure(target: GLenum; s: GLint; t: GLint; r: GLint); stdcall;
  glMultiTexCoord3ivARB: procedure(target: GLenum; const v: PGLint); stdcall;
  glMultiTexCoord3sARB: procedure(target: GLenum; s: GLshort; t: GLshort; r: GLshort); stdcall;
  glMultiTexCoord3svARB: procedure(target: GLenum; const v: PGLshort); stdcall;
  glMultiTexCoord4dARB: procedure(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble); stdcall;
  glMultiTexCoord4dvARB: procedure(target: GLenum; const v: PGLdouble); stdcall;
  glMultiTexCoord4fARB: procedure(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat); stdcall;
  glMultiTexCoord4fvARB: procedure(target: GLenum; const v: PGLfloat); stdcall;
  glMultiTexCoord4iARB: procedure(target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint); stdcall;
  glMultiTexCoord4ivARB: procedure(target: GLenum; const v: PGLint); stdcall;
  glMultiTexCoord4sARB: procedure(target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort); stdcall;
  glMultiTexCoord4svARB: procedure(target: GLenum; const v: PGLshort); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_occlusion_query}
  glGenQueriesARB: procedure(n: GLsizei; ids: PGLuint); stdcall;
  glDeleteQueriesARB: procedure(n: GLsizei; const ids: PGLuint); stdcall;
  glIsQueryARB: function(id: GLuint): GLboolean; stdcall;
  glBeginQueryARB: procedure(target: GLenum; id: GLuint); stdcall;
  glEndQueryARB: procedure(target: GLenum); stdcall;
  glGetQueryivARB: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetQueryObjectivARB: procedure(id: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetQueryObjectuivARB: procedure(id: GLuint; pname: GLenum; params: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_parallel_shader_compile}
  glMaxShaderCompilerThreadsARB: procedure(count: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_point_parameters}
  glPointParameterfARB: procedure(pname: GLenum; param: GLfloat); stdcall;
  glPointParameterfvARB: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_robustness}
  glGetGraphicsResetStatusARB: function: GLenum; stdcall;
  glGetnTexImageARB: procedure(target: GLenum; level: GLint; format: GLenum; _type: GLenum; bufSize: GLsizei; img: pointer); stdcall;
  glReadnPixelsARB: procedure(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; bufSize: GLsizei; data: pointer); stdcall;
  glGetnCompressedTexImageARB: procedure(target: GLenum; lod: GLint; bufSize: GLsizei; img: pointer); stdcall;
  glGetnUniformfvARB: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLfloat); stdcall;
  glGetnUniformivARB: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLint); stdcall;
  glGetnUniformuivARB: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLuint); stdcall;
  glGetnUniformdvARB: procedure(_program: GLuint; location: GLint; bufSize: GLsizei; params: PGLdouble); stdcall;
  {$IfNDef USE_GLCORE}
  glGetnMapdvARB: procedure(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLdouble); stdcall;
  glGetnMapfvARB: procedure(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLfloat); stdcall;
  glGetnMapivARB: procedure(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLint); stdcall;
  glGetnPixelMapfvARB: procedure(map: GLenum; bufSize: GLsizei; values: PGLfloat); stdcall;
  glGetnPixelMapuivARB: procedure(map: GLenum; bufSize: GLsizei; values: PGLuint); stdcall;
  glGetnPixelMapusvARB: procedure(map: GLenum; bufSize: GLsizei; values: PGLushort); stdcall;
  glGetnPolygonStippleARB: procedure(bufSize: GLsizei; pattern: PGLubyte); stdcall;
  glGetnColorTableARB: procedure(target: GLenum; format: GLenum; _type: GLenum; bufSize: GLsizei; table: pointer); stdcall;
  glGetnConvolutionFilterARB: procedure(target: GLenum; format: GLenum; _type: GLenum; bufSize: GLsizei; image: pointer); stdcall;
  glGetnSeparableFilterARB: procedure(target: GLenum; format: GLenum; _type: GLenum; rowBufSize: GLsizei; row: pointer; columnBufSize: GLsizei; column: pointer; span: pointer); stdcall;
  glGetnHistogramARB: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; bufSize: GLsizei; values: pointer); stdcall;
  glGetnMinmaxARB: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; bufSize: GLsizei; values: pointer); stdcall;
  {$EndIf}
  {$EndIf}

  {$IfDef GL_ARB_sample_locations}
  glFramebufferSampleLocationsfvARB: procedure(target: GLenum; start: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glNamedFramebufferSampleLocationsfvARB: procedure(framebuffer: GLuint; start: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glEvaluateDepthValuesARB: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_ARB_sample_shading}
  glMinSampleShadingARB: procedure(value: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_shader_objects}
  glDeleteObjectARB: procedure(obj: GLhandleARB); stdcall;
  glGetHandleARB: function(pname: GLenum): GLhandleARB; stdcall;
  glDetachObjectARB: procedure(containerObj: GLhandleARB; attachedObj: GLhandleARB); stdcall;
  glCreateShaderObjectARB: function(shaderType: GLenum): GLhandleARB; stdcall;
  glShaderSourceARB: procedure(shaderObj: GLhandleARB; count: GLsizei; const _string: PPGLcharARB; const length: PGLint); stdcall;
  glCompileShaderARB: procedure(shaderObj: GLhandleARB); stdcall;
  glCreateProgramObjectARB: function: GLhandleARB; stdcall;
  glAttachObjectARB: procedure(containerObj: GLhandleARB; obj: GLhandleARB); stdcall;
  glLinkProgramARB: procedure(programObj: GLhandleARB); stdcall;
  glUseProgramObjectARB: procedure(programObj: GLhandleARB); stdcall;
  glValidateProgramARB: procedure(programObj: GLhandleARB); stdcall;
  glUniform1fARB: procedure(location: GLint; v0: GLfloat); stdcall;
  glUniform2fARB: procedure(location: GLint; v0: GLfloat; v1: GLfloat); stdcall;
  glUniform3fARB: procedure(location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); stdcall;
  glUniform4fARB: procedure(location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); stdcall;
  glUniform1iARB: procedure(location: GLint; v0: GLint); stdcall;
  glUniform2iARB: procedure(location: GLint; v0: GLint; v1: GLint); stdcall;
  glUniform3iARB: procedure(location: GLint; v0: GLint; v1: GLint; v2: GLint); stdcall;
  glUniform4iARB: procedure(location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); stdcall;
  glUniform1fvARB: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform2fvARB: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform3fvARB: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform4fvARB: procedure(location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glUniform1ivARB: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniform2ivARB: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniform3ivARB: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniform4ivARB: procedure(location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glUniformMatrix2fvARB: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix3fvARB: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glUniformMatrix4fvARB: procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glGetObjectParameterfvARB: procedure(obj: GLhandleARB; pname: GLenum; params: PGLfloat); stdcall;
  glGetObjectParameterivARB: procedure(obj: GLhandleARB; pname: GLenum; params: PGLint); stdcall;
  glGetInfoLogARB: procedure(obj: GLhandleARB; maxLength: GLsizei; length: PGLsizei; infoLog: PGLcharARB); stdcall;
  glGetAttachedObjectsARB: procedure(containerObj: GLhandleARB; maxCount: GLsizei; count: PGLsizei; obj: PGLhandleARB); stdcall;
  glGetUniformLocationARB: function(programObj: GLhandleARB; const name: PGLcharARB): GLint; stdcall;
  glGetActiveUniformARB: procedure(programObj: GLhandleARB; index: GLuint; maxLength: GLsizei; length: PGLsizei; size: PGLint; _type: PGLenum; name: PGLcharARB); stdcall;
  glGetUniformfvARB: procedure(programObj: GLhandleARB; location: GLint; params: PGLfloat); stdcall;
  glGetUniformivARB: procedure(programObj: GLhandleARB; location: GLint; params: PGLint); stdcall;
  glGetShaderSourceARB: procedure(obj: GLhandleARB; maxLength: GLsizei; length: PGLsizei; source: PGLcharARB); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_shading_language_include}
  glNamedStringARB: procedure(_type: GLenum; namelen: GLint; const name: PGLchar; stringlen: GLint; const _string: PGLchar); stdcall;
  glDeleteNamedStringARB: procedure(namelen: GLint; const name: PGLchar); stdcall;
  glCompileShaderIncludeARB: procedure(shader: GLuint; count: GLsizei; const path: PPGLchar; const length: PGLint); stdcall;
  glIsNamedStringARB: function(namelen: GLint; const name: PGLchar): GLboolean; stdcall;
  glGetNamedStringARB: procedure(namelen: GLint; const name: PGLchar; bufSize: GLsizei; stringlen: PGLint; _string: PGLchar); stdcall;
  glGetNamedStringivARB: procedure(namelen: GLint; const name: PGLchar; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_sparse_buffer}
  glBufferPageCommitmentARB: procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr; commit: GLboolean); stdcall;
  glNamedBufferPageCommitmentEXT: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; commit: GLboolean); stdcall;
  glNamedBufferPageCommitmentARB: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; commit: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_sparse_texture}
  glTexPageCommitmentARB: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; commit: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_texture_buffer_object}
  glTexBufferARB: procedure(target: GLenum; internalformat: GLenum; buffer: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_texture_compression}
  glCompressedTexImage3DARB: procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; const data: pointer); stdcall;
  glCompressedTexImage2DARB: procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; const data: pointer); stdcall;
  glCompressedTexImage1DARB: procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; const data: pointer); stdcall;
  glCompressedTexSubImage3DARB: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall;
  glCompressedTexSubImage2DARB: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall;
  glCompressedTexSubImage1DARB: procedure(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; const data: pointer); stdcall;
  glGetCompressedTexImageARB: procedure(target: GLenum; level: GLint; img: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_transpose_matrix}
  glLoadTransposeMatrixfARB: procedure(const m: PGLfloat); stdcall;
  glLoadTransposeMatrixdARB: procedure(const m: PGLdouble); stdcall;
  glMultTransposeMatrixfARB: procedure(const m: PGLfloat); stdcall;
  glMultTransposeMatrixdARB: procedure(const m: PGLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_vertex_blend}
  glWeightbvARB: procedure(size: GLint; const weights: PGLbyte); stdcall;
  glWeightsvARB: procedure(size: GLint; const weights: PGLshort); stdcall;
  glWeightivARB: procedure(size: GLint; const weights: PGLint); stdcall;
  glWeightfvARB: procedure(size: GLint; const weights: PGLfloat); stdcall;
  glWeightdvARB: procedure(size: GLint; const weights: PGLdouble); stdcall;
  glWeightubvARB: procedure(size: GLint; const weights: PGLubyte); stdcall;
  glWeightusvARB: procedure(size: GLint; const weights: PGLushort); stdcall;
  glWeightuivARB: procedure(size: GLint; const weights: PGLuint); stdcall;
  glWeightPointerARB: procedure(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glVertexBlendARB: procedure(count: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_vertex_buffer_object}
  glBindBufferARB: procedure(target: GLenum; buffer: GLuint); stdcall;
  glDeleteBuffersARB: procedure(n: GLsizei; const buffers: PGLuint); stdcall;
  glGenBuffersARB: procedure(n: GLsizei; buffers: PGLuint); stdcall;
  glIsBufferARB: function(buffer: GLuint): GLboolean; stdcall;
  glBufferDataARB: procedure(target: GLenum; size: GLsizeiptrARB; const data: pointer; usage: GLenum); stdcall;
  glBufferSubDataARB: procedure(target: GLenum; offset: GLintptrARB; size: GLsizeiptrARB; const data: pointer); stdcall;
  glGetBufferSubDataARB: procedure(target: GLenum; offset: GLintptrARB; size: GLsizeiptrARB; data: pointer); stdcall;
  glMapBufferARB: function(target: GLenum; access: GLenum): pointer; stdcall;
  glUnmapBufferARB: function(target: GLenum): GLboolean; stdcall;
  glGetBufferParameterivARB: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetBufferPointervARB: procedure(target: GLenum; pname: GLenum; params:Ppointer); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_vertex_program}
  glVertexAttrib1dARB: procedure(index: GLuint; x: GLdouble); stdcall;
  glVertexAttrib1dvARB: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib1fARB: procedure(index: GLuint; x: GLfloat); stdcall;
  glVertexAttrib1fvARB: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib1sARB: procedure(index: GLuint; x: GLshort); stdcall;
  glVertexAttrib1svARB: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib2dARB: procedure(index: GLuint; x: GLdouble; y: GLdouble); stdcall;
  glVertexAttrib2dvARB: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib2fARB: procedure(index: GLuint; x: GLfloat; y: GLfloat); stdcall;
  glVertexAttrib2fvARB: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib2sARB: procedure(index: GLuint; x: GLshort; y: GLshort); stdcall;
  glVertexAttrib2svARB: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib3dARB: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glVertexAttrib3dvARB: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib3fARB: procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glVertexAttrib3fvARB: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib3sARB: procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort); stdcall;
  glVertexAttrib3svARB: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4NbvARB: procedure(index: GLuint; const v: PGLbyte); stdcall;
  glVertexAttrib4NivARB: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttrib4NsvARB: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4NubARB: procedure(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte); stdcall;
  glVertexAttrib4NubvARB: procedure(index: GLuint; const v: PGLubyte); stdcall;
  glVertexAttrib4NuivARB: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttrib4NusvARB: procedure(index: GLuint; const v: PGLushort); stdcall;
  glVertexAttrib4bvARB: procedure(index: GLuint; const v: PGLbyte); stdcall;
  glVertexAttrib4dARB: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glVertexAttrib4dvARB: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib4fARB: procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glVertexAttrib4fvARB: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib4ivARB: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttrib4sARB: procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort); stdcall;
  glVertexAttrib4svARB: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4ubvARB: procedure(index: GLuint; const v: PGLubyte); stdcall;
  glVertexAttrib4uivARB: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttrib4usvARB: procedure(index: GLuint; const v: PGLushort); stdcall;
  glVertexAttribPointerARB: procedure(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei; const _pointer: pointer); stdcall;
  glEnableVertexAttribArrayARB: procedure(index: GLuint); stdcall;
  glDisableVertexAttribArrayARB: procedure(index: GLuint); stdcall;
  glGetVertexAttribdvARB: procedure(index: GLuint; pname: GLenum; params: PGLdouble); stdcall;
  glGetVertexAttribfvARB: procedure(index: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetVertexAttribivARB: procedure(index: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVertexAttribPointervARB: procedure(index: GLuint; pname: GLenum; pointer:Ppointer); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_vertex_shader}
  glBindAttribLocationARB: procedure(programObj: GLhandleARB; index: GLuint; const name: PGLcharARB); stdcall;
  glGetActiveAttribARB: procedure(programObj: GLhandleARB; index: GLuint; maxLength: GLsizei; length: PGLsizei; size: PGLint; _type: PGLenum; name: PGLcharARB); stdcall;
  glGetAttribLocationARB: function(programObj: GLhandleARB; const name: PGLcharARB): GLint; stdcall;
  {$EndIf}

  {$IfDef GL_ARB_viewport_array}
  glDepthRangeArraydvNV: procedure(first: GLuint; count: GLsizei; const v: PGLdouble); stdcall;
  glDepthRangeIndexeddNV: procedure(index: GLuint; n: GLdouble; f: GLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_ARB_window_pos}
  glWindowPos2dARB: procedure(x: GLdouble; y: GLdouble); stdcall;
  glWindowPos2dvARB: procedure(const v: PGLdouble); stdcall;
  glWindowPos2fARB: procedure(x: GLfloat; y: GLfloat); stdcall;
  glWindowPos2fvARB: procedure(const v: PGLfloat); stdcall;
  glWindowPos2iARB: procedure(x: GLint; y: GLint); stdcall;
  glWindowPos2ivARB: procedure(const v: PGLint); stdcall;
  glWindowPos2sARB: procedure(x: GLshort; y: GLshort); stdcall;
  glWindowPos2svARB: procedure(const v: PGLshort); stdcall;
  glWindowPos3dARB: procedure(x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glWindowPos3dvARB: procedure(const v: PGLdouble); stdcall;
  glWindowPos3fARB: procedure(x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glWindowPos3fvARB: procedure(const v: PGLfloat); stdcall;
  glWindowPos3iARB: procedure(x: GLint; y: GLint; z: GLint); stdcall;
  glWindowPos3ivARB: procedure(const v: PGLint); stdcall;
  glWindowPos3sARB: procedure(x: GLshort; y: GLshort; z: GLshort); stdcall;
  glWindowPos3svARB: procedure(const v: PGLshort); stdcall;
  {$EndIf}

  {$IfDef GL_KHR_blend_equation_advanced}
  glBlendBarrierKHR: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_KHR_parallel_shader_compile}
  glMaxShaderCompilerThreadsKHR: procedure(count: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_OES_byte_coordinates}
  glMultiTexCoord1bOES: procedure(texture: GLenum; s: GLbyte); stdcall;
  glMultiTexCoord1bvOES: procedure(texture: GLenum; const coords: PGLbyte); stdcall;
  glMultiTexCoord2bOES: procedure(texture: GLenum; s: GLbyte; t: GLbyte); stdcall;
  glMultiTexCoord2bvOES: procedure(texture: GLenum; const coords: PGLbyte); stdcall;
  glMultiTexCoord3bOES: procedure(texture: GLenum; s: GLbyte; t: GLbyte; r: GLbyte); stdcall;
  glMultiTexCoord3bvOES: procedure(texture: GLenum; const coords: PGLbyte); stdcall;
  glMultiTexCoord4bOES: procedure(texture: GLenum; s: GLbyte; t: GLbyte; r: GLbyte; q: GLbyte); stdcall;
  glMultiTexCoord4bvOES: procedure(texture: GLenum; const coords: PGLbyte); stdcall;
  glTexCoord1bOES: procedure(s: GLbyte); stdcall;
  glTexCoord1bvOES: procedure(const coords: PGLbyte); stdcall;
  glTexCoord2bOES: procedure(s: GLbyte; t: GLbyte); stdcall;
  glTexCoord2bvOES: procedure(const coords: PGLbyte); stdcall;
  glTexCoord3bOES: procedure(s: GLbyte; t: GLbyte; r: GLbyte); stdcall;
  glTexCoord3bvOES: procedure(const coords: PGLbyte); stdcall;
  glTexCoord4bOES: procedure(s: GLbyte; t: GLbyte; r: GLbyte; q: GLbyte); stdcall;
  glTexCoord4bvOES: procedure(const coords: PGLbyte); stdcall;
  glVertex2bOES: procedure(x: GLbyte; y: GLbyte); stdcall;
  glVertex2bvOES: procedure(const coords: PGLbyte); stdcall;
  glVertex3bOES: procedure(x: GLbyte; y: GLbyte; z: GLbyte); stdcall;
  glVertex3bvOES: procedure(const coords: PGLbyte); stdcall;
  glVertex4bOES: procedure(x: GLbyte; y: GLbyte; z: GLbyte; w: GLbyte); stdcall;
  glVertex4bvOES: procedure(const coords: PGLbyte); stdcall;
  {$EndIf}

  {$IfDef GL_OES_fixed_point}
  glAlphaFuncxOES: procedure(func: GLenum; ref: GLfixed); stdcall;
  glClearColorxOES: procedure(red: GLfixed; green: GLfixed; blue: GLfixed; alpha: GLfixed); stdcall;
  glClearDepthxOES: procedure(depth: GLfixed); stdcall;
  glClipPlanexOES: procedure(plane: GLenum; const equation: PGLfixed); stdcall;
  glColor4xOES: procedure(red: GLfixed; green: GLfixed; blue: GLfixed; alpha: GLfixed); stdcall;
  glDepthRangexOES: procedure(n: GLfixed; f: GLfixed); stdcall;
  glFogxOES: procedure(pname: GLenum; param: GLfixed); stdcall;
  glFogxvOES: procedure(pname: GLenum; const param: PGLfixed); stdcall;
  glFrustumxOES: procedure(l: GLfixed; r: GLfixed; b: GLfixed; t: GLfixed; n: GLfixed; f: GLfixed); stdcall;
  glGetClipPlanexOES: procedure(plane: GLenum; equation: PGLfixed); stdcall;
  glGetFixedvOES: procedure(pname: GLenum; params: PGLfixed); stdcall;
  glGetTexEnvxvOES: procedure(target: GLenum; pname: GLenum; params: PGLfixed); stdcall;
  glGetTexParameterxvOES: procedure(target: GLenum; pname: GLenum; params: PGLfixed); stdcall;
  glLightModelxOES: procedure(pname: GLenum; param: GLfixed); stdcall;
  glLightModelxvOES: procedure(pname: GLenum; const param: PGLfixed); stdcall;
  glLightxOES: procedure(light: GLenum; pname: GLenum; param: GLfixed); stdcall;
  glLightxvOES: procedure(light: GLenum; pname: GLenum; const params: PGLfixed); stdcall;
  glLineWidthxOES: procedure(width: GLfixed); stdcall;
  glLoadMatrixxOES: procedure(const m: PGLfixed); stdcall;
  glMaterialxOES: procedure(face: GLenum; pname: GLenum; param: GLfixed); stdcall;
  glMaterialxvOES: procedure(face: GLenum; pname: GLenum; const param: PGLfixed); stdcall;
  glMultMatrixxOES: procedure(const m: PGLfixed); stdcall;
  glMultiTexCoord4xOES: procedure(texture: GLenum; s: GLfixed; t: GLfixed; r: GLfixed; q: GLfixed); stdcall;
  glNormal3xOES: procedure(nx: GLfixed; ny: GLfixed; nz: GLfixed); stdcall;
  glOrthoxOES: procedure(l: GLfixed; r: GLfixed; b: GLfixed; t: GLfixed; n: GLfixed; f: GLfixed); stdcall;
  glPointParameterxvOES: procedure(pname: GLenum; const params: PGLfixed); stdcall;
  glPointSizexOES: procedure(size: GLfixed); stdcall;
  glPolygonOffsetxOES: procedure(factor: GLfixed; units: GLfixed); stdcall;
  glRotatexOES: procedure(angle: GLfixed; x: GLfixed; y: GLfixed; z: GLfixed); stdcall;
  glScalexOES: procedure(x: GLfixed; y: GLfixed; z: GLfixed); stdcall;
  glTexEnvxOES: procedure(target: GLenum; pname: GLenum; param: GLfixed); stdcall;
  glTexEnvxvOES: procedure(target: GLenum; pname: GLenum; const params: PGLfixed); stdcall;
  glTexParameterxOES: procedure(target: GLenum; pname: GLenum; param: GLfixed); stdcall;
  glTexParameterxvOES: procedure(target: GLenum; pname: GLenum; const params: PGLfixed); stdcall;
  glTranslatexOES: procedure(x: GLfixed; y: GLfixed; z: GLfixed); stdcall;
  glAccumxOES: procedure(op: GLenum; value: GLfixed); stdcall;
  glBitmapxOES: procedure(width: GLsizei; height: GLsizei; xorig: GLfixed; yorig: GLfixed; xmove: GLfixed; ymove: GLfixed; const bitmap: PGLubyte); stdcall;
  glBlendColorxOES: procedure(red: GLfixed; green: GLfixed; blue: GLfixed; alpha: GLfixed); stdcall;
  glClearAccumxOES: procedure(red: GLfixed; green: GLfixed; blue: GLfixed; alpha: GLfixed); stdcall;
  glColor3xOES: procedure(red: GLfixed; green: GLfixed; blue: GLfixed); stdcall;
  glColor3xvOES: procedure(const components: PGLfixed); stdcall;
  glColor4xvOES: procedure(const components: PGLfixed); stdcall;
  glConvolutionParameterxOES: procedure(target: GLenum; pname: GLenum; param: GLfixed); stdcall;
  glConvolutionParameterxvOES: procedure(target: GLenum; pname: GLenum; const params: PGLfixed); stdcall;
  glEvalCoord1xOES: procedure(u: GLfixed); stdcall;
  glEvalCoord1xvOES: procedure(const coords: PGLfixed); stdcall;
  glEvalCoord2xOES: procedure(u: GLfixed; v: GLfixed); stdcall;
  glEvalCoord2xvOES: procedure(const coords: PGLfixed); stdcall;
  glFeedbackBufferxOES: procedure(n: GLsizei; _type: GLenum; const buffer: PGLfixed); stdcall;
  glGetConvolutionParameterxvOES: procedure(target: GLenum; pname: GLenum; params: PGLfixed); stdcall;
  glGetHistogramParameterxvOES: procedure(target: GLenum; pname: GLenum; params: PGLfixed); stdcall;
  glGetLightxOES: procedure(light: GLenum; pname: GLenum; params: PGLfixed); stdcall;
  glGetMapxvOES: procedure(target: GLenum; query: GLenum; v: PGLfixed); stdcall;
  glGetMaterialxOES: procedure(face: GLenum; pname: GLenum; param: GLfixed); stdcall;
  glGetPixelMapxv: procedure(map: GLenum; size: GLint; values: PGLfixed); stdcall;
  glGetTexGenxvOES: procedure(coord: GLenum; pname: GLenum; params: PGLfixed); stdcall;
  glGetTexLevelParameterxvOES: procedure(target: GLenum; level: GLint; pname: GLenum; params: PGLfixed); stdcall;
  glIndexxOES: procedure(component: GLfixed); stdcall;
  glIndexxvOES: procedure(const component: PGLfixed); stdcall;
  glLoadTransposeMatrixxOES: procedure(const m: PGLfixed); stdcall;
  glMap1xOES: procedure(target: GLenum; u1: GLfixed; u2: GLfixed; stride: GLint; order: GLint; points: GLfixed); stdcall;
  glMap2xOES: procedure(target: GLenum; u1: GLfixed; u2: GLfixed; ustride: GLint; uorder: GLint; v1: GLfixed; v2: GLfixed; vstride: GLint; vorder: GLint; points: GLfixed); stdcall;
  glMapGrid1xOES: procedure(n: GLint; u1: GLfixed; u2: GLfixed); stdcall;
  glMapGrid2xOES: procedure(n: GLint; u1: GLfixed; u2: GLfixed; v1: GLfixed; v2: GLfixed); stdcall;
  glMultTransposeMatrixxOES: procedure(const m: PGLfixed); stdcall;
  glMultiTexCoord1xOES: procedure(texture: GLenum; s: GLfixed); stdcall;
  glMultiTexCoord1xvOES: procedure(texture: GLenum; const coords: PGLfixed); stdcall;
  glMultiTexCoord2xOES: procedure(texture: GLenum; s: GLfixed; t: GLfixed); stdcall;
  glMultiTexCoord2xvOES: procedure(texture: GLenum; const coords: PGLfixed); stdcall;
  glMultiTexCoord3xOES: procedure(texture: GLenum; s: GLfixed; t: GLfixed; r: GLfixed); stdcall;
  glMultiTexCoord3xvOES: procedure(texture: GLenum; const coords: PGLfixed); stdcall;
  glMultiTexCoord4xvOES: procedure(texture: GLenum; const coords: PGLfixed); stdcall;
  glNormal3xvOES: procedure(const coords: PGLfixed); stdcall;
  glPassThroughxOES: procedure(token: GLfixed); stdcall;
  glPixelMapx: procedure(map: GLenum; size: GLint; const values: PGLfixed); stdcall;
  glPixelStorex: procedure(pname: GLenum; param: GLfixed); stdcall;
  glPixelTransferxOES: procedure(pname: GLenum; param: GLfixed); stdcall;
  glPixelZoomxOES: procedure(xfactor: GLfixed; yfactor: GLfixed); stdcall;
  glPrioritizeTexturesxOES: procedure(n: GLsizei; const textures: PGLuint; const priorities: PGLfixed); stdcall;
  glRasterPos2xOES: procedure(x: GLfixed; y: GLfixed); stdcall;
  glRasterPos2xvOES: procedure(const coords: PGLfixed); stdcall;
  glRasterPos3xOES: procedure(x: GLfixed; y: GLfixed; z: GLfixed); stdcall;
  glRasterPos3xvOES: procedure(const coords: PGLfixed); stdcall;
  glRasterPos4xOES: procedure(x: GLfixed; y: GLfixed; z: GLfixed; w: GLfixed); stdcall;
  glRasterPos4xvOES: procedure(const coords: PGLfixed); stdcall;
  glRectxOES: procedure(x1: GLfixed; y1: GLfixed; x2: GLfixed; y2: GLfixed); stdcall;
  glRectxvOES: procedure(const v1: PGLfixed; const v2: PGLfixed); stdcall;
  glTexCoord1xOES: procedure(s: GLfixed); stdcall;
  glTexCoord1xvOES: procedure(const coords: PGLfixed); stdcall;
  glTexCoord2xOES: procedure(s: GLfixed; t: GLfixed); stdcall;
  glTexCoord2xvOES: procedure(const coords: PGLfixed); stdcall;
  glTexCoord3xOES: procedure(s: GLfixed; t: GLfixed; r: GLfixed); stdcall;
  glTexCoord3xvOES: procedure(const coords: PGLfixed); stdcall;
  glTexCoord4xOES: procedure(s: GLfixed; t: GLfixed; r: GLfixed; q: GLfixed); stdcall;
  glTexCoord4xvOES: procedure(const coords: PGLfixed); stdcall;
  glTexGenxOES: procedure(coord: GLenum; pname: GLenum; param: GLfixed); stdcall;
  glTexGenxvOES: procedure(coord: GLenum; pname: GLenum; const params: PGLfixed); stdcall;
  glVertex2xOES: procedure(x: GLfixed); stdcall;
  glVertex2xvOES: procedure(const coords: PGLfixed); stdcall;
  glVertex3xOES: procedure(x: GLfixed; y: GLfixed); stdcall;
  glVertex3xvOES: procedure(const coords: PGLfixed); stdcall;
  glVertex4xOES: procedure(x: GLfixed; y: GLfixed; z: GLfixed); stdcall;
  glVertex4xvOES: procedure(const coords: PGLfixed); stdcall;
  {$EndIf}

  {$IfDef GL_OES_query_matrix}
  glQueryMatrixxOES: function(mantissa: PGLfixed; exponent: PGLint): GLbitfield; stdcall;
  {$EndIf}

  {$IfDef GL_OES_single_precision}
  glClearDepthfOES: procedure(depth: GLclampf); stdcall;
  glClipPlanefOES: procedure(plane: GLenum; const equation: PGLfloat); stdcall;
  glDepthRangefOES: procedure(n: GLclampf; f: GLclampf); stdcall;
  glFrustumfOES: procedure(l: GLfloat; r: GLfloat; b: GLfloat; t: GLfloat; n: GLfloat; f: GLfloat); stdcall;
  glGetClipPlanefOES: procedure(plane: GLenum; equation: PGLfloat); stdcall;
  glOrthofOES: procedure(l: GLfloat; r: GLfloat; b: GLfloat; t: GLfloat; n: GLfloat; f: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_3DFX_tbuffer}
  glTbufferMask3DFX: procedure(mask: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_debug_output}
  glDebugMessageEnableAMD: procedure(category: GLenum; severity: GLenum; count: GLsizei; const ids: PGLuint; enabled: GLboolean); stdcall;
  glDebugMessageInsertAMD: procedure(category: GLenum; severity: GLenum; id: GLuint; length: GLsizei; const buf: PGLchar); stdcall;
  glDebugMessageCallbackAMD: procedure(callback: GLDEBUGPROCAMD; userParam: pointer); stdcall;
  glGetDebugMessageLogAMD: function(count: GLuint; bufSize: GLsizei; categories: PGLenum; severities: PGLuint; ids: PGLuint; lengths: PGLsizei; _message: PGLchar): GLuint; stdcall;
  {$EndIf}

  {$IfDef GL_AMD_draw_buffers_blend}
  glBlendFuncIndexedAMD: procedure(buf: GLuint; src: GLenum; dst: GLenum); stdcall;
  glBlendFuncSeparateIndexedAMD: procedure(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); stdcall;
  glBlendEquationIndexedAMD: procedure(buf: GLuint; mode: GLenum); stdcall;
  glBlendEquationSeparateIndexedAMD: procedure(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_framebuffer_multisample_advanced}
  glRenderbufferStorageMultisampleAdvancedAMD: procedure(target: GLenum; samples: GLsizei; storageSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glNamedRenderbufferStorageMultisampleAdvancedAMD: procedure(renderbuffer: GLuint; samples: GLsizei; storageSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_framebuffer_sample_positions}
  glFramebufferSamplePositionsfvAMD: procedure(target: GLenum; numsamples: GLuint; pixelindex: GLuint; const values: PGLfloat); stdcall;
  glNamedFramebufferSamplePositionsfvAMD: procedure(framebuffer: GLuint; numsamples: GLuint; pixelindex: GLuint; const values: PGLfloat); stdcall;
  glGetFramebufferParameterfvAMD: procedure(target: GLenum; pname: GLenum; numsamples: GLuint; pixelindex: GLuint; size: GLsizei; values: PGLfloat); stdcall;
  glGetNamedFramebufferParameterfvAMD: procedure(framebuffer: GLuint; pname: GLenum; numsamples: GLuint; pixelindex: GLuint; size: GLsizei; values: PGLfloat); stdcall;
  {$EndIf}

  {$If defined(GL_AMD_gpu_shader_int64) or defined(GL_NV_gpu_shader5)}
  glUniform1i64NV: procedure(location: GLint; x: GLint64EXT); stdcall;
  glUniform2i64NV: procedure(location: GLint; x: GLint64EXT; y: GLint64EXT); stdcall;
  glUniform3i64NV: procedure(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT); stdcall;
  glUniform4i64NV: procedure(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT); stdcall;
  glUniform1i64vNV: procedure(location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glUniform2i64vNV: procedure(location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glUniform3i64vNV: procedure(location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glUniform4i64vNV: procedure(location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glUniform1ui64NV: procedure(location: GLint; x: GLuint64EXT); stdcall;
  glUniform2ui64NV: procedure(location: GLint; x: GLuint64EXT; y: GLuint64EXT); stdcall;
  glUniform3ui64NV: procedure(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT); stdcall;
  glUniform4ui64NV: procedure(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT); stdcall;
  glUniform1ui64vNV: procedure(location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glUniform2ui64vNV: procedure(location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glUniform3ui64vNV: procedure(location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glUniform4ui64vNV: procedure(location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glGetUniformi64vNV: procedure(_program: GLuint; location: GLint; params: PGLint64EXT); stdcall;
  glProgramUniform1i64NV: procedure(_program: GLuint; location: GLint; x: GLint64EXT); stdcall;
  glProgramUniform2i64NV: procedure(_program: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT); stdcall;
  glProgramUniform3i64NV: procedure(_program: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT); stdcall;
  glProgramUniform4i64NV: procedure(_program: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT); stdcall;
  glProgramUniform1i64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glProgramUniform2i64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glProgramUniform3i64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glProgramUniform4i64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint64EXT); stdcall;
  glProgramUniform1ui64NV: procedure(_program: GLuint; location: GLint; x: GLuint64EXT); stdcall;
  glProgramUniform2ui64NV: procedure(_program: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT); stdcall;
  glProgramUniform3ui64NV: procedure(_program: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT); stdcall;
  glProgramUniform4ui64NV: procedure(_program: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT); stdcall;
  glProgramUniform1ui64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glProgramUniform2ui64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glProgramUniform3ui64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glProgramUniform4ui64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  {$IfEnd}
  {$If defined(GL_AMD_gpu_shader_int64) or defined(GL_NV_shader_buffer_load)}
  glGetUniformui64vNV: procedure(_program: GLuint; location: GLint; params: PGLuint64EXT); stdcall;
  {$IfEnd}

  {$IfDef GL_AMD_interleaved_elements}
  glVertexAttribParameteriAMD: procedure(index: GLuint; pname: GLenum; param: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_multi_draw_indirect}
  glMultiDrawArraysIndirectAMD: procedure(mode: GLenum; const indirect: pointer; primcount: GLsizei; stride: GLsizei); stdcall;
  glMultiDrawElementsIndirectAMD: procedure(mode: GLenum; _type: GLenum; const indirect: pointer; primcount: GLsizei; stride: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_name_gen_delete}
  glGenNamesAMD: procedure(identifier: GLenum; num: GLuint; names: PGLuint); stdcall;
  glDeleteNamesAMD: procedure(identifier: GLenum; num: GLuint; const names: PGLuint); stdcall;
  glIsNameAMD: function(identifier: GLenum; name: GLuint): GLboolean; stdcall;
  {$EndIf}

  {$IfDef GL_AMD_occlusion_query_event}
  glQueryObjectParameteruiAMD: procedure(target: GLenum; id: GLuint; pname: GLenum; param: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_performance_monitor}
  glGetPerfMonitorGroupsAMD: procedure(numGroups: PGLint; groupsSize: GLsizei; groups: PGLuint); stdcall;
  glGetPerfMonitorCountersAMD: procedure(group: GLuint; numCounters: PGLint; maxActiveCounters: PGLint; counterSize: GLsizei; counters: PGLuint); stdcall;
  glGetPerfMonitorGroupStringAMD: procedure(group: GLuint; bufSize: GLsizei; length: PGLsizei; groupString: PGLchar); stdcall;
  glGetPerfMonitorCounterStringAMD: procedure(group: GLuint; counter: GLuint; bufSize: GLsizei; length: PGLsizei; counterString: PGLchar); stdcall;
  glGetPerfMonitorCounterInfoAMD: procedure(group: GLuint; counter: GLuint; pname: GLenum; data: pointer); stdcall;
  glGenPerfMonitorsAMD: procedure(n: GLsizei; monitors: PGLuint); stdcall;
  glDeletePerfMonitorsAMD: procedure(n: GLsizei; monitors: PGLuint); stdcall;
  glSelectPerfMonitorCountersAMD: procedure(monitor: GLuint; enable: GLboolean; group: GLuint; numCounters: GLint; counterList: PGLuint); stdcall;
  glBeginPerfMonitorAMD: procedure(monitor: GLuint); stdcall;
  glEndPerfMonitorAMD: procedure(monitor: GLuint); stdcall;
  glGetPerfMonitorCounterDataAMD: procedure(monitor: GLuint; pname: GLenum; dataSize: GLsizei; data: PGLuint; bytesWritten: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_sample_positions}
  glSetMultisamplefvAMD: procedure(pname: GLenum; index: GLuint; const val: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_sparse_texture}
  glTexStorageSparseAMD: procedure(target: GLenum; internalFormat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; layers: GLsizei; flags: GLbitfield); stdcall;
  glTextureStorageSparseAMD: procedure(texture: GLuint; target: GLenum; internalFormat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; layers: GLsizei; flags: GLbitfield); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_stencil_operation_extended}
  glStencilOpValueAMD: procedure(face: GLenum; value: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_AMD_vertex_shader_tessellator}
  glTessellationFactorAMD: procedure(factor: GLfloat); stdcall;
  glTessellationModeAMD: procedure(mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_element_array}
  glElementPointerAPPLE: procedure(_type: GLenum; const _pointer: pointer); stdcall;
  glDrawElementArrayAPPLE: procedure(mode: GLenum; first: GLint; count: GLsizei); stdcall;
  glDrawRangeElementArrayAPPLE: procedure(mode: GLenum; start: GLuint; _end: GLuint; first: GLint; count: GLsizei); stdcall;
  glMultiDrawElementArrayAPPLE: procedure(mode: GLenum; const first: PGLint; const count: PGLsizei; primcount: GLsizei); stdcall;
  glMultiDrawRangeElementArrayAPPLE: procedure(mode: GLenum; start: GLuint; _end: GLuint; const first: PGLint; const count: PGLsizei; primcount: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_fence}
  glGenFencesAPPLE: procedure(n: GLsizei; fences: PGLuint); stdcall;
  glDeleteFencesAPPLE: procedure(n: GLsizei; const fences: PGLuint); stdcall;
  glSetFenceAPPLE: procedure(fence: GLuint); stdcall;
  glIsFenceAPPLE: function(fence: GLuint): GLboolean; stdcall;
  glTestFenceAPPLE: function(fence: GLuint): GLboolean; stdcall;
  glFinishFenceAPPLE: procedure(fence: GLuint); stdcall;
  glTestObjectAPPLE: function(_object: GLenum; name: GLuint): GLboolean; stdcall;
  glFinishObjectAPPLE: procedure(_object: GLenum; name: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_flush_buffer_range}
  glBufferParameteriAPPLE: procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;
  glFlushMappedBufferRangeAPPLE: procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr); stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_object_purgeable}
  glObjectPurgeableAPPLE: function(objectType: GLenum; name: GLuint; option: GLenum): GLenum; stdcall;
  glObjectUnpurgeableAPPLE: function(objectType: GLenum; name: GLuint; option: GLenum): GLenum; stdcall;
  glGetObjectParameterivAPPLE: procedure(objectType: GLenum; name: GLuint; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_texture_range}
  glTextureRangeAPPLE: procedure(target: GLenum; length: GLsizei; const _pointer: pointer); stdcall;
  glGetTexParameterPointervAPPLE: procedure(target: GLenum; pname: GLenum; params:Ppointer); stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_vertex_array_object}
  glBindVertexArrayAPPLE: procedure(_array: GLuint); stdcall;
  glDeleteVertexArraysAPPLE: procedure(n: GLsizei; const arrays: PGLuint); stdcall;
  glGenVertexArraysAPPLE: procedure(n: GLsizei; arrays: PGLuint); stdcall;
  functionglIsVertexArrayAPPLE: function(_array: GLuint): GLboolean; stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_vertex_array_range}
  glVertexArrayRangeAPPLE: procedure(length: GLsizei; pointer: pointer); stdcall;
  glFlushVertexArrayRangeAPPLE: procedure(length: GLsizei; pointer: pointer); stdcall;
  glVertexArrayParameteriAPPLE: procedure(pname: GLenum; param: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_APPLE_vertex_program_evaluators}
  glEnableVertexAttribAPPLE: procedure(index: GLuint; pname: GLenum); stdcall;
  glDisableVertexAttribAPPLE: procedure(index: GLuint; pname: GLenum); stdcall;
  glIsVertexAttribEnabledAPPLE: function(index: GLuint; pname: GLenum): GLboolean; stdcall;
  glMapVertexAttrib1dAPPLE: procedure(index: GLuint; size: GLuint; u1: GLdouble; u2: GLdouble; stride: GLint; order: GLint; const points: PGLdouble); stdcall;
  glMapVertexAttrib1fAPPLE: procedure(index: GLuint; size: GLuint; u1: GLfloat; u2: GLfloat; stride: GLint; order: GLint; const points: PGLfloat); stdcall;
  glMapVertexAttrib2dAPPLE: procedure(index: GLuint; size: GLuint; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; const points: PGLdouble); stdcall;
  glMapVertexAttrib2fAPPLE: procedure(index: GLuint; size: GLuint; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; const points: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_draw_buffers}
  glDrawBuffersATI: procedure(n: GLsizei; const bufs: PGLenum); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_element_array}
  glElementPointerATI: procedure(_type: GLenum; const _pointer: pointer); stdcall;
  glDrawElementArrayATI: procedure(mode: GLenum; count: GLsizei); stdcall;
  glDrawRangeElementArrayATI: procedure(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_envmap_bumpmap}
  glTexBumpParameterivATI: procedure(pname: GLenum; const param: PGLint); stdcall;
  glTexBumpParameterfvATI: procedure(pname: GLenum; const param: PGLfloat); stdcall;
  glGetTexBumpParameterivATI: procedure(pname: GLenum; param: PGLint); stdcall;
  glGetTexBumpParameterfvATI: procedure(pname: GLenum; param: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_fragment_shader}
  glGenFragmentShadersATI: function(range: GLuint): GLuint; stdcall;
  glBindFragmentShaderATI: procedure(id: GLuint); stdcall;
  glDeleteFragmentShaderATI: procedure(id: GLuint); stdcall;
  glBeginFragmentShaderATI: procedure;  stdcall;
  glEndFragmentShaderATI: procedure; stdcall;
  glPassTexCoordATI: procedure(dst: GLuint; coord: GLuint; swizzle: GLenum); stdcall;
  glSampleMapATI: procedure(dst: GLuint; interp: GLuint; swizzle: GLenum); stdcall;
  glColorFragmentOp1ATI: procedure(op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint); stdcall;
  glColorFragmentOp2ATI: procedure(op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint); stdcall;
  glColorFragmentOp3ATI: procedure(op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint; arg3: GLuint; arg3Rep: GLuint; arg3Mod: GLuint); stdcall;
  glAlphaFragmentOp1ATI: procedure(op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint); stdcall;
  glAlphaFragmentOp2ATI: procedure(op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint); stdcall;
  glAlphaFragmentOp3ATI: procedure(op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint; arg3: GLuint; arg3Rep: GLuint; arg3Mod: GLuint); stdcall;
  glSetFragmentShaderConstantATI: procedure(dst: GLuint; const value: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_map_object_buffer}
  glMapObjectBufferATI: function(buffer: GLuint): pointer;
  glUnmapObjectBufferATI: procedure(buffer: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_pn_triangles}
  glPNTrianglesiATI: procedure(pname: GLenum; param: GLint); stdcall;
  glPNTrianglesfATI: procedure(pname: GLenum; param: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_separate_stencil}
  glStencilOpSeparateATI: procedure(face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum); stdcall;
  glStencilFuncSeparateATI: procedure(frontfunc: GLenum; backfunc: GLenum; ref: GLint; mask: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_vertex_array_object}
  glNewObjectBufferATI: function(size: GLsizei; const _pointer: pointer; usage: GLenum): GLuint; stdcall;
  glIsObjectBufferATI: function(buffer: GLuint): GLboolean; stdcall;
  glUpdateObjectBufferATI: procedure(buffer: GLuint; offset: GLuint; size: GLsizei; const _pointer: pointer; preserve: GLenum); stdcall;
  glGetObjectBufferfvATI: procedure(buffer: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetObjectBufferivATI: procedure(buffer: GLuint; pname: GLenum; params: PGLint); stdcall;
  glFreeObjectBufferATI: procedure(buffer: GLuint); stdcall;
  glArrayObjectATI: procedure(_array: GLenum; size: GLint; _type: GLenum; stride: GLsizei; buffer: GLuint; offset: GLuint); stdcall;
  glGetArrayObjectfvATI: procedure(_array: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetArrayObjectivATI: procedure(_array: GLenum; pname: GLenum; params: PGLint); stdcall;
  glVariantArrayObjectATI: procedure(id: GLuint; _type: GLenum; stride: GLsizei; buffer: GLuint; offset: GLuint); stdcall;
  glGetVariantArrayObjectfvATI: procedure(id: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetVariantArrayObjectivATI: procedure(id: GLuint; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_vertex_attrib_array_object}
  glVertexAttribArrayObjectATI: procedure(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei; buffer: GLuint; offset: GLuint); stdcall;
  glGetVertexAttribArrayObjectfvATI: procedure(index: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetVertexAttribArrayObjectivATI: procedure(index: GLuint; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_ATI_vertex_streams}
  glVertexStream1sATI: procedure(stream: GLenum; x: GLshort); stdcall;
  glVertexStream1svATI: procedure(stream: GLenum; const coords: PGLshort); stdcall;
  glVertexStream1iATI: procedure(stream: GLenum; x: GLint); stdcall;
  glVertexStream1ivATI: procedure(stream: GLenum; const coords: PGLint); stdcall;
  glVertexStream1fATI: procedure(stream: GLenum; x: GLfloat); stdcall;
  glVertexStream1fvATI: procedure(stream: GLenum; const coords: PGLfloat); stdcall;
  glVertexStream1dATI: procedure(stream: GLenum; x: GLdouble); stdcall;
  glVertexStream1dvATI: procedure(stream: GLenum; const coords: PGLdouble); stdcall;
  glVertexStream2sATI: procedure(stream: GLenum; x: GLshort; y: GLshort); stdcall;
  glVertexStream2svATI: procedure(stream: GLenum; const coords: PGLshort); stdcall;
  glVertexStream2iATI: procedure(stream: GLenum; x: GLint; y: GLint); stdcall;
  glVertexStream2ivATI: procedure(stream: GLenum; const coords: PGLint); stdcall;
  glVertexStream2fATI: procedure(stream: GLenum; x: GLfloat; y: GLfloat); stdcall;
  glVertexStream2fvATI: procedure(stream: GLenum; const coords: PGLfloat); stdcall;
  glVertexStream2dATI: procedure(stream: GLenum; x: GLdouble; y: GLdouble); stdcall;
  glVertexStream2dvATI: procedure(stream: GLenum; const coords: PGLdouble); stdcall;
  glVertexStream3sATI: procedure(stream: GLenum; x: GLshort; y: GLshort; z: GLshort); stdcall;
  glVertexStream3svATI: procedure(stream: GLenum; const coords: PGLshort); stdcall;
  glVertexStream3iATI: procedure(stream: GLenum; x: GLint; y: GLint; z: GLint); stdcall;
  glVertexStream3ivATI: procedure(stream: GLenum; const coords: PGLint); stdcall;
  glVertexStream3fATI: procedure(stream: GLenum; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glVertexStream3fvATI: procedure(stream: GLenum; const coords: PGLfloat); stdcall;
  glVertexStream3dATI: procedure(stream: GLenum; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glVertexStream3dvATI: procedure(stream: GLenum; const coords: PGLdouble); stdcall;
  glVertexStream4sATI: procedure(stream: GLenum; x: GLshort; y: GLshort; z: GLshort; w: GLshort); stdcall;
  glVertexStream4svATI: procedure(stream: GLenum; const coords: PGLshort); stdcall;
  glVertexStream4iATI: procedure(stream: GLenum; x: GLint; y: GLint; z: GLint; w: GLint); stdcall;
  glVertexStream4ivATI: procedure(stream: GLenum; const coords: PGLint); stdcall;
  glVertexStream4fATI: procedure(stream: GLenum; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glVertexStream4fvATI: procedure(stream: GLenum; const coords: PGLfloat); stdcall;
  glVertexStream4dATI: procedure(stream: GLenum; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glVertexStream4dvATI: procedure(stream: GLenum; const coords: PGLdouble); stdcall;
  glNormalStream3bATI: procedure(stream: GLenum; nx: GLbyte; ny: GLbyte; nz: GLbyte); stdcall;
  glNormalStream3bvATI: procedure(stream: GLenum; const coords: PGLbyte); stdcall;
  glNormalStream3sATI: procedure(stream: GLenum; nx: GLshort; ny: GLshort; nz: GLshort); stdcall;
  glNormalStream3svATI: procedure(stream: GLenum; const coords: PGLshort); stdcall;
  glNormalStream3iATI: procedure(stream: GLenum; nx: GLint; ny: GLint; nz: GLint); stdcall;
  glNormalStream3ivATI: procedure(stream: GLenum; const coords: PGLint); stdcall;
  glNormalStream3fATI: procedure(stream: GLenum; nx: GLfloat; ny: GLfloat; nz: GLfloat); stdcall;
  glNormalStream3fvATI: procedure(stream: GLenum; const coords: PGLfloat); stdcall;
  glNormalStream3dATI: procedure(stream: GLenum; nx: GLdouble; ny: GLdouble; nz: GLdouble); stdcall;
  glNormalStream3dvATI: procedure(stream: GLenum; const coords: PGLdouble); stdcall;
  glClientActiveVertexStreamATI: procedure(stream: GLenum); stdcall;
  glVertexBlendEnviATI: procedure(pname: GLenum; param: GLint); stdcall;
  glVertexBlendEnvfATI: procedure(pname: GLenum; param: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_EGL_image_storage}
  glEGLImageTargetTexStorageEXT: procedure(target: GLenum; image: GLeglImageOES; const attrib_list: PGLint); stdcall;
  glEGLImageTargetTextureStorageEXT: procedure(texture: GLuint; image: GLeglImageOES; const attrib_list: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_bindable_uniform}
  glUniformBufferEXT: procedure(_program: GLuint; location: GLint; buffer: GLuint); stdcall;
  glGetUniformBufferSizeEXT: function(_program: GLuint; location: GLint): GLint; stdcall;
  glGetUniformOffsetEXT: function(_program: GLuint; location: GLint): GLintptr; stdcall;
  {$EndIf}

  {$IfDef GL_EXT_blend_color}
  glBlendColorEXT: procedure(red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_blend_equation_separate}
  glBlendEquationSeparateEXT: procedure(modeRGB: GLenum; modeAlpha: GLenum); stdcall;
  {$EndIf}

(*  {$IfDef GL_EXT_blend_func_separate}
  glBlendFuncSeparateEXT: procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_blend_minmax}
  glBlendEquationEXT: procedure(mode: GLenum); stdcall;
  {$EndIf}   *)

  {$IfDef GL_EXT_color_subtable}
  glColorSubTableEXT: procedure(target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glCopyColorSubTableEXT: procedure(target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_compiled_vertex_array}
  glLockArraysEXT: procedure(first: GLint; count: GLsizei); stdcall;
  glUnlockArraysEXT: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_EXT_convolution}
  glConvolutionFilter1DEXT: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; const image: pointer); stdcall;
  glConvolutionFilter2DEXT: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const image: pointer); stdcall;
  glConvolutionParameterfEXT: procedure(target: GLenum; pname: GLenum; params: GLfloat); stdcall;
  glConvolutionParameterfvEXT: procedure(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glConvolutionParameteriEXT: procedure(target: GLenum; pname: GLenum; params: GLint); stdcall;
  glConvolutionParameterivEXT: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glCopyConvolutionFilter1DEXT: procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei); stdcall;
  glCopyConvolutionFilter2DEXT: procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glGetConvolutionFilterEXT: procedure(target: GLenum; format: GLenum; _type: GLenum; image: pointer); stdcall;
  glGetConvolutionParameterfvEXT: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetConvolutionParameterivEXT: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetSeparableFilterEXT: procedure(target: GLenum; format: GLenum; _type: GLenum; row: pointer; column: pointer; span: pointer); stdcall;
  glSeparableFilter2DEXT: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const row: pointer; const column: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_coordinate_frame}
  glTangent3bEXT: procedure(tx: GLbyte; ty: GLbyte; tz: GLbyte); stdcall;
  glTangent3bvEXT: procedure(const v: PGLbyte); stdcall;
  glTangent3dEXT: procedure(tx: GLdouble; ty: GLdouble; tz: GLdouble); stdcall;
  glTangent3dvEXT: procedure(const v: PGLdouble); stdcall;
  glTangent3fEXT: procedure(tx: GLfloat; ty: GLfloat; tz: GLfloat); stdcall;
  glTangent3fvEXT: procedure(const v: PGLfloat); stdcall;
  glTangent3iEXT: procedure(tx: GLint; ty: GLint; tz: GLint); stdcall;
  glTangent3ivEXT: procedure(const v: PGLint); stdcall;
  glTangent3sEXT: procedure(tx: GLshort; ty: GLshort; tz: GLshort); stdcall;
  glTangent3svEXT: procedure(const v: PGLshort); stdcall;
  glBinormal3bEXT: procedure(bx: GLbyte; by: GLbyte; bz: GLbyte); stdcall;
  glBinormal3bvEXT: procedure(const v: PGLbyte); stdcall;
  glBinormal3dEXT: procedure(bx: GLdouble; by: GLdouble; bz: GLdouble); stdcall;
  glBinormal3dvEXT: procedure(const v: PGLdouble); stdcall;
  glBinormal3fEXT: procedure(bx: GLfloat; by: GLfloat; bz: GLfloat); stdcall;
  glBinormal3fvEXT: procedure(const v: PGLfloat); stdcall;
  glBinormal3iEXT: procedure(bx: GLint; by: GLint; bz: GLint); stdcall;
  glBinormal3ivEXT: procedure(const v: PGLint); stdcall;
  glBinormal3sEXT: procedure(bx: GLshort; by: GLshort; bz: GLshort); stdcall;
  glBinormal3svEXT: procedure(const v: PGLshort); stdcall;
  glTangentPointerEXT: procedure(_type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glBinormalPointerEXT: procedure(_type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_copy_texture}
  glCopyTexImage1DEXT: procedure(target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint); stdcall;
  glCopyTexImage2DEXT: procedure(target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint); stdcall;
  glCopyTexSubImage1DEXT: procedure(target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei); stdcall;
  glCopyTexSubImage2DEXT: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glCopyTexSubImage3DEXT: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_cull_vertex}
  glCullParameterdvEXT: procedure(pname: GLenum; params: PGLdouble); stdcall;
  glCullParameterfvEXT: procedure(pname: GLenum; params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_debug_label}
  glLabelObjectEXT: procedure(_type: GLenum; _object: GLuint; length: GLsizei; const _label: PGLchar); stdcall;
  glGetObjectLabelEXT: procedure(_type: GLenum; _object: GLuint; bufSize: GLsizei; length: PGLsizei; _label: PGLchar); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_debug_marker}
  glInsertEventMarkerEXT: procedure(length: GLsizei; const marker: PGLchar); stdcall;
  glPushGroupMarkerEXT: procedure(length: GLsizei; const marker: PGLchar); stdcall;
  glPopGroupMarkerEXT: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_EXT_depth_bounds_test}
  glDepthBoundsEXT: procedure(zmin: GLclampd; zmax: GLclampd); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_direct_state_access}
  glMatrixLoadfEXT: procedure(mode: GLenum; const m: PGLfloat); stdcall;
  glMatrixLoaddEXT: procedure(mode: GLenum; const m: PGLdouble); stdcall;
  glMatrixMultfEXT: procedure(mode: GLenum; const m: PGLfloat); stdcall;
  glMatrixMultdEXT: procedure(mode: GLenum; const m: PGLdouble); stdcall;
  glMatrixLoadIdentityEXT: procedure(mode: GLenum); stdcall;
  glMatrixRotatefEXT: procedure(mode: GLenum; angle: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glMatrixRotatedEXT: procedure(mode: GLenum; angle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glMatrixScalefEXT: procedure(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glMatrixScaledEXT: procedure(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glMatrixTranslatefEXT: procedure(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glMatrixTranslatedEXT: procedure(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glMatrixFrustumEXT: procedure(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble); stdcall;
  glMatrixOrthoEXT: procedure(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble); stdcall;
  glMatrixPopEXT: procedure(mode: GLenum); stdcall;
  glMatrixPushEXT: procedure(mode: GLenum); stdcall;
  glClientAttribDefaultEXT: procedure(mask: GLbitfield); stdcall;
  glPushClientAttribDefaultEXT: procedure(mask: GLbitfield); stdcall;
  glTextureParameterfEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glTextureParameterfvEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glTextureParameteriEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; param: GLint); stdcall;
  glTextureParameterivEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glTextureImage1DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTextureImage2DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTextureSubImage1DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTextureSubImage2DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glCopyTextureImage1DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint); stdcall;
  glCopyTextureImage2DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint); stdcall;
  glCopyTextureSubImage1DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei); stdcall;
  glCopyTextureSubImage2DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glGetTextureImageEXT: procedure(texture: GLuint; target: GLenum; level: GLint; format: GLenum; _type: GLenum; pixels: pointer); stdcall;
  glGetTextureParameterfvEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetTextureParameterivEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetTextureLevelParameterfvEXT: procedure(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); stdcall;
  glGetTextureLevelParameterivEXT: procedure(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: PGLint); stdcall;
  glTextureImage3DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTextureSubImage3DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glCopyTextureSubImage3DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glBindMultiTextureEXT: procedure(texunit: GLenum; target: GLenum; texture: GLuint); stdcall;
  glMultiTexCoordPointerEXT: procedure(texunit: GLenum; size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glMultiTexEnvfEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glMultiTexEnvfvEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glMultiTexEnviEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint); stdcall;
  glMultiTexEnvivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glMultiTexGendEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; param: GLdouble); stdcall;
  glMultiTexGendvEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; const params: PGLdouble); stdcall;
  glMultiTexGenfEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glMultiTexGenfvEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glMultiTexGeniEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; param: GLint); stdcall;
  glMultiTexGenivEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glGetMultiTexEnvfvEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetMultiTexEnvivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetMultiTexGendvEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLdouble); stdcall;
  glGetMultiTexGenfvEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetMultiTexGenivEXT: procedure(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLint); stdcall;
  glMultiTexParameteriEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint); stdcall;
  glMultiTexParameterivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glMultiTexParameterfEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glMultiTexParameterfvEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glMultiTexImage1DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glMultiTexImage2DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glMultiTexSubImage1DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glMultiTexSubImage2DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glCopyMultiTexImage1DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint); stdcall;
  glCopyMultiTexImage2DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint); stdcall;
  glCopyMultiTexSubImage1DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei); stdcall;
  glCopyMultiTexSubImage2DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glGetMultiTexImageEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; format: GLenum; _type: GLenum; pixels: pointer); stdcall;
  glGetMultiTexParameterfvEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetMultiTexParameterivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetMultiTexLevelParameterfvEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); stdcall;
  glGetMultiTexLevelParameterivEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLint); stdcall;
  glMultiTexImage3DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glMultiTexSubImage3DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glCopyMultiTexSubImage3DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glEnableClientStateIndexedEXT: procedure(_array: GLenum; index: GLuint); stdcall;
  glDisableClientStateIndexedEXT: procedure(_array: GLenum; index: GLuint); stdcall;
  glGetFloatIndexedvEXT: procedure(target: GLenum; index: GLuint; data: PGLfloat); stdcall;
  glGetDoubleIndexedvEXT: procedure(target: GLenum; index: GLuint; data: PGLdouble); stdcall;
  glGetPointerIndexedvEXT: procedure(target: GLenum; index: GLuint; data:Ppointer); stdcall;
  glEnableIndexedEXT: procedure(target: GLenum; index: GLuint); stdcall;
  glDisableIndexedEXT: procedure(target: GLenum; index: GLuint); stdcall;
  glIsEnabledIndexedEXT: function(target: GLenum; index: GLuint): GLboolean; stdcall;
  glGetIntegerIndexedvEXT: procedure(target: GLenum; index: GLuint; data: PGLint); stdcall;
  glGetBooleanIndexedvEXT: procedure(target: GLenum; index: GLuint; data: PGLboolean); stdcall;
  glCompressedTextureImage3DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedTextureImage2DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedTextureImage1DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedTextureSubImage3DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedTextureSubImage2DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedTextureSubImage1DEXT: procedure(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; const bits: pointer); stdcall;
  glGetCompressedTextureImageEXT: procedure(texture: GLuint; target: GLenum; lod: GLint; img: pointer); stdcall;
  glCompressedMultiTexImage3DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedMultiTexImage2DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedMultiTexImage1DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedMultiTexSubImage3DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedMultiTexSubImage2DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; const bits: pointer); stdcall;
  glCompressedMultiTexSubImage1DEXT: procedure(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; const bits: pointer); stdcall;
  glGetCompressedMultiTexImageEXT: procedure(texunit: GLenum; target: GLenum; lod: GLint; img: pointer); stdcall;
  glMatrixLoadTransposefEXT: procedure(mode: GLenum; const m: PGLfloat); stdcall;
  glMatrixLoadTransposedEXT: procedure(mode: GLenum; const m: PGLdouble); stdcall;
  glMatrixMultTransposefEXT: procedure(mode: GLenum; const m: PGLfloat); stdcall;
  glMatrixMultTransposedEXT: procedure(mode: GLenum; const m: PGLdouble); stdcall;
  glNamedBufferDataEXT: procedure(buffer: GLuint; size: GLsizeiptr; const data: pointer; usage: GLenum); stdcall;
  glNamedBufferSubDataEXT: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; const data: pointer); stdcall;
  glMapNamedBufferEXT: function(buffer: GLuint; access: GLenum): pointer; stdcall;
  glUnmapNamedBufferEXT: function(buffer: GLuint): GLboolean; stdcall;
  glGetNamedBufferParameterivEXT: procedure(buffer: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetNamedBufferPointervEXT: procedure(buffer: GLuint; pname: GLenum; params:Ppointer); stdcall;
  glGetNamedBufferSubDataEXT: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; data: pointer); stdcall;
  glProgramUniform1fEXT: procedure(_program: GLuint; location: GLint; v0: GLfloat); stdcall;
  glProgramUniform2fEXT: procedure(_program: GLuint; location: GLint; v0: GLfloat; v1: GLfloat); stdcall;
  glProgramUniform3fEXT: procedure(_program: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); stdcall;
  glProgramUniform4fEXT: procedure(_program: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); stdcall;
  glProgramUniform1iEXT: procedure(_program: GLuint; location: GLint; v0: GLint); stdcall;
  glProgramUniform2iEXT: procedure(_program: GLuint; location: GLint; v0: GLint; v1: GLint); stdcall;
  glProgramUniform3iEXT: procedure(_program: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint); stdcall;
  glProgramUniform4iEXT: procedure(_program: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); stdcall;
  glProgramUniform1fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform2fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform3fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform4fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); stdcall;
  glProgramUniform1ivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniform2ivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniform3ivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniform4ivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLint); stdcall;
  glProgramUniformMatrix2fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix3fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix4fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix2x3fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix3x2fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix2x4fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix4x2fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix3x4fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glProgramUniformMatrix4x3fvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); stdcall;
  glTextureBufferEXT: procedure(texture: GLuint; target: GLenum; internalformat: GLenum; buffer: GLuint); stdcall;
  glMultiTexBufferEXT: procedure(texunit: GLenum; target: GLenum; internalformat: GLenum; buffer: GLuint); stdcall;
  glTextureParameterIivEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glTextureParameterIuivEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; const params: PGLuint); stdcall;
  glGetTextureParameterIivEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetTextureParameterIuivEXT: procedure(texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint); stdcall;
  glMultiTexParameterIivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glMultiTexParameterIuivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; const params: PGLuint); stdcall;
  glGetMultiTexParameterIivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetMultiTexParameterIuivEXT: procedure(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLuint); stdcall;
  glProgramUniform1uiEXT: procedure(_program: GLuint; location: GLint; v0: GLuint); stdcall;
  glProgramUniform2uiEXT: procedure(_program: GLuint; location: GLint; v0: GLuint; v1: GLuint); stdcall;
  glProgramUniform3uiEXT: procedure(_program: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); stdcall;
  glProgramUniform4uiEXT: procedure(_program: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); stdcall;
  glProgramUniform1uivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glProgramUniform2uivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glProgramUniform3uivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glProgramUniform4uivEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glNamedProgramLocalParameters4fvEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; count: GLsizei; const params: PGLfloat); stdcall;
  glNamedProgramLocalParameterI4iEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); stdcall;
  glNamedProgramLocalParameterI4ivEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; const params: PGLint); stdcall;
  glNamedProgramLocalParametersI4ivEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; count: GLsizei; const params: PGLint); stdcall;
  glNamedProgramLocalParameterI4uiEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); stdcall;
  glNamedProgramLocalParameterI4uivEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; const params: PGLuint); stdcall;
  glNamedProgramLocalParametersI4uivEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; count: GLsizei; const params: PGLuint); stdcall;
  glGetNamedProgramLocalParameterIivEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; params: PGLint); stdcall;
  glGetNamedProgramLocalParameterIuivEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; params: PGLuint); stdcall;
  glEnableClientStateiEXT: procedure(_array: GLenum; index: GLuint); stdcall;
  glDisableClientStateiEXT: procedure(_array: GLenum; index: GLuint); stdcall;
  glGetFloati_vEXT: procedure(pname: GLenum; index: GLuint; params: PGLfloat); stdcall;
  glGetDoublei_vEXT: procedure(pname: GLenum; index: GLuint; params: PGLdouble); stdcall;
  glGetPointeri_vEXT: procedure(pname: GLenum; index: GLuint; params:Ppointer); stdcall;
  glNamedProgramStringEXT: procedure(_program: GLuint; target: GLenum; format: GLenum; len: GLsizei; const _string: pointer); stdcall;
  glNamedProgramLocalParameter4dEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glNamedProgramLocalParameter4dvEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; const params: PGLdouble); stdcall;
  glNamedProgramLocalParameter4fEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glNamedProgramLocalParameter4fvEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; const params: PGLfloat); stdcall;
  glGetNamedProgramLocalParameterdvEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; params: PGLdouble); stdcall;
  glGetNamedProgramLocalParameterfvEXT: procedure(_program: GLuint; target: GLenum; index: GLuint; params: PGLfloat); stdcall;
  glGetNamedProgramivEXT: procedure(_program: GLuint; target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetNamedProgramStringEXT: procedure(_program: GLuint; target: GLenum; pname: GLenum; _string: pointer); stdcall;
  glNamedRenderbufferStorageEXT: procedure(renderbuffer: GLuint; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glGetNamedRenderbufferParameterivEXT: procedure(renderbuffer: GLuint; pname: GLenum; params: PGLint); stdcall;
  glNamedRenderbufferStorageMultisampleEXT: procedure(renderbuffer: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glNamedRenderbufferStorageMultisampleCoverageEXT: procedure(renderbuffer: GLuint; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glCheckNamedFramebufferStatusEXT: function(framebuffer: GLuint; target: GLenum): GLenum; stdcall;
  glNamedFramebufferTexture1DEXT: procedure(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
  glNamedFramebufferTexture2DEXT: procedure(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
  glNamedFramebufferTexture3DEXT: procedure(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint); stdcall;
  glNamedFramebufferRenderbufferEXT: procedure(framebuffer: GLuint; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;
  glGetNamedFramebufferAttachmentParameterivEXT: procedure(framebuffer: GLuint; attachment: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGenerateTextureMipmapEXT: procedure(texture: GLuint; target: GLenum); stdcall;
  glGenerateMultiTexMipmapEXT: procedure(texunit: GLenum; target: GLenum); stdcall;
  glFramebufferDrawBufferEXT: procedure(framebuffer: GLuint; mode: GLenum); stdcall;
  glFramebufferDrawBuffersEXT: procedure(framebuffer: GLuint; n: GLsizei; const bufs: PGLenum); stdcall;
  glFramebufferReadBufferEXT: procedure(framebuffer: GLuint; mode: GLenum); stdcall;
  glGetFramebufferParameterivEXT: procedure(framebuffer: GLuint; pname: GLenum; params: PGLint); stdcall;
  glNamedCopyBufferSubDataEXT: procedure(readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr); stdcall;
  glNamedFramebufferTextureEXT: procedure(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint); stdcall;
  glNamedFramebufferTextureLayerEXT: procedure(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); stdcall;
  glNamedFramebufferTextureFaceEXT: procedure(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); stdcall;
  glTextureRenderbufferEXT: procedure(texture: GLuint; target: GLenum; renderbuffer: GLuint); stdcall;
  glMultiTexRenderbufferEXT: procedure(texunit: GLenum; target: GLenum; renderbuffer: GLuint); stdcall;
  glVertexArrayVertexOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; size: GLint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayColorOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; size: GLint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayEdgeFlagOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayIndexOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayNormalOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayTexCoordOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; size: GLint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayMultiTexCoordOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; texunit: GLenum; size: GLint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayFogCoordOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArraySecondaryColorOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; size: GLint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayVertexAttribOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei; offset: GLintptr); stdcall;
  glVertexArrayVertexAttribIOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glEnableVertexArrayEXT: procedure(vaobj: GLuint; _array: GLenum); stdcall;
  glDisableVertexArrayEXT: procedure(vaobj: GLuint; _array: GLenum); stdcall;
  glEnableVertexArrayAttribEXT: procedure(vaobj: GLuint; index: GLuint); stdcall;
  glDisableVertexArrayAttribEXT: procedure(vaobj: GLuint; index: GLuint); stdcall;
  glGetVertexArrayIntegervEXT: procedure(vaobj: GLuint; pname: GLenum; param: PGLint); stdcall;
  glGetVertexArrayPointervEXT: procedure(vaobj: GLuint; pname: GLenum; param:Ppointer); stdcall;
  glGetVertexArrayIntegeri_vEXT: procedure(vaobj: GLuint; index: GLuint; pname: GLenum; param: PGLint); stdcall;
  glGetVertexArrayPointeri_vEXT: procedure(vaobj: GLuint; index: GLuint; pname: GLenum; param:Ppointer); stdcall;
  glMapNamedBufferRangeEXT: function(buffer: GLuint; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): pointer; stdcall;
  glFlushMappedNamedBufferRangeEXT: procedure(buffer: GLuint; offset: GLintptr; length: GLsizeiptr); stdcall;
  glNamedBufferStorageEXT: procedure(buffer: GLuint; size: GLsizeiptr; const data: pointer; flags: GLbitfield); stdcall;
  glClearNamedBufferDataEXT: procedure(buffer: GLuint; internalformat: GLenum; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glClearNamedBufferSubDataEXT: procedure(buffer: GLuint; internalformat: GLenum; offset: GLsizeiptr; size: GLsizeiptr; format: GLenum; _type: GLenum; const data: pointer); stdcall;
  glNamedFramebufferParameteriEXT: procedure(framebuffer: GLuint; pname: GLenum; param: GLint); stdcall;
  glGetNamedFramebufferParameterivEXT: procedure(framebuffer: GLuint; pname: GLenum; params: PGLint); stdcall;
  glProgramUniform1dEXT: procedure(_program: GLuint; location: GLint; x: GLdouble); stdcall;
  glProgramUniform2dEXT: procedure(_program: GLuint; location: GLint; x: GLdouble; y: GLdouble); stdcall;
  glProgramUniform3dEXT: procedure(_program: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glProgramUniform4dEXT: procedure(_program: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glProgramUniform1dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniform2dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniform3dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniform4dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); stdcall;
  glProgramUniformMatrix2dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix3dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix4dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix2x3dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix2x4dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix3x2dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix3x4dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix4x2dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glProgramUniformMatrix4x3dvEXT: procedure(_program: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); stdcall;
  glTextureBufferRangeEXT: procedure(texture: GLuint; target: GLenum; internalformat: GLenum; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); stdcall;
  glTextureStorage1DEXT: procedure(texture: GLuint; target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei); stdcall;
  glTextureStorage2DEXT: procedure(texture: GLuint; target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glTextureStorage3DEXT: procedure(texture: GLuint; target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei); stdcall;
  glTextureStorage2DMultisampleEXT: procedure(texture: GLuint; target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glTextureStorage3DMultisampleEXT: procedure(texture: GLuint; target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean); stdcall;
  glVertexArrayBindVertexBufferEXT: procedure(vaobj: GLuint; bindingindex: GLuint; buffer: GLuint; offset: GLintptr; stride: GLsizei); stdcall;
  glVertexArrayVertexAttribFormatEXT: procedure(vaobj: GLuint; attribindex: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; relativeoffset: GLuint); stdcall;
  glVertexArrayVertexAttribIFormatEXT: procedure(vaobj: GLuint; attribindex: GLuint; size: GLint; _type: GLenum; relativeoffset: GLuint); stdcall;
  glVertexArrayVertexAttribLFormatEXT: procedure(vaobj: GLuint; attribindex: GLuint; size: GLint; _type: GLenum; relativeoffset: GLuint); stdcall;
  glVertexArrayVertexAttribBindingEXT: procedure(vaobj: GLuint; attribindex: GLuint; bindingindex: GLuint); stdcall;
  glVertexArrayVertexBindingDivisorEXT: procedure(vaobj: GLuint; bindingindex: GLuint; divisor: GLuint); stdcall;
  glVertexArrayVertexAttribLOffsetEXT: procedure(vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; _type: GLenum; stride: GLsizei; offset: GLintptr); stdcall;
  glTexturePageCommitmentEXT: procedure(texture: GLuint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; commit: GLboolean); stdcall;
  glVertexArrayVertexAttribDivisorEXT: procedure(vaobj: GLuint; index: GLuint; divisor: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_draw_buffers2}
  glColorMaskIndexedEXT: procedure(index: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_draw_instanced}
  glDrawArraysInstancedEXT: procedure(mode: GLenum; start: GLint; count: GLsizei; primcount: GLsizei); stdcall;
  glDrawElementsInstancedEXT: procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: pointer; primcount: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_draw_range_elements}
  glDrawRangeElementsEXT: procedure(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; _type: GLenum; const indices: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_external_buffer}
  glBufferStorageExternalEXT: procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr; clientBuffer: GLeglClientBufferEXT; flags: GLbitfield); stdcall;
  glNamedBufferStorageExternalEXT: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; clientBuffer: GLeglClientBufferEXT; flags: GLbitfield); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_fog_coord}
  glFogCoordfEXT: procedure(coord: GLfloat); stdcall;
  glFogCoordfvEXT: procedure(const coord: PGLfloat); stdcall;
  glFogCoorddEXT: procedure(coord: GLdouble); stdcall;
  glFogCoorddvEXT: procedure(const coord: PGLdouble); stdcall;
  glFogCoordPointerEXT: procedure(_type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_framebuffer_blit}
  glBlitFramebufferEXT: procedure(srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_framebuffer_multisample}
  glRenderbufferStorageMultisampleEXT: procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_framebuffer_object}
//  glIsRenderbufferEXT: function(renderbuffer: GLuint): GLboolean; stdcall;
//  glBindRenderbufferEXT: procedure(target: GLenum; renderbuffer: GLuint); stdcall;
//  glDeleteRenderbuffersEXT: procedure(n: GLsizei; const renderbuffers: PGLuint); stdcall;
//  glGenRenderbuffersEXT: procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
//  glRenderbufferStorageEXT: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glGetRenderbufferParameterivEXT: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
//  glIsFramebufferEXT: function(framebuffer: GLuint): GLboolean; stdcall;
//  glBindFramebufferEXT: procedure(target: GLenum; framebuffer: GLuint); stdcall;
//  glDeleteFramebuffersEXT: procedure(n: GLsizei; const framebuffers: PGLuint); stdcall;
//  glGenFramebuffersEXT: procedure(n: GLsizei; framebuffers: PGLuint); stdcall;
//  glCheckFramebufferStatusEXT: function(target: GLenum): GLenum; stdcall;
  glFramebufferTexture1DEXT: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
//  glFramebufferTexture2DEXT: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
  glFramebufferTexture3DEXT: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint); stdcall;
//  glFramebufferRenderbufferEXT: procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;
  glGetFramebufferAttachmentParameterivEXT: procedure(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGenerateMipmapEXT: procedure(target: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_geometry_shader4}
  glProgramParameteriEXT: procedure(_program: GLuint; pname: GLenum; value: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_gpu_program_parameters}
  glProgramEnvParameters4fvEXT: procedure(target: GLenum; index: GLuint; count: GLsizei; const params: PGLfloat); stdcall;
  glProgramLocalParameters4fvEXT: procedure(target: GLenum; index: GLuint; count: GLsizei; const params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_gpu_shader4}
  glGetUniformuivEXT: procedure(_program: GLuint; location: GLint; params: PGLuint); stdcall;
  glBindFragDataLocationEXT: procedure(_program: GLuint; color: GLuint; const name: PGLchar); stdcall;
  glGetFragDataLocationEXT: function(_program: GLuint; const name: PGLchar): GLint; stdcall;
  glUniform1uiEXT: procedure(location: GLint; v0: GLuint); stdcall;
  glUniform2uiEXT: procedure(location: GLint; v0: GLuint; v1: GLuint); stdcall;
  glUniform3uiEXT: procedure(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); stdcall;
  glUniform4uiEXT: procedure(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); stdcall;
  glUniform1uivEXT: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glUniform2uivEXT: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glUniform3uivEXT: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glUniform4uivEXT: procedure(location: GLint; count: GLsizei; const value: PGLuint); stdcall;
  glVertexAttribI1iEXT: procedure(index: GLuint; x: GLint); stdcall;
  glVertexAttribI2iEXT: procedure(index: GLuint; x: GLint; y: GLint); stdcall;
  glVertexAttribI3iEXT: procedure(index: GLuint; x: GLint; y: GLint; z: GLint); stdcall;
  glVertexAttribI4iEXT: procedure(index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); stdcall;
  glVertexAttribI1uiEXT: procedure(index: GLuint; x: GLuint); stdcall;
  glVertexAttribI2uiEXT: procedure(index: GLuint; x: GLuint; y: GLuint); stdcall;
  glVertexAttribI3uiEXT: procedure(index: GLuint; x: GLuint; y: GLuint; z: GLuint); stdcall;
  glVertexAttribI4uiEXT: procedure(index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); stdcall;
  glVertexAttribI1ivEXT: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI2ivEXT: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI3ivEXT: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI4ivEXT: procedure(index: GLuint; const v: PGLint); stdcall;
  glVertexAttribI1uivEXT: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI2uivEXT: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI3uivEXT: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI4uivEXT: procedure(index: GLuint; const v: PGLuint); stdcall;
  glVertexAttribI4bvEXT: procedure(index: GLuint; const v: PGLbyte); stdcall;
  glVertexAttribI4svEXT: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttribI4ubvEXT: procedure(index: GLuint; const v: PGLubyte); stdcall;
  glVertexAttribI4usvEXT: procedure(index: GLuint; const v: PGLushort); stdcall;
  glVertexAttribIPointerEXT: procedure(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glGetVertexAttribIivEXT: procedure(index: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVertexAttribIuivEXT: procedure(index: GLuint; pname: GLenum; params: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_histogram}
  glGetHistogramEXT: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: pointer); stdcall;
  glGetHistogramParameterfvEXT: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetHistogramParameterivEXT: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetMinmaxEXT: procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: pointer); stdcall;
  glGetMinmaxParameterfvEXT: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetMinmaxParameterivEXT: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glHistogramEXT: procedure(target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean); stdcall;
  glMinmaxEXT: procedure(target: GLenum; internalformat: GLenum; sink: GLboolean); stdcall;
  glResetHistogramEXT: procedure(target: GLenum); stdcall;
  glResetMinmaxEXT: procedure(target: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_index_func}
  glIndexFuncEXT: procedure(func: GLenum; ref: GLclampf); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_index_material}
  glIndexMaterialEXT: procedure(face: GLenum; mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_light_texture}
  glApplyTextureEXT: procedure(mode: GLenum); stdcall;
  glTextureLightEXT: procedure(pname: GLenum); stdcall;
  glTextureMaterialEXT: procedure(face: GLenum; mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_memory_object}
  glGetUnsignedBytevEXT: procedure(pname: GLenum; data: PGLubyte); stdcall;
  glGetUnsignedBytei_vEXT: procedure(target: GLenum; index: GLuint; data: PGLubyte); stdcall;
  glDeleteMemoryObjectsEXT: procedure(n: GLsizei; const memoryObjects: PGLuint); stdcall;
  glIsMemoryObjectEXT: function(memoryObject: GLuint): GLboolean; stdcall;
  glCreateMemoryObjectsEXT: procedure(n: GLsizei; memoryObjects: PGLuint); stdcall;
  glMemoryObjectParameterivEXT: procedure(memoryObject: GLuint; pname: GLenum; const params: PGLint); stdcall;
  glGetMemoryObjectParameterivEXT: procedure(memoryObject: GLuint; pname: GLenum; params: PGLint); stdcall;
  glTexStorageMem2DEXT: procedure(target: GLenum; levels: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; memory: GLuint; offset: GLuint64); stdcall;
  glTexStorageMem2DMultisampleEXT: procedure(target: GLenum; samples: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; fixedSampleLocations: GLboolean; memory: GLuint; offset: GLuint64); stdcall;
  glTexStorageMem3DEXT: procedure(target: GLenum; levels: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; memory: GLuint; offset: GLuint64); stdcall;
  glTexStorageMem3DMultisampleEXT: procedure(target: GLenum; samples: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; fixedSampleLocations: GLboolean; memory: GLuint; offset: GLuint64); stdcall;
  glBufferStorageMemEXT: procedure(target: GLenum; size: GLsizeiptr; memory: GLuint; offset: GLuint64); stdcall;
  glTextureStorageMem2DEXT: procedure(texture: GLuint; levels: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; memory: GLuint; offset: GLuint64); stdcall;
  glTextureStorageMem2DMultisampleEXT: procedure(texture: GLuint; samples: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; fixedSampleLocations: GLboolean; memory: GLuint; offset: GLuint64); stdcall;
  glTextureStorageMem3DEXT: procedure(texture: GLuint; levels: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; memory: GLuint; offset: GLuint64); stdcall;
  glTextureStorageMem3DMultisampleEXT: procedure(texture: GLuint; samples: GLsizei; internalFormat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; fixedSampleLocations: GLboolean; memory: GLuint; offset: GLuint64); stdcall;
  glNamedBufferStorageMemEXT: procedure(buffer: GLuint; size: GLsizeiptr; memory: GLuint; offset: GLuint64); stdcall;
  glTexStorageMem1DEXT: procedure(target: GLenum; levels: GLsizei; internalFormat: GLenum; width: GLsizei; memory: GLuint; offset: GLuint64); stdcall;
  glTextureStorageMem1DEXT: procedure(texture: GLuint; levels: GLsizei; internalFormat: GLenum; width: GLsizei; memory: GLuint; offset: GLuint64); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_memory_object_fd}
  glImportMemoryFdEXT: procedure(memory: GLuint; size: GLuint64; handleType: GLenum; fd: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_memory_object_win32}
  glImportMemoryWin32HandleEXT: procedure(memory: GLuint; size: GLuint64; handleType: GLenum; handle: pointer); stdcall;
  glImportMemoryWin32NameEXT: procedure(memory: GLuint; size: GLuint64; handleType: GLenum; const name: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_multi_draw_arrays}
  glMultiDrawArraysEXT: procedure(mode: GLenum; const first: PGLint; const count: PGLsizei; primcount: GLsizei); stdcall;
  glMultiDrawElementsEXT: procedure(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices:Ppointer; primcount: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_multisample}
  glSampleMaskEXT: procedure(value: GLclampf; invert: GLboolean); stdcall;
  glSamplePatternEXT: procedure(pattern: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_paletted_texture}
  glColorTableEXT: procedure(target: GLenum; internalFormat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; const table: pointer); stdcall;
  glGetColorTableEXT: procedure(target: GLenum; format: GLenum; _type: GLenum; data: pointer); stdcall;
  glGetColorTableParameterivEXT: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetColorTableParameterfvEXT: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_pixel_transform}
  glPixelTransformParameteriEXT: procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;
  glPixelTransformParameterfEXT: procedure(target: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glPixelTransformParameterivEXT: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glPixelTransformParameterfvEXT: procedure(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glGetPixelTransformParameterivEXT: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetPixelTransformParameterfvEXT: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_point_parameters}
  glPointParameterfEXT: procedure(pname: GLenum; param: GLfloat); stdcall;
  glPointParameterfvEXT: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_polygon_offset}
  glPolygonOffsetEXT: procedure(factor: GLfloat; bias: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_polygon_offset_clamp}
  glPolygonOffsetClampEXT: procedure(factor: GLfloat; units: GLfloat; clamp: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_provoking_vertex}
  glProvokingVertexEXT: procedure(mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_raster_multisample}
  glRasterSamplesEXT: procedure(samples: GLuint; fixedsamplelocations: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_secondary_color}
  glSecondaryColor3bEXT: procedure(red: GLbyte; green: GLbyte; blue: GLbyte); stdcall;
  glSecondaryColor3bvEXT: procedure(const v: PGLbyte); stdcall;
  glSecondaryColor3dEXT: procedure(red: GLdouble; green: GLdouble; blue: GLdouble); stdcall;
  glSecondaryColor3dvEXT: procedure(const v: PGLdouble); stdcall;
  glSecondaryColor3fEXT: procedure(red: GLfloat; green: GLfloat; blue: GLfloat); stdcall;
  glSecondaryColor3fvEXT: procedure(const v: PGLfloat); stdcall;
  glSecondaryColor3iEXT: procedure(red: GLint; green: GLint; blue: GLint); stdcall;
  glSecondaryColor3ivEXT: procedure(const v: PGLint); stdcall;
  glSecondaryColor3sEXT: procedure(red: GLshort; green: GLshort; blue: GLshort); stdcall;
  glSecondaryColor3svEXT: procedure(const v: PGLshort); stdcall;
  glSecondaryColor3ubEXT: procedure(red: GLubyte; green: GLubyte; blue: GLubyte); stdcall;
  glSecondaryColor3ubvEXT: procedure(const v: PGLubyte); stdcall;
  glSecondaryColor3uiEXT: procedure(red: GLuint; green: GLuint; blue: GLuint); stdcall;
  glSecondaryColor3uivEXT: procedure(const v: PGLuint); stdcall;
  glSecondaryColor3usEXT: procedure(red: GLushort; green: GLushort; blue: GLushort); stdcall;
  glSecondaryColor3usvEXT: procedure(const v: PGLushort); stdcall;
  glSecondaryColorPointerEXT: procedure(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_semaphore}
  glGenSemaphoresEXT: procedure(n: GLsizei; semaphores: PGLuint); stdcall;
  glDeleteSemaphoresEXT: procedure(n: GLsizei; const semaphores: PGLuint); stdcall;
  glIsSemaphoreEXT: function(semaphore: GLuint): GLboolean; stdcall;
  glSemaphoreParameterui64vEXT: procedure(semaphore: GLuint; pname: GLenum; const params: PGLuint64); stdcall;
  glGetSemaphoreParameterui64vEXT: procedure(semaphore: GLuint; pname: GLenum; params: PGLuint64); stdcall;
  glWaitSemaphoreEXT: procedure(semaphore: GLuint; numBufferBarriers: GLuint; const buffers: PGLuint; numTextureBarriers: GLuint; const textures: PGLuint; const srcLayouts: PGLenum); stdcall;
  glSignalSemaphoreEXT: procedure(semaphore: GLuint; numBufferBarriers: GLuint; const buffers: PGLuint; numTextureBarriers: GLuint; const textures: PGLuint; const dstLayouts: PGLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_semaphore_fd}
  glImportSemaphoreFdEXT: procedure(semaphore: GLuint; handleType: GLenum; fd: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_semaphore_win32}
  glImportSemaphoreWin32HandleEXT: procedure(semaphore: GLuint; handleType: GLenum; handle: pointer); stdcall;
  glImportSemaphoreWin32NameEXT: procedure(semaphore: GLuint; handleType: GLenum; const name: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_separate_shader_objects}
  glUseShaderProgramEXT: procedure(_type: GLenum; _program: GLuint); stdcall;
  glActiveProgramEXT: procedure(_program: GLuint); stdcall;
  glCreateShaderProgramEXT: function(_type: GLenum; const _string: PGLchar): GLuint; stdcall;
  {$EndIf}

  {$IfDef GL_EXT_shader_framebuffer_fetch_non_coherent}
  glFramebufferFetchBarrierEXT: procedure;  stdcall;
  {$EndIf}

  {$IfDef GL_EXT_shader_image_load_store}
  glBindImageTextureEXT: procedure(index: GLuint; texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; access: GLenum; format: GLint); stdcall;
  glMemoryBarrierEXT: procedure(barriers: GLbitfield); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_stencil_clear_tag}
  glStencilClearTagEXT: procedure(stencilTagBits: GLsizei; stencilClearTag: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_stencil_two_side}
  glActiveStencilFaceEXT: procedure(face: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_subtexture}
  glTexSubImage1DEXT: procedure(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTexSubImage2DEXT: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_texture3D}
  glTexImage3DEXT: procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTexSubImage3DEXT: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_texture_array}
  glFramebufferTextureLayerEXT: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_texture_buffer_object}
  glTexBufferEXT: procedure(target: GLenum; internalformat: GLenum; buffer: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_texture_integer}
  glTexParameterIivEXT: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glTexParameterIuivEXT: procedure(target: GLenum; pname: GLenum; const params: PGLuint); stdcall;
  glGetTexParameterIivEXT: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetTexParameterIuivEXT: procedure(target: GLenum; pname: GLenum; params: PGLuint); stdcall;
  glClearColorIiEXT: procedure(red: GLint; green: GLint; blue: GLint; alpha: GLint); stdcall;
  glClearColorIuiEXT: procedure(red: GLuint; green: GLuint; blue: GLuint; alpha: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_texture_object}
  glAreTexturesResidentEXT: function(n: GLsizei; const textures: PGLuint; residences: PGLboolean): GLboolean; stdcall;
  glBindTextureEXT: procedure(target: GLenum; texture: GLuint); stdcall;
  glDeleteTexturesEXT: procedure(n: GLsizei; const textures: PGLuint); stdcall;
  glGenTexturesEXT: procedure(n: GLsizei; textures: PGLuint); stdcall;
  glIsTextureEXT: function(texture: GLuint): GLboolean; stdcall;
  glPrioritizeTexturesEXT: procedure(n: GLsizei; const textures: PGLuint; const priorities: PGLclampf); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_texture_perturb_normal}
  glTextureNormalEXT: procedure(mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_texture_storage}
  glTexStorage1DEXT: procedure(target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei); stdcall;
  glTexStorage2DEXT: procedure(target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glTexStorage3DEXT: procedure(target: GLenum; levels: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_timer_query}
  glGetQueryObjecti64vEXT: procedure(id: GLuint; pname: GLenum; params: PGLint64); stdcall;
  glGetQueryObjectui64vEXT: procedure(id: GLuint; pname: GLenum; params: PGLuint64); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_transform_feedback}
  glBeginTransformFeedbackEXT: procedure(primitiveMode: GLenum); stdcall;
  glEndTransformFeedbackEXT: procedure; stdcall;
  glBindBufferRangeEXT: procedure(target: GLenum; index: GLuint; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); stdcall;
  glBindBufferOffsetEXT: procedure(target: GLenum; index: GLuint; buffer: GLuint; offset: GLintptr); stdcall;
  glBindBufferBaseEXT: procedure(target: GLenum; index: GLuint; buffer: GLuint); stdcall;
  glTransformFeedbackVaryingsEXT: procedure(_program: GLuint; count: GLsizei; const varyings: PPGLchar; bufferMode: GLenum); stdcall;
  glGetTransformFeedbackVaryingEXT: procedure(_program: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; _type: PGLenum; name: PGLchar); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_vertex_array}
  glArrayElementEXT: procedure(i: GLint); stdcall;
  glColorPointerEXT: procedure(size: GLint; _type: GLenum; stride: GLsizei; count: GLsizei; const _pointer: pointer); stdcall;
  glDrawArraysEXT: procedure(mode: GLenum; first: GLint; count: GLsizei); stdcall;
  glEdgeFlagPointerEXT: procedure(stride: GLsizei; count: GLsizei; const pointer: PGLboolean); stdcall;
  glGetPointervEXT: procedure(pname: GLenum; params:Ppointer); stdcall;
  glIndexPointerEXT: procedure(_type: GLenum; stride: GLsizei; count: GLsizei; const _pointer: pointer); stdcall;
  glNormalPointerEXT: procedure(_type: GLenum; stride: GLsizei; count: GLsizei; const _pointer: pointer); stdcall;
  glTexCoordPointerEXT: procedure(size: GLint; _type: GLenum; stride: GLsizei; count: GLsizei; const _pointer: pointer); stdcall;
  glVertexPointerEXT: procedure(size: GLint; _type: GLenum; stride: GLsizei; count: GLsizei; const _pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_vertex_attrib_64bit}
  glVertexAttribL1dEXT: procedure(index: GLuint; x: GLdouble); stdcall;
  glVertexAttribL2dEXT: procedure(index: GLuint; x: GLdouble; y: GLdouble); stdcall;
  glVertexAttribL3dEXT: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glVertexAttribL4dEXT: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glVertexAttribL1dvEXT: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribL2dvEXT: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribL3dvEXT: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribL4dvEXT: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttribLPointerEXT: procedure(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glGetVertexAttribLdvEXT: procedure(index: GLuint; pname: GLenum; params: PGLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_vertex_shader}
  glBeginVertexShaderEXT: procedure; stdcall;
  glEndVertexShaderEXT: procedure; stdcall;
  glBindVertexShaderEXT: procedure(id: GLuint); stdcall;
  glGenVertexShadersEXT: function(range: GLuint): GLuint; stdcall;
  glDeleteVertexShaderEXT: procedure(id: GLuint); stdcall;
  glShaderOp1EXT: procedure(op: GLenum; res: GLuint; arg1: GLuint); stdcall;
  glShaderOp2EXT: procedure(op: GLenum; res: GLuint; arg1: GLuint; arg2: GLuint); stdcall;
  glShaderOp3EXT: procedure(op: GLenum; res: GLuint; arg1: GLuint; arg2: GLuint; arg3: GLuint); stdcall;
  glSwizzleEXT: procedure(res: GLuint; _in: GLuint; outX: GLenum; outY: GLenum; outZ: GLenum; outW: GLenum); stdcall;
  glWriteMaskEXT: procedure(res: GLuint; _in: GLuint; outX: GLenum; outY: GLenum; outZ: GLenum; outW: GLenum); stdcall;
  glInsertComponentEXT: procedure(res: GLuint; src: GLuint; num: GLuint); stdcall;
  glExtractComponentEXT: procedure(res: GLuint; src: GLuint; num: GLuint); stdcall;
  glGenSymbolsEXT: function(datatype: GLenum; storagetype: GLenum; range: GLenum; components: GLuint): GLuint; stdcall;
  glSetInvariantEXT: procedure(id: GLuint; _type: GLenum; const addr: pointer); stdcall;
  glSetLocalConstantEXT: procedure(id: GLuint; _type: GLenum; const addr: pointer); stdcall;
  glVariantbvEXT: procedure(id: GLuint; const addr: PGLbyte); stdcall;
  glVariantsvEXT: procedure(id: GLuint; const addr: PGLshort); stdcall;
  glVariantivEXT: procedure(id: GLuint; const addr: PGLint); stdcall;
  glVariantfvEXT: procedure(id: GLuint; const addr: PGLfloat); stdcall;
  glVariantdvEXT: procedure(id: GLuint; const addr: PGLdouble); stdcall;
  glVariantubvEXT: procedure(id: GLuint; const addr: PGLubyte); stdcall;
  glVariantusvEXT: procedure(id: GLuint; const addr: PGLushort); stdcall;
  glVariantuivEXT: procedure(id: GLuint; const addr: PGLuint); stdcall;
  glVariantPointerEXT: procedure(id: GLuint; _type: GLenum; stride: GLuint; const addr: pointer); stdcall;
  glEnableVariantClientStateEXT: procedure(id: GLuint); stdcall;
  glDisableVariantClientStateEXT: procedure(id: GLuint); stdcall;
  glBindLightParameterEXT: function(light: GLenum; value: GLenum): GLuint; stdcall;
  glBindMaterialParameterEXT: function(face: GLenum; value: GLenum): GLuint; stdcall;
  glBindTexGenParameterEXT: function(_unit: GLenum; coord: GLenum; value: GLenum): GLuint; stdcall;
  glBindTextureUnitParameterEXT: function(_unit: GLenum; value: GLenum): GLuint; stdcall;
  glBindParameterEXT: function(value: GLenum): GLuint; stdcall;
  glIsVariantEnabledEXT: function(id: GLuint; cap: GLenum): GLboolean; stdcall;
  glGetVariantBooleanvEXT: procedure(id: GLuint; value: GLenum; data: PGLboolean); stdcall;
  glGetVariantIntegervEXT: procedure(id: GLuint; value: GLenum; data: PGLint); stdcall;
  glGetVariantFloatvEXT: procedure(id: GLuint; value: GLenum; data: PGLfloat); stdcall;
  glGetVariantPointervEXT: procedure(id: GLuint; value: GLenum; data:Ppointer); stdcall;
  glGetInvariantBooleanvEXT: procedure(id: GLuint; value: GLenum; data: PGLboolean); stdcall;
  glGetInvariantIntegervEXT: procedure(id: GLuint; value: GLenum; data: PGLint); stdcall;
  glGetInvariantFloatvEXT: procedure(id: GLuint; value: GLenum; data: PGLfloat); stdcall;
  glGetLocalConstantBooleanvEXT: procedure(id: GLuint; value: GLenum; data: PGLboolean); stdcall;
  glGetLocalConstantIntegervEXT: procedure(id: GLuint; value: GLenum; data: PGLint); stdcall;
  glGetLocalConstantFloatvEXT: procedure(id: GLuint; value: GLenum; data: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_vertex_weighting}
  glVertexWeightfEXT: procedure(weight: GLfloat); stdcall;
  glVertexWeightfvEXT: procedure(const weight: PGLfloat); stdcall;
  glVertexWeightPointerEXT: procedure(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_win32_keyed_mutex}
  glAcquireKeyedMutexWin32EXT: function(memory: GLuint; key: GLuint64; timeout: GLuint): GLboolean; stdcall;
  glReleaseKeyedMutexWin32EXT: function(memory: GLuint; key: GLuint64): GLboolean; stdcall;
  {$EndIf}

  {$IfDef GL_EXT_window_rectangles}
  glWindowRectanglesEXT: procedure(mode: GLenum; count: GLsizei; const box: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_EXT_x11_sync_object}
  glImportSyncEXT: function(external_sync_type: GLenum; external_sync: GLintptr; flags: GLbitfield): GLsync; stdcall;
  {$EndIf}

  {$IfDef GL_GREMEDY_frame_terminator}
  glFrameTerminatorGREMEDY: procedure;  stdcall;
  {$EndIf}

  {$IfDef GL_GREMEDY_string_marker}
  glStringMarkerGREMEDY: procedure(len: GLsizei; const _string: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_HP_image_transform}
  glImageTransformParameteriHP: procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;
  glImageTransformParameterfHP: procedure(target: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glImageTransformParameterivHP: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glImageTransformParameterfvHP: procedure(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glGetImageTransformParameterivHP: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetImageTransformParameterfvHP: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_IBM_multimode_draw_arrays}
  glMultiModeDrawArraysIBM: procedure(const mode: PGLenum; const first: PGLint; const count: PGLsizei; primcount: GLsizei; modestride: GLint); stdcall;
  glMultiModeDrawElementsIBM: procedure(const mode: PGLenum; const count: PGLsizei; _type: GLenum; const indices: {P}Ppointer; primcount: GLsizei; modestride: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_IBM_static_data}
  glFlushStaticDataIBM: procedure(target: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_IBM_vertex_array_lists}
  glColorPointerListIBM: procedure(size: GLint; _type: GLenum; stride: GLint; const _pointer: {P}Ppointer; ptrstride: GLint); stdcall;
  glSecondaryColorPointerListIBM: procedure(size: GLint; _type: GLenum; stride: GLint; const _pointer: {P}Ppointer; ptrstride: GLint); stdcall;
  glEdgeFlagPointerListIBM: procedure(stride: GLint; const _pointer: {P}PGLboolean; ptrstride: GLint); stdcall;
  glFogCoordPointerListIBM: procedure(_type: GLenum; stride: GLint; const _pointer: {P}Ppointer; ptrstride: GLint); stdcall;
  glIndexPointerListIBM: procedure(_type: GLenum; stride: GLint; const _pointer: {P}Ppointer; ptrstride: GLint); stdcall;
  glNormalPointerListIBM: procedure(_type: GLenum; stride: GLint; const _pointer: {P}Ppointer; ptrstride: GLint); stdcall;
  glTexCoordPointerListIBM: procedure(size: GLint; _type: GLenum; stride: GLint; const _pointer: {P}Ppointer; ptrstride: GLint); stdcall;
  glVertexPointerListIBM: procedure(size: GLint; _type: GLenum; stride: GLint; const _pointer: {P}Ppointer; ptrstride: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_INGR_blend_func_separate}
  glBlendFuncSeparateINGR: procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_INTEL_framebuffer_CMAA}
  glApplyFramebufferAttachmentCMAAINTEL: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_INTEL_map_texture}
  glSyncTextureINTEL: procedure(texture: GLuint); stdcall;
  glUnmapTexture2DINTEL: procedure(texture: GLuint; level: GLint); stdcall;
  glMapTexture2DINTEL: function(texture: GLuint; level: GLint; access: GLbitfield; stride: PGLint; layout: PGLenum): pointer;
  {$EndIf}

  {$IfDef GL_INTEL_parallel_arrays}
  glVertexPointervINTEL: procedure(size: GLint; _type: GLenum; const _pointer: {P}Ppointer); stdcall;
  glNormalPointervINTEL: procedure(_type: GLenum; const _pointer: {P}Ppointer); stdcall;
  glColorPointervINTEL: procedure(size: GLint; _type: GLenum; const _pointer: {P}Ppointer); stdcall;
  glTexCoordPointervINTEL: procedure(size: GLint; _type: GLenum; const _pointer: {P}Ppointer); stdcall;
  {$EndIf}

  {$IfDef GL_INTEL_performance_query}
  glBeginPerfQueryINTEL: procedure(queryHandle: GLuint); stdcall;
  glCreatePerfQueryINTEL: procedure(queryId: GLuint; queryHandle: PGLuint); stdcall;
  glDeletePerfQueryINTEL: procedure(queryHandle: GLuint); stdcall;
  glEndPerfQueryINTEL: procedure(queryHandle: GLuint); stdcall;
  glGetFirstPerfQueryIdINTEL: procedure(queryId: PGLuint); stdcall;
  glGetNextPerfQueryIdINTEL: procedure(queryId: GLuint; nextQueryId: PGLuint); stdcall;
  glGetPerfCounterInfoINTEL: procedure(queryId: GLuint; counterId: GLuint; counterNameLength: GLuint; counterName: PGLchar; counterDescLength: GLuint; counterDesc: PGLchar; counterOffset: PGLuint; counterDataSize: PGLuint; counterTypeEnum: PGLuint; counterDataTypeEnum: PGLuint; rawCounterMaxValue: PGLuint64); stdcall;
  glGetPerfQueryDataINTEL: procedure(queryHandle: GLuint; flags: GLuint; dataSize: GLsizei; data: pointer; bytesWritten: PGLuint); stdcall;
  glGetPerfQueryIdByNameINTEL: procedure(queryName: PGLchar; queryId: PGLuint); stdcall;
  glGetPerfQueryInfoINTEL: procedure(queryId: GLuint; queryNameLength: GLuint; queryName: PGLchar; dataSize: PGLuint; noCounters: PGLuint; noInstances: PGLuint; capsMask: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_MESA_framebuffer_flip_y}
  glFramebufferParameteriMESA: procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;
  glGetFramebufferParameterivMESA: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_MESA_resize_buffers}
  glResizeBuffersMESA: procedure;  stdcall;
  {$EndIf}

  {$IfDef GL_MESA_window_pos}
  glWindowPos2dMESA: procedure(x: GLdouble; y: GLdouble); stdcall;
  glWindowPos2dvMESA: procedure(const v: PGLdouble); stdcall;
  glWindowPos2fMESA: procedure(x: GLfloat; y: GLfloat); stdcall;
  glWindowPos2fvMESA: procedure(const v: PGLfloat); stdcall;
  glWindowPos2iMESA: procedure(x: GLint; y: GLint); stdcall;
  glWindowPos2ivMESA: procedure(const v: PGLint); stdcall;
  glWindowPos2sMESA: procedure(x: GLshort; y: GLshort); stdcall;
  glWindowPos2svMESA: procedure(const v: PGLshort); stdcall;
  glWindowPos3dMESA: procedure(x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glWindowPos3dvMESA: procedure(const v: PGLdouble); stdcall;
  glWindowPos3fMESA: procedure(x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glWindowPos3fvMESA: procedure(const v: PGLfloat); stdcall;
  glWindowPos3iMESA: procedure(x: GLint; y: GLint; z: GLint); stdcall;
  glWindowPos3ivMESA: procedure(const v: PGLint); stdcall;
  glWindowPos3sMESA: procedure(x: GLshort; y: GLshort; z: GLshort); stdcall;
  glWindowPos3svMESA: procedure(const v: PGLshort); stdcall;
  glWindowPos4dMESA: procedure(x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glWindowPos4dvMESA: procedure(const v: PGLdouble); stdcall;
  glWindowPos4fMESA: procedure(x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glWindowPos4fvMESA: procedure(const v: PGLfloat); stdcall;
  glWindowPos4iMESA: procedure(x: GLint; y: GLint; z: GLint; w: GLint); stdcall;
  glWindowPos4ivMESA: procedure(const v: PGLint); stdcall;
  glWindowPos4sMESA: procedure(x: GLshort; y: GLshort; z: GLshort; w: GLshort); stdcall;
  glWindowPos4svMESA: procedure(const v: PGLshort); stdcall;
  {$EndIf}

  {$IfDef GL_NVX_conditional_render}
  glBeginConditionalRenderNVX: procedure(id: GLuint); stdcall;
  glEndConditionalRenderNVX: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_NVX_gpu_multicast2}
  glUploadGpuMaskNVX: procedure(mask: GLbitfield); stdcall;
  glMulticastViewportArrayvNVX: procedure(gpu: GLuint; first: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glMulticastViewportPositionWScaleNVX: procedure(gpu: GLuint; index: GLuint; xcoeff: GLfloat; ycoeff: GLfloat); stdcall;
  glMulticastScissorArrayvNVX: procedure(gpu: GLuint; first: GLuint; count: GLsizei; const v: PGLint); stdcall;
  glAsyncCopyBufferSubDataNVX: function(waitSemaphoreCount: GLsizei; const waitSemaphoreArray: PGLuint; const fenceValueArray: PGLuint64; readGpu: GLuint; writeGpuMask: GLbitfield; readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr; signalSemaphoreCount: GLsizei; const signalSemaphoreArray: PGLuint; const signalValueArray: PGLuint64): GLuint; stdcall;
  glAsyncCopyImageSubDataNVX: function(waitSemaphoreCount: GLsizei; const waitSemaphoreArray: PGLuint; const waitValueArray: PGLuint64; srcGpu: GLuint; dstGpuMask: GLbitfield; srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; srcWidth: GLsizei; srcHeight: GLsizei; srcDepth: GLsizei; signalSemaphoreCount: GLsizei; const signalSemaphoreArray: PGLuint; const signalValueArray: PGLuint64): GLuint; stdcall;
  {$EndIf}

  {$IfDef GL_NVX_linked_gpu_multicast}
  glLGPUNamedBufferSubDataNVX: procedure(gpuMask: GLbitfield; buffer: GLuint; offset: GLintptr; size: GLsizeiptr; const data: pointer); stdcall;
  glLGPUCopyImageSubDataNVX: procedure(sourceGpu: GLuint; destinationGpuMask: GLbitfield; srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srxY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei); stdcall;
  glLGPUInterlockNVX: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_NVX_progress_fence}
  glCreateProgressFenceNVX: function: GLuint; stdcall;
  glSignalSemaphoreui64NVX: procedure(signalGpu: GLuint; fenceObjectCount: GLsizei; const semaphoreArray: PGLuint; const fenceValueArray: PGLuint64); stdcall;
  glWaitSemaphoreui64NVX: procedure(waitGpu: GLuint; fenceObjectCount: GLsizei; const semaphoreArray: PGLuint; const fenceValueArray: PGLuint64); stdcall;
  glClientWaitSemaphoreui64NVX: procedure(fenceObjectCount: GLsizei; const semaphoreArray: PGLuint; const fenceValueArray: PGLuint64); stdcall;
  {$EndIf}

  {$IfDef GL_NV_alpha_to_coverage_dither_control}
  glAlphaToCoverageDitherControlNV: procedure(mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_NV_bindless_multi_draw_indirect}
  glMultiDrawArraysIndirectBindlessNV: procedure(mode: GLenum; const indirect: pointer; drawCount: GLsizei; stride: GLsizei; vertexBufferCount: GLint); stdcall;
  glMultiDrawElementsIndirectBindlessNV: procedure(mode: GLenum; _type: GLenum; const indirect: pointer; drawCount: GLsizei; stride: GLsizei; vertexBufferCount: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_bindless_multi_draw_indirect_count}
  glMultiDrawArraysIndirectBindlessCountNV: procedure(mode: GLenum; const indirect: pointer; drawCount: GLsizei; maxDrawCount: GLsizei; stride: GLsizei; vertexBufferCount: GLint); stdcall;
  glMultiDrawElementsIndirectBindlessCountNV: procedure(mode: GLenum; _type: GLenum; const indirect: pointer; drawCount: GLsizei; maxDrawCount: GLsizei; stride: GLsizei; vertexBufferCount: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_bindless_texture}
  glGetTextureHandleNV: function(texture: GLuint): GLuint64; stdcall;
  glGetTextureSamplerHandleNV: function(texture: GLuint; sampler: GLuint): GLuint64; stdcall;
  glMakeTextureHandleResidentNV: procedure(handle: GLuint64); stdcall;
  glMakeTextureHandleNonResidentNV: procedure(handle: GLuint64); stdcall;
  glGetImageHandleNV: function(texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; format: GLenum): GLuint64; stdcall;
  glMakeImageHandleResidentNV: procedure(handle: GLuint64; access: GLenum); stdcall;
  glMakeImageHandleNonResidentNV: procedure(handle: GLuint64); stdcall;
  glUniformHandleui64NV: procedure(location: GLint; value: GLuint64); stdcall;
  glUniformHandleui64vNV: procedure(location: GLint; count: GLsizei; const value: PGLuint64); stdcall;
  glProgramUniformHandleui64NV: procedure(_program: GLuint; location: GLint; value: GLuint64); stdcall;
  glProgramUniformHandleui64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const values: PGLuint64); stdcall;
  glIsTextureHandleResidentNV: function(handle: GLuint64): GLboolean; stdcall;
  glIsImageHandleResidentNV: function(handle: GLuint64): GLboolean; stdcall;
  {$EndIf}

  {$IfDef GL_NV_blend_equation_advanced}
  glBlendParameteriNV: procedure(pname: GLenum; value: GLint); stdcall;
  glBlendBarrierNV: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_NV_clip_space_w_scaling}
  glViewportPositionWScaleNV: procedure(index: GLuint; xcoeff: GLfloat; ycoeff: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_NV_command_list}
  glCreateStatesNV: procedure(n: GLsizei; states: PGLuint); stdcall;
  glDeleteStatesNV: procedure(n: GLsizei; states: PGLuint); stdcall;
  glIsStateNV: function(state: GLuint): GLboolean; stdcall;
  glStateCaptureNV: procedure(state: GLuint; mode: GLenum); stdcall;
  glGetCommandHeaderNV: function(tokenID: GLenum; size: GLuint): GLuint;
  glGetStageIndexNV: function(shadertype: GLenum): GLushort; stdcall;
  glDrawCommandsNV: procedure(primitiveMode: GLenum; buffer: GLuint; const indirects: PGLintptr; const sizes: PGLsizei; count: GLuint); stdcall;
  glDrawCommandsAddressNV: procedure(primitiveMode: GLenum; const indirects: PGLuint64; const sizes: PGLsizei; count: GLuint); stdcall;
  glDrawCommandsStatesNV: procedure(buffer: GLuint; const indirects: PGLintptr; const sizes: PGLsizei; const states: PGLuint; const fbos: PGLuint; count: GLuint); stdcall;
  glDrawCommandsStatesAddressNV: procedure(const indirects: PGLuint64; const sizes: PGLsizei; const states: PGLuint; const fbos: PGLuint; count: GLuint); stdcall;
  glCreateCommandListsNV: procedure(n: GLsizei; lists: PGLuint); stdcall;
  glDeleteCommandListsNV: procedure(n: GLsizei; const lists: PGLuint); stdcall;
  glIsCommandListNV: function(list: GLuint): GLboolean; stdcall;
  glListDrawCommandsStatesClientNV: procedure(list: GLuint; segment: GLuint; const indirects: {P}Ppointer; const sizes: PGLsizei; const states: PGLuint; const fbos: PGLuint; count: GLuint); stdcall;
  glCommandListSegmentsNV: procedure(list: GLuint; segments: GLuint); stdcall;
  glCompileCommandListNV: procedure(list: GLuint); stdcall;
  glCallCommandListNV: procedure(list: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_conditional_render}
  glBeginConditionalRenderNV: procedure(id: GLuint; mode: GLenum); stdcall;
  glEndConditionalRenderNV: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_NV_conservative_raster}
  glSubpixelPrecisionBiasNV: procedure(xbits: GLuint; ybits: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_conservative_raster_dilate}
  glConservativeRasterParameterfNV: procedure(pname: GLenum; value: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_NV_conservative_raster_pre_snap_triangles}
  glConservativeRasterParameteriNV: procedure(pname: GLenum; param: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_copy_image}
  glCopyImageSubDataNV: procedure(srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_NV_depth_buffer_float}
  glDepthRangedNV: procedure(zNear: GLdouble; zFar: GLdouble); stdcall;
  glClearDepthdNV: procedure(depth: GLdouble); stdcall;
  glDepthBoundsdNV: procedure(zmin: GLdouble; zmax: GLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_NV_draw_texture}
  glDrawTextureNV: procedure(texture: GLuint; sampler: GLuint; x0: GLfloat; y0: GLfloat; x1: GLfloat; y1: GLfloat; z: GLfloat; s0: GLfloat; t0: GLfloat; s1: GLfloat; t1: GLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_NV_draw_vulkan_image}
  glDrawVkImageNV: procedure(vkImage: GLuint64; sampler: GLuint; x0: GLfloat; y0: GLfloat; x1: GLfloat; y1: GLfloat; z: GLfloat; s0: GLfloat; t0: GLfloat; s1: GLfloat; t1: GLfloat); stdcall;
  glGetVkProcAddrNV: function(const name: PGLchar): GLVULKANPROCNV;
  glWaitVkSemaphoreNV: procedure(vkSemaphore: GLuint64); stdcall;
  glSignalVkSemaphoreNV: procedure(vkSemaphore: GLuint64); stdcall;
  glSignalVkFenceNV: procedure(vkFence: GLuint64); stdcall;
  {$EndIf}

  {$IfDef GL_NV_evaluators}
  glMapControlPointsNV: procedure(target: GLenum; index: GLuint; _type: GLenum; ustride: GLsizei; vstride: GLsizei; uorder: GLint; vorder: GLint; _packed: GLboolean; const points: pointer); stdcall;
  glMapParameterivNV: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glMapParameterfvNV: procedure(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glGetMapControlPointsNV: procedure(target: GLenum; index: GLuint; _type: GLenum; ustride: GLsizei; vstride: GLsizei; _packed: GLboolean; points: pointer); stdcall;
  glGetMapParameterivNV: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetMapParameterfvNV: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetMapAttribParameterivNV: procedure(target: GLenum; index: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetMapAttribParameterfvNV: procedure(target: GLenum; index: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glEvalMapsNV: procedure(target: GLenum; mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_NV_explicit_multisample}
  glGetMultisamplefvNV: procedure(pname: GLenum; index: GLuint; val: PGLfloat); stdcall;
  glSampleMaskIndexedNV: procedure(index: GLuint; mask: GLbitfield); stdcall;
  glTexRenderbufferNV: procedure(target: GLenum; renderbuffer: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_fence}
  glDeleteFencesNV: procedure(n: GLsizei; const fences: PGLuint); stdcall;
  glGenFencesNV: procedure(n: GLsizei; fences: PGLuint); stdcall;
  glIsFenceNV: function(fence: GLuint): GLboolean;
  glTestFenceNV: function(fence: GLuint): GLboolean;
  glGetFenceivNV: procedure(fence: GLuint; pname: GLenum; params: PGLint); stdcall;
  glFinishFenceNV: procedure(fence: GLuint); stdcall;
  glSetFenceNV: procedure(fence: GLuint; condition: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_NV_fragment_coverage_to_color}
  glFragmentCoverageColorNV: procedure(color: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_fragment_program}
  glProgramNamedParameter4fNV: procedure(id: GLuint; len: GLsizei; const name: PGLubyte; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glProgramNamedParameter4fvNV: procedure(id: GLuint; len: GLsizei; const name: PGLubyte; const v: PGLfloat); stdcall;
  glProgramNamedParameter4dNV: procedure(id: GLuint; len: GLsizei; const name: PGLubyte; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glProgramNamedParameter4dvNV: procedure(id: GLuint; len: GLsizei; const name: PGLubyte; const v: PGLdouble); stdcall;
  glGetProgramNamedParameterfvNV: procedure(id: GLuint; len: GLsizei; const name: PGLubyte; params: PGLfloat); stdcall;
  glGetProgramNamedParameterdvNV: procedure(id: GLuint; len: GLsizei; const name: PGLubyte; params: PGLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_NV_framebuffer_mixed_samples}
  glCoverageModulationTableNV: procedure(n: GLsizei; const v: PGLfloat); stdcall;
  glGetCoverageModulationTableNV: procedure(bufSize: GLsizei; v: PGLfloat); stdcall;
  glCoverageModulationNV: procedure(components: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_NV_framebuffer_multisample_coverage}
  glRenderbufferStorageMultisampleCoverageNV: procedure(target: GLenum; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_NV_geometry_program4}
  glProgramVertexLimitNV: procedure(target: GLenum; limit: GLint); stdcall;
  glFramebufferTextureEXT: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); stdcall;
  glFramebufferTextureFaceEXT: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_NV_gpu_multicast}
  glRenderGpuMaskNV: procedure(mask: GLbitfield); stdcall;
  glMulticastBufferSubDataNV: procedure(gpuMask: GLbitfield; buffer: GLuint; offset: GLintptr; size: GLsizeiptr; data: pointer); stdcall;
  glMulticastCopyBufferSubDataNV: procedure(readGpu: GLuint; writeGpuMask: GLbitfield; readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr); stdcall;
  glMulticastCopyImageSubDataNV: procedure(srcGpu: GLuint; dstGpuMask: GLbitfield; srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; srcWidth: GLsizei; srcHeight: GLsizei; srcDepth: GLsizei); stdcall;
  glMulticastBlitFramebufferNV: procedure(srcGpu: GLuint; dstGpu: GLuint; srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); stdcall;
  glMulticastFramebufferSampleLocationsfvNV: procedure(gpu: GLuint; framebuffer: GLuint; start: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glMulticastBarrierNV: procedure; stdcall;
  glMulticastWaitSyncNV: procedure(signalGpu: GLuint; waitGpuMask: GLbitfield); stdcall;
  glMulticastGetQueryObjectivNV: procedure(gpu: GLuint; id: GLuint; pname: GLenum; params: PGLint); stdcall;
  glMulticastGetQueryObjectuivNV: procedure(gpu: GLuint; id: GLuint; pname: GLenum; params: PGLuint); stdcall;
  glMulticastGetQueryObjecti64vNV: procedure(gpu: GLuint; id: GLuint; pname: GLenum; params: PGLint64); stdcall;
  glMulticastGetQueryObjectui64vNV: procedure(gpu: GLuint; id: GLuint; pname: GLenum; params: PGLuint64); stdcall;
  {$EndIf}

  {$IfDef GL_NV_gpu_program4}
  glProgramLocalParameterI4iNV: procedure(target: GLenum; index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); stdcall;
  glProgramLocalParameterI4ivNV: procedure(target: GLenum; index: GLuint; const params: PGLint); stdcall;
  glProgramLocalParametersI4ivNV: procedure(target: GLenum; index: GLuint; count: GLsizei; const params: PGLint); stdcall;
  glProgramLocalParameterI4uiNV: procedure(target: GLenum; index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); stdcall;
  glProgramLocalParameterI4uivNV: procedure(target: GLenum; index: GLuint; const params: PGLuint); stdcall;
  glProgramLocalParametersI4uivNV: procedure(target: GLenum; index: GLuint; count: GLsizei; const params: PGLuint); stdcall;
  glProgramEnvParameterI4iNV: procedure(target: GLenum; index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); stdcall;
  glProgramEnvParameterI4ivNV: procedure(target: GLenum; index: GLuint; const params: PGLint); stdcall;
  glProgramEnvParametersI4ivNV: procedure(target: GLenum; index: GLuint; count: GLsizei; const params: PGLint); stdcall;
  glProgramEnvParameterI4uiNV: procedure(target: GLenum; index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); stdcall;
  glProgramEnvParameterI4uivNV: procedure(target: GLenum; index: GLuint; const params: PGLuint); stdcall;
  glProgramEnvParametersI4uivNV: procedure(target: GLenum; index: GLuint; count: GLsizei; const params: PGLuint); stdcall;
  glGetProgramLocalParameterIivNV: procedure(target: GLenum; index: GLuint; params: PGLint); stdcall;
  glGetProgramLocalParameterIuivNV: procedure(target: GLenum; index: GLuint; params: PGLuint); stdcall;
  glGetProgramEnvParameterIivNV: procedure(target: GLenum; index: GLuint; params: PGLint); stdcall;
  glGetProgramEnvParameterIuivNV: procedure(target: GLenum; index: GLuint; params: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_gpu_program5}
  glProgramSubroutineParametersuivNV: procedure(target: GLenum; count: GLsizei; const params: PGLuint); stdcall;
  glGetProgramSubroutineParameteruivNV: procedure(target: GLenum; index: GLuint; param: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_half_float}
  glVertex2hNV: procedure(x: GLhalfNV; y: GLhalfNV); stdcall;
  glVertex2hvNV: procedure(const v: PGLhalfNV); stdcall;
  glVertex3hNV: procedure(x: GLhalfNV; y: GLhalfNV; z: GLhalfNV); stdcall;
  glVertex3hvNV: procedure(const v: PGLhalfNV); stdcall;
  glVertex4hNV: procedure(x: GLhalfNV; y: GLhalfNV; z: GLhalfNV; w: GLhalfNV); stdcall;
  glVertex4hvNV: procedure(const v: PGLhalfNV); stdcall;
  glNormal3hNV: procedure(nx: GLhalfNV; ny: GLhalfNV; nz: GLhalfNV); stdcall;
  glNormal3hvNV: procedure(const v: PGLhalfNV); stdcall;
  glColor3hNV: procedure(red: GLhalfNV; green: GLhalfNV; blue: GLhalfNV); stdcall;
  glColor3hvNV: procedure(const v: PGLhalfNV); stdcall;
  glColor4hNV: procedure(red: GLhalfNV; green: GLhalfNV; blue: GLhalfNV; alpha: GLhalfNV); stdcall;
  glColor4hvNV: procedure(const v: PGLhalfNV); stdcall;
  glTexCoord1hNV: procedure(s: GLhalfNV); stdcall;
  glTexCoord1hvNV: procedure(const v: PGLhalfNV); stdcall;
  glTexCoord2hNV: procedure(s: GLhalfNV; t: GLhalfNV); stdcall;
  glTexCoord2hvNV: procedure(const v: PGLhalfNV); stdcall;
  glTexCoord3hNV: procedure(s: GLhalfNV; t: GLhalfNV; r: GLhalfNV); stdcall;
  glTexCoord3hvNV: procedure(const v: PGLhalfNV); stdcall;
  glTexCoord4hNV: procedure(s: GLhalfNV; t: GLhalfNV; r: GLhalfNV; q: GLhalfNV); stdcall;
  glTexCoord4hvNV: procedure(const v: PGLhalfNV); stdcall;
  glMultiTexCoord1hNV: procedure(target: GLenum; s: GLhalfNV); stdcall;
  glMultiTexCoord1hvNV: procedure(target: GLenum; const v: PGLhalfNV); stdcall;
  glMultiTexCoord2hNV: procedure(target: GLenum; s: GLhalfNV; t: GLhalfNV); stdcall;
  glMultiTexCoord2hvNV: procedure(target: GLenum; const v: PGLhalfNV); stdcall;
  glMultiTexCoord3hNV: procedure(target: GLenum; s: GLhalfNV; t: GLhalfNV; r: GLhalfNV); stdcall;
  glMultiTexCoord3hvNV: procedure(target: GLenum; const v: PGLhalfNV); stdcall;
  glMultiTexCoord4hNV: procedure(target: GLenum; s: GLhalfNV; t: GLhalfNV; r: GLhalfNV; q: GLhalfNV); stdcall;
  glMultiTexCoord4hvNV: procedure(target: GLenum; const v: PGLhalfNV); stdcall;
  glFogCoordhNV: procedure(fog: GLhalfNV); stdcall;
  glFogCoordhvNV: procedure(const fog: PGLhalfNV); stdcall;
  glSecondaryColor3hNV: procedure(red: GLhalfNV; green: GLhalfNV; blue: GLhalfNV); stdcall;
  glSecondaryColor3hvNV: procedure(const v: PGLhalfNV); stdcall;
  glVertexWeighthNV: procedure(weight: GLhalfNV); stdcall;
  glVertexWeighthvNV: procedure(const weight: PGLhalfNV); stdcall;
  glVertexAttrib1hNV: procedure(index: GLuint; x: GLhalfNV); stdcall;
  glVertexAttrib1hvNV: procedure(index: GLuint; const v: PGLhalfNV); stdcall;
  glVertexAttrib2hNV: procedure(index: GLuint; x: GLhalfNV; y: GLhalfNV); stdcall;
  glVertexAttrib2hvNV: procedure(index: GLuint; const v: PGLhalfNV); stdcall;
  glVertexAttrib3hNV: procedure(index: GLuint; x: GLhalfNV; y: GLhalfNV; z: GLhalfNV); stdcall;
  glVertexAttrib3hvNV: procedure(index: GLuint; const v: PGLhalfNV); stdcall;
  glVertexAttrib4hNV: procedure(index: GLuint; x: GLhalfNV; y: GLhalfNV; z: GLhalfNV; w: GLhalfNV); stdcall;
  glVertexAttrib4hvNV: procedure(index: GLuint; const v: PGLhalfNV); stdcall;
  glVertexAttribs1hvNV: procedure(index: GLuint; n: GLsizei; const v: PGLhalfNV); stdcall;
  glVertexAttribs2hvNV: procedure(index: GLuint; n: GLsizei; const v: PGLhalfNV); stdcall;
  glVertexAttribs3hvNV: procedure(index: GLuint; n: GLsizei; const v: PGLhalfNV); stdcall;
  glVertexAttribs4hvNV: procedure(index: GLuint; n: GLsizei; const v: PGLhalfNV); stdcall;
  {$EndIf}

  {$IfDef GL_NV_internalformat_sample_query}
  glGetInternalformatSampleivNV: procedure(target: GLenum; internalformat: GLenum; samples: GLsizei; pname: GLenum; count: GLsizei; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_memory_attachment}
  glGetMemoryObjectDetachedResourcesuivNV: procedure(memory: GLuint; pname: GLenum; first: GLint; count: GLsizei; params: PGLuint); stdcall;
  glResetMemoryObjectParameterNV: procedure(memory: GLuint; pname: GLenum); stdcall;
  glTexAttachMemoryNV: procedure(target: GLenum; memory: GLuint; offset: GLuint64); stdcall;
  glBufferAttachMemoryNV: procedure(target: GLenum; memory: GLuint; offset: GLuint64); stdcall;
  glTextureAttachMemoryNV: procedure(texture: GLuint; memory: GLuint; offset: GLuint64); stdcall;
  glNamedBufferAttachMemoryNV: procedure(buffer: GLuint; memory: GLuint; offset: GLuint64); stdcall;
  {$EndIf}

  {$IfDef GL_NV_memory_object_sparse}
  glBufferPageCommitmentMemNV: procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr; memory: GLuint; memOffset: GLuint64; commit: GLboolean); stdcall;
  glTexPageCommitmentMemNV: procedure(target: GLenum; layer: GLint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; memory: GLuint; offset: GLuint64; commit: GLboolean); stdcall;
  glNamedBufferPageCommitmentMemNV: procedure(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; memory: GLuint; memOffset: GLuint64; commit: GLboolean); stdcall;
  glTexturePageCommitmentMemNV: procedure(texture: GLuint; layer: GLint; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; memory: GLuint; offset: GLuint64; commit: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_NV_mesh_shader}
  glDrawMeshTasksNV: procedure(first: GLuint; count: GLuint); stdcall;
  glDrawMeshTasksIndirectNV: procedure(indirect: GLintptr); stdcall;
  glMultiDrawMeshTasksIndirectNV: procedure(indirect: GLintptr; drawcount: GLsizei; stride: GLsizei); stdcall;
  glMultiDrawMeshTasksIndirectCountNV: procedure(indirect: GLintptr; drawcount: GLintptr; maxdrawcount: GLsizei; stride: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_NV_occlusion_query}
  glGenOcclusionQueriesNV: procedure(n: GLsizei; ids: PGLuint); stdcall;
  glDeleteOcclusionQueriesNV: procedure(n: GLsizei; const ids: PGLuint); stdcall;
  glIsOcclusionQueryNV: function(id: GLuint): GLboolean; stdcall;
  glBeginOcclusionQueryNV: procedure(id: GLuint); stdcall;
  glEndOcclusionQueryNV: procedure; stdcall;
  glGetOcclusionQueryivNV: procedure(id: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetOcclusionQueryuivNV: procedure(id: GLuint; pname: GLenum; params: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_parameter_buffer_object}
  glProgramBufferParametersfvNV: procedure(target: GLenum; bindingIndex: GLuint; wordIndex: GLuint; count: GLsizei; const params: PGLfloat); stdcall;
  glProgramBufferParametersIivNV: procedure(target: GLenum; bindingIndex: GLuint; wordIndex: GLuint; count: GLsizei; const params: PGLint); stdcall;
  glProgramBufferParametersIuivNV: procedure(target: GLenum; bindingIndex: GLuint; wordIndex: GLuint; count: GLsizei; const params: PGLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_path_rendering}
  glGenPathsNV: function(range: GLsizei): GLuint; stdcall;
  glDeletePathsNV: procedure(path: GLuint; range: GLsizei); stdcall;
  glIsPathNV: function(path: GLuint): GLboolean; stdcall;
  glPathCommandsNV: procedure(path: GLuint; numCommands: GLsizei; const commands: PGLubyte; numCoords: GLsizei; coordType: GLenum; const coords: pointer); stdcall;
  glPathCoordsNV: procedure(path: GLuint; numCoords: GLsizei; coordType: GLenum; const coords: pointer); stdcall;
  glPathSubCommandsNV: procedure(path: GLuint; commandStart: GLsizei; commandsToDelete: GLsizei; numCommands: GLsizei; const commands: PGLubyte; numCoords: GLsizei; coordType: GLenum; const coords: pointer); stdcall;
  glPathSubCoordsNV: procedure(path: GLuint; coordStart: GLsizei; numCoords: GLsizei; coordType: GLenum; const coords: pointer); stdcall;
  glPathStringNV: procedure(path: GLuint; format: GLenum; length: GLsizei; const pathString: pointer); stdcall;
  glPathGlyphsNV: procedure(firstPathName: GLuint; fontTarget: GLenum; const fontName: pointer; fontStyle: GLbitfield; numGlyphs: GLsizei; _type: GLenum; const charcodes: pointer; handleMissingGlyphs: GLenum; pathParameterTemplate: GLuint; emScale: GLfloat); stdcall;
  glPathGlyphRangeNV: procedure(firstPathName: GLuint; fontTarget: GLenum; const fontName: pointer; fontStyle: GLbitfield; firstGlyph: GLuint; numGlyphs: GLsizei; handleMissingGlyphs: GLenum; pathParameterTemplate: GLuint; emScale: GLfloat); stdcall;
  glWeightPathsNV: procedure(resultPath: GLuint; numPaths: GLsizei; const paths: PGLuint; const weights: PGLfloat); stdcall;
  glCopyPathNV: procedure(resultPath: GLuint; srcPath: GLuint); stdcall;
  glInterpolatePathsNV: procedure(resultPath: GLuint; pathA: GLuint; pathB: GLuint; weight: GLfloat); stdcall;
  glTransformPathNV: procedure(resultPath: GLuint; srcPath: GLuint; transformType: GLenum; const transformValues: PGLfloat); stdcall;
  glPathParameterivNV: procedure(path: GLuint; pname: GLenum; const value: PGLint); stdcall;
  glPathParameteriNV: procedure(path: GLuint; pname: GLenum; value: GLint); stdcall;
  glPathParameterfvNV: procedure(path: GLuint; pname: GLenum; const value: PGLfloat); stdcall;
  glPathParameterfNV: procedure(path: GLuint; pname: GLenum; value: GLfloat); stdcall;
  glPathDashArrayNV: procedure(path: GLuint; dashCount: GLsizei; const dashArray: PGLfloat); stdcall;
  glPathStencilFuncNV: procedure(func: GLenum; ref: GLint; mask: GLuint); stdcall;
  glPathStencilDepthOffsetNV: procedure(factor: GLfloat; units: GLfloat); stdcall;
  glStencilFillPathNV: procedure(path: GLuint; fillMode: GLenum; mask: GLuint); stdcall;
  glStencilStrokePathNV: procedure(path: GLuint; reference: GLint; mask: GLuint); stdcall;
  glStencilFillPathInstancedNV: procedure(numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; fillMode: GLenum; mask: GLuint; transformType: GLenum; const transformValues: PGLfloat); stdcall;
  glStencilStrokePathInstancedNV: procedure(numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; reference: GLint; mask: GLuint; transformType: GLenum; const transformValues: PGLfloat); stdcall;
  glPathCoverDepthFuncNV: procedure(func: GLenum); stdcall;
  glCoverFillPathNV: procedure(path: GLuint; coverMode: GLenum); stdcall;
  glCoverStrokePathNV: procedure(path: GLuint; coverMode: GLenum); stdcall;
  glCoverFillPathInstancedNV: procedure(numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; coverMode: GLenum; transformType: GLenum; const transformValues: PGLfloat); stdcall;
  glCoverStrokePathInstancedNV: procedure(numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; coverMode: GLenum; transformType: GLenum; const transformValues: PGLfloat); stdcall;
  glGetPathParameterivNV: procedure(path: GLuint; pname: GLenum; value: PGLint); stdcall;
  glGetPathParameterfvNV: procedure(path: GLuint; pname: GLenum; value: PGLfloat); stdcall;
  glGetPathCommandsNV: procedure(path: GLuint; commands: PGLubyte); stdcall;
  glGetPathCoordsNV: procedure(path: GLuint; coords: PGLfloat); stdcall;
  glGetPathDashArrayNV: procedure(path: GLuint; dashArray: PGLfloat); stdcall;
  glGetPathMetricsNV: procedure(metricQueryMask: GLbitfield; numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; stride: GLsizei; metrics: PGLfloat); stdcall;
  glGetPathMetricRangeNV: procedure(metricQueryMask: GLbitfield; firstPathName: GLuint; numPaths: GLsizei; stride: GLsizei; metrics: PGLfloat); stdcall;
  glGetPathSpacingNV: procedure(pathListMode: GLenum; numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; advanceScale: GLfloat; kerningScale: GLfloat; transformType: GLenum; returnedSpacing: PGLfloat); stdcall;
  glIsPointInFillPathNV: function(path: GLuint; mask: GLuint; x: GLfloat; y: GLfloat): GLboolean; stdcall;
  glIsPointInStrokePathNV: function(path: GLuint; x: GLfloat; y: GLfloat): GLboolean; stdcall;
  glGetPathLengthNV: function(path: GLuint; startSegment: GLsizei; numSegments: GLsizei): GLfloat; stdcall;
  glPointAlongPathNV: function(path: GLuint; startSegment: GLsizei; numSegments: GLsizei; distance: GLfloat; x: PGLfloat; y: PGLfloat; tangentX: PGLfloat; tangentY: PGLfloat): GLboolean; stdcall;
  glMatrixLoad3x2fNV: procedure(matrixMode: GLenum; const m: PGLfloat); stdcall;
  glMatrixLoad3x3fNV: procedure(matrixMode: GLenum; const m: PGLfloat); stdcall;
  glMatrixLoadTranspose3x3fNV: procedure(matrixMode: GLenum; const m: PGLfloat); stdcall;
  glMatrixMult3x2fNV: procedure(matrixMode: GLenum; const m: PGLfloat); stdcall;
  glMatrixMult3x3fNV: procedure(matrixMode: GLenum; const m: PGLfloat); stdcall;
  glMatrixMultTranspose3x3fNV: procedure(matrixMode: GLenum; const m: PGLfloat); stdcall;
  glStencilThenCoverFillPathNV: procedure(path: GLuint; fillMode: GLenum; mask: GLuint; coverMode: GLenum); stdcall;
  glStencilThenCoverStrokePathNV: procedure(path: GLuint; reference: GLint; mask: GLuint; coverMode: GLenum); stdcall;
  glStencilThenCoverFillPathInstancedNV: procedure(numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; fillMode: GLenum; mask: GLuint; coverMode: GLenum; transformType: GLenum; const transformValues: PGLfloat); stdcall;
  glStencilThenCoverStrokePathInstancedNV: procedure(numPaths: GLsizei; pathNameType: GLenum; const paths: pointer; pathBase: GLuint; reference: GLint; mask: GLuint; coverMode: GLenum; transformType: GLenum; const transformValues: PGLfloat); stdcall;
  glPathGlyphIndexRangeNV: function(fontTarget: GLenum; const fontName: pointer; fontStyle: GLbitfield; pathParameterTemplate: GLuint; emScale: GLfloat; baseAndCount: PGLuint): GLenum; stdcall;
  glPathGlyphIndexArrayNV: function(firstPathName: GLuint; fontTarget: GLenum; const fontName: pointer; fontStyle: GLbitfield; firstGlyphIndex: GLuint; numGlyphs: GLsizei; pathParameterTemplate: GLuint; emScale: GLfloat): GLenum; stdcall;
  glPathMemoryGlyphIndexArrayNV: function(firstPathName: GLuint; fontTarget: GLenum; fontSize: GLsizeiptr; const fontData: pointer; faceIndex: GLsizei; firstGlyphIndex: GLuint; numGlyphs: GLsizei; pathParameterTemplate: GLuint; emScale: GLfloat): GLenum; stdcall;
  glProgramPathFragmentInputGenNV: procedure(_program: GLuint; location: GLint; genMode: GLenum; components: GLint; const coeffs: PGLfloat); stdcall;
  glGetProgramResourcefvNV: procedure(_program: GLuint; programInterface: GLenum; index: GLuint; propCount: GLsizei; const props: PGLenum; count: GLsizei; length: PGLsizei; params: PGLfloat); stdcall;
  {$IfNDef USE_GLCORE}
  glPathColorGenNV: procedure(color: GLenum; genMode: GLenum; colorFormat: GLenum; const coeffs: PGLfloat); stdcall;
  glPathTexGenNV: procedure(texCoordSet: GLenum; genMode: GLenum; components: GLint; const coeffs: PGLfloat); stdcall;
  glPathFogGenNV: procedure(genMode: GLenum); stdcall;
  glGetPathColorGenivNV: procedure(color: GLenum; pname: GLenum; value: PGLint); stdcall;
  glGetPathColorGenfvNV: procedure(color: GLenum; pname: GLenum; value: PGLfloat); stdcall;
  glGetPathTexGenivNV: procedure(texCoordSet: GLenum; pname: GLenum; value: PGLint); stdcall;
  glGetPathTexGenfvNV: procedure(texCoordSet: GLenum; pname: GLenum; value: PGLfloat); stdcall;
  {$EndIf}
  {$EndIf}

  {$IfDef GL_NV_pixel_data_range}
  glPixelDataRangeNV: procedure(target: GLenum; length: GLsizei; pointer: pointer); stdcall;
  glFlushPixelDataRangeNV: procedure(target: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_NV_point_sprite}
  glPointParameteriNV: procedure(pname: GLenum; param: GLint); stdcall;
  glPointParameterivNV: procedure(pname: GLenum; const params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_present_video}
  glPresentFrameKeyedNV: procedure(video_slot: GLuint; minPresentTime: GLuint64EXT; beginPresentTimeId: GLuint; presentDurationId: GLuint; _type: GLenum; target0: GLenum; fill0: GLuint; key0: GLuint; target1: GLenum; fill1: GLuint; key1: GLuint); stdcall;
  glPresentFrameDualFillNV: procedure(video_slot: GLuint; minPresentTime: GLuint64EXT; beginPresentTimeId: GLuint; presentDurationId: GLuint; _type: GLenum; target0: GLenum; fill0: GLuint; target1: GLenum; fill1: GLuint; target2: GLenum; fill2: GLuint; target3: GLenum; fill3: GLuint); stdcall;
  glGetVideoivNV: procedure(video_slot: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVideouivNV: procedure(video_slot: GLuint; pname: GLenum; params: PGLuint); stdcall;
  glGetVideoi64vNV: procedure(video_slot: GLuint; pname: GLenum; params: PGLint64EXT); stdcall;
  glGetVideoui64vNV: procedure(video_slot: GLuint; pname: GLenum; params: PGLuint64EXT); stdcall;
  {$EndIf}

  {$IfDef GL_NV_primitive_restart}
  glPrimitiveRestartNV: procedure; stdcall;
  glPrimitiveRestartIndexNV: procedure(index: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_query_resource}
  glQueryResourceNV: function(queryType: GLenum; tagId: GLint; count: GLuint; buffer: PGLint): GLint; stdcall;
  {$EndIf}

  {$IfDef GL_NV_query_resource_tag}
  glGenQueryResourceTagNV: procedure(n: GLsizei; tagIds: PGLint); stdcall;
  glDeleteQueryResourceTagNV: procedure(n: GLsizei; const tagIds: PGLint); stdcall;
  glQueryResourceTagNV: procedure(tagId: GLint; const tagString: PGLchar); stdcall;
  {$EndIf}

  {$IfDef GL_NV_register_combiners}
  glCombinerParameterfvNV: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  glCombinerParameterfNV: procedure(pname: GLenum; param: GLfloat); stdcall;
  glCombinerParameterivNV: procedure(pname: GLenum; const params: PGLint); stdcall;
  glCombinerParameteriNV: procedure(pname: GLenum; param: GLint); stdcall;
  glCombinerInputNV: procedure(stage: GLenum; portion: GLenum; variable: GLenum; input: GLenum; mapping: GLenum; componentUsage: GLenum); stdcall;
  glCombinerOutputNV: procedure(stage: GLenum; portion: GLenum; abOutput: GLenum; cdOutput: GLenum; sumOutput: GLenum; scale: GLenum; bias: GLenum; abDotProduct: GLboolean; cdDotProduct: GLboolean; muxSum: GLboolean); stdcall;
  glFinalCombinerInputNV: procedure(variable: GLenum; input: GLenum; mapping: GLenum; componentUsage: GLenum); stdcall;
  glGetCombinerInputParameterfvNV: procedure(stage: GLenum; portion: GLenum; variable: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetCombinerInputParameterivNV: procedure(stage: GLenum; portion: GLenum; variable: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetCombinerOutputParameterfvNV: procedure(stage: GLenum; portion: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetCombinerOutputParameterivNV: procedure(stage: GLenum; portion: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetFinalCombinerInputParameterfvNV: procedure(variable: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetFinalCombinerInputParameterivNV: procedure(variable: GLenum; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_register_combiners2}
  glCombinerStageParameterfvNV: procedure(stage: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glGetCombinerStageParameterfvNV: procedure(stage: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_NV_sample_locations}
  glFramebufferSampleLocationsfvNV: procedure(target: GLenum; start: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glNamedFramebufferSampleLocationsfvNV: procedure(framebuffer: GLuint; start: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glResolveDepthValuesNV: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_NV_scissor_exclusive}
  glScissorExclusiveNV: procedure(x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
  glScissorExclusiveArrayvNV: procedure(first: GLuint; count: GLsizei; const v: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_shader_buffer_load}
  glMakeBufferResidentNV: procedure(target: GLenum; access: GLenum); stdcall;
  glMakeBufferNonResidentNV: procedure(target: GLenum); stdcall;
  glIsBufferResidentNV: function(target: GLenum): GLboolean; stdcall;
  glMakeNamedBufferResidentNV: procedure(buffer: GLuint; access: GLenum); stdcall;
  glMakeNamedBufferNonResidentNV: procedure(buffer: GLuint); stdcall;
  glIsNamedBufferResidentNV: function(buffer: GLuint): GLboolean; stdcall;
  glGetBufferParameterui64vNV: procedure(target: GLenum; pname: GLenum; params: PGLuint64EXT); stdcall;
  glGetNamedBufferParameterui64vNV: procedure(buffer: GLuint; pname: GLenum; params: PGLuint64EXT); stdcall;
  glGetIntegerui64vNV: procedure(value: GLenum; result: PGLuint64EXT); stdcall;
  glUniformui64NV: procedure(location: GLint; value: GLuint64EXT); stdcall;
  glUniformui64vNV: procedure(location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  glProgramUniformui64NV: procedure(_program: GLuint; location: GLint; value: GLuint64EXT); stdcall;
  glProgramUniformui64vNV: procedure(_program: GLuint; location: GLint; count: GLsizei; const value: PGLuint64EXT); stdcall;
  {$EndIf}

  {$IfDef GL_NV_shading_rate_image}
  glBindShadingRateImageNV: procedure(texture: GLuint); stdcall;
  glGetShadingRateImagePaletteNV: procedure(viewport: GLuint; entry: GLuint; rate: PGLenum); stdcall;
  glGetShadingRateSampleLocationivNV: procedure(rate: GLenum; samples: GLuint; index: GLuint; location: PGLint); stdcall;
  glShadingRateImageBarrierNV: procedure(synchronize: GLboolean); stdcall;
  glShadingRateImagePaletteNV: procedure(viewport: GLuint; first: GLuint; count: GLsizei; const rates: PGLenum); stdcall;
  glShadingRateSampleOrderNV: procedure(order: GLenum); stdcall;
  glShadingRateSampleOrderCustomNV: procedure(rate: GLenum; samples: GLuint; const locations: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_texture_barrier}
  glTextureBarrierNV: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_NV_texture_multisample}
  glTexImage2DMultisampleCoverageNV: procedure(target: GLenum; coverageSamples: GLsizei; colorSamples: GLsizei; internalFormat: GLint; width: GLsizei; height: GLsizei; fixedSampleLocations: GLboolean); stdcall;
  glTexImage3DMultisampleCoverageNV: procedure(target: GLenum; coverageSamples: GLsizei; colorSamples: GLsizei; internalFormat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedSampleLocations: GLboolean); stdcall;
  glTextureImage2DMultisampleNV: procedure(texture: GLuint; target: GLenum; samples: GLsizei; internalFormat: GLint; width: GLsizei; height: GLsizei; fixedSampleLocations: GLboolean); stdcall;
  glTextureImage3DMultisampleNV: procedure(texture: GLuint; target: GLenum; samples: GLsizei; internalFormat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedSampleLocations: GLboolean); stdcall;
  glTextureImage2DMultisampleCoverageNV: procedure(texture: GLuint; target: GLenum; coverageSamples: GLsizei; colorSamples: GLsizei; internalFormat: GLint; width: GLsizei; height: GLsizei; fixedSampleLocations: GLboolean); stdcall;
  glTextureImage3DMultisampleCoverageNV: procedure(texture: GLuint; target: GLenum; coverageSamples: GLsizei; colorSamples: GLsizei; internalFormat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedSampleLocations: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_NV_timeline_semaphore}
  glCreateSemaphoresNV: procedure(n: GLsizei; semaphores: PGLuint); stdcall;
  glSemaphoreParameterivNV: procedure(semaphore: GLuint; pname: GLenum; const params: PGLint); stdcall;
  glGetSemaphoreParameterivNV: procedure(semaphore: GLuint; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_transform_feedback}
  glBeginTransformFeedbackNV: procedure(primitiveMode: GLenum); stdcall;
  glEndTransformFeedbackNV: procedure; stdcall;
  glTransformFeedbackAttribsNV: procedure(count: GLsizei; const attribs: PGLint; bufferMode: GLenum); stdcall;
  glBindBufferRangeNV: procedure(target: GLenum; index: GLuint; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); stdcall;
  glBindBufferOffsetNV: procedure(target: GLenum; index: GLuint; buffer: GLuint; offset: GLintptr); stdcall;
  glBindBufferBaseNV: procedure(target: GLenum; index: GLuint; buffer: GLuint); stdcall;
  glTransformFeedbackVaryingsNV: procedure(_program: GLuint; count: GLsizei; const locations: PGLint; bufferMode: GLenum); stdcall;
  glActiveVaryingNV: procedure(_program: GLuint; const name: PGLchar); stdcall;
  glGetVaryingLocationNV: function(_program: GLuint; const name: PGLchar): GLint; stdcall;
  glGetActiveVaryingNV: procedure(_program: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; _type: PGLenum; name: PGLchar); stdcall;
  glGetTransformFeedbackVaryingNV: procedure(_program: GLuint; index: GLuint; location: PGLint); stdcall;
  glTransformFeedbackStreamAttribsNV: procedure(count: GLsizei; const attribs: PGLint; nbuffers: GLsizei; const bufstreams: PGLint; bufferMode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_NV_transform_feedback2}
  glBindTransformFeedbackNV: procedure(target: GLenum; id: GLuint); stdcall;
  glDeleteTransformFeedbacksNV: procedure(n: GLsizei; const ids: PGLuint); stdcall;
  glGenTransformFeedbacksNV: procedure(n: GLsizei; ids: PGLuint); stdcall;
  glIsTransformFeedbackNV: function(id: GLuint): GLboolean; stdcall;
  glPauseTransformFeedbackNV: procedure; stdcall;
  glResumeTransformFeedbackNV: procedure; stdcall;
  glDrawTransformFeedbackNV: procedure(mode: GLenum; id: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_NV_vdpau_interop}
  glVDPAUInitNV: procedure(vdpDevice: pointer; const getProcAddress: pointer); stdcall;
  glVDPAUFiniNV: procedure; stdcall;
  glVDPAURegisterVideoSurfaceNV: function(const vdpSurface: pointer; target: GLenum; numTextureNames: GLsizei; const textureNames: PGLuint): GLvdpauSurfaceNV; stdcall;
  glVDPAURegisterOutputSurfaceNV: function(const vdpSurface: pointer; target: GLenum; numTextureNames: GLsizei; const textureNames: PGLuint): GLvdpauSurfaceNV; stdcall;
  glVDPAUIsSurfaceNV: function(surface: GLvdpauSurfaceNV): GLboolean; stdcall;
  glVDPAUUnregisterSurfaceNV: procedure(surface: GLvdpauSurfaceNV); stdcall;
  glVDPAUGetSurfaceivNV: procedure(surface: GLvdpauSurfaceNV; pname: GLenum; count: GLsizei; length: PGLsizei; values: PGLint); stdcall;
  glVDPAUSurfaceAccessNV: procedure(surface: GLvdpauSurfaceNV; access: GLenum); stdcall;
  glVDPAUMapSurfacesNV: procedure(numSurfaces: GLsizei; const surfaces: PGLvdpauSurfaceNV); stdcall;
  glVDPAUUnmapSurfacesNV: procedure(numSurface: GLsizei; const surfaces: PGLvdpauSurfaceNV); stdcall;
  {$EndIf}

  {$IfDef GL_NV_vdpau_interop2}
  glVDPAURegisterVideoSurfaceWithPictureStructureNV: function(const vdpSurface: pointer; target: GLenum; numTextureNames: GLsizei; const textureNames: PGLuint; isFrameStructure: GLboolean): GLvdpauSurfaceNV; stdcall;
  {$EndIf}

  {$IfDef GL_NV_vertex_array_range}
  glFlushVertexArrayRangeNV: procedure; stdcall;
  glVertexArrayRangeNV: procedure(length: GLsizei; const _pointer: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_NV_vertex_attrib_integer_64bit}
  glVertexAttribL1i64NV: procedure(index: GLuint; x: GLint64EXT); stdcall;
  glVertexAttribL2i64NV: procedure(index: GLuint; x: GLint64EXT; y: GLint64EXT); stdcall;
  glVertexAttribL3i64NV: procedure(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT); stdcall;
  glVertexAttribL4i64NV: procedure(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT); stdcall;
  glVertexAttribL1i64vNV: procedure(index: GLuint; const v: PGLint64EXT); stdcall;
  glVertexAttribL2i64vNV: procedure(index: GLuint; const v: PGLint64EXT); stdcall;
  glVertexAttribL3i64vNV: procedure(index: GLuint; const v: PGLint64EXT); stdcall;
  glVertexAttribL4i64vNV: procedure(index: GLuint; const v: PGLint64EXT); stdcall;
  glVertexAttribL1ui64NV: procedure(index: GLuint; x: GLuint64EXT); stdcall;
  glVertexAttribL2ui64NV: procedure(index: GLuint; x: GLuint64EXT; y: GLuint64EXT); stdcall;
  glVertexAttribL3ui64NV: procedure(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT); stdcall;
  glVertexAttribL4ui64NV: procedure(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT); stdcall;
  glVertexAttribL1ui64vNV: procedure(index: GLuint; const v: PGLuint64EXT); stdcall;
  glVertexAttribL2ui64vNV: procedure(index: GLuint; const v: PGLuint64EXT); stdcall;
  glVertexAttribL3ui64vNV: procedure(index: GLuint; const v: PGLuint64EXT); stdcall;
  glVertexAttribL4ui64vNV: procedure(index: GLuint; const v: PGLuint64EXT); stdcall;
  glGetVertexAttribLi64vNV: procedure(index: GLuint; pname: GLenum; params: PGLint64EXT); stdcall;
  glGetVertexAttribLui64vNV: procedure(index: GLuint; pname: GLenum; params: PGLuint64EXT); stdcall;
  glVertexAttribLFormatNV: procedure(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_NV_vertex_buffer_unified_memory}
  glBufferAddressRangeNV: procedure(pname: GLenum; index: GLuint; address: GLuint64EXT; length: GLsizeiptr); stdcall;
  glVertexFormatNV: procedure(size: GLint; _type: GLenum; stride: GLsizei); stdcall;
  glNormalFormatNV: procedure(_type: GLenum; stride: GLsizei); stdcall;
  glColorFormatNV: procedure(size: GLint; _type: GLenum; stride: GLsizei); stdcall;
  glIndexFormatNV: procedure(_type: GLenum; stride: GLsizei); stdcall;
  glTexCoordFormatNV: procedure(size: GLint; _type: GLenum; stride: GLsizei); stdcall;
  glEdgeFlagFormatNV: procedure(stride: GLsizei); stdcall;
  glSecondaryColorFormatNV: procedure(size: GLint; _type: GLenum; stride: GLsizei); stdcall;
  glFogCoordFormatNV: procedure(_type: GLenum; stride: GLsizei); stdcall;
  glVertexAttribFormatNV: procedure(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei); stdcall;
  glVertexAttribIFormatNV: procedure(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei); stdcall;
  glGetIntegerui64i_vNV: procedure(value: GLenum; index: GLuint; result: PGLuint64EXT); stdcall;
  {$EndIf}

  {$IfDef GL_NV_vertex_program}
  glAreProgramsResidentNV: function(n: GLsizei; const programs: PGLuint; residences: PGLboolean): GLboolean; stdcall;
  glBindProgramNV: procedure(target: GLenum; id: GLuint); stdcall;
  glDeleteProgramsNV: procedure(n: GLsizei; const programs: PGLuint); stdcall;
  glExecuteProgramNV: procedure(target: GLenum; id: GLuint; const params: PGLfloat); stdcall;
  glGenProgramsNV: procedure(n: GLsizei; programs: PGLuint); stdcall;
  glGetProgramParameterdvNV: procedure(target: GLenum; index: GLuint; pname: GLenum; params: PGLdouble); stdcall;
  glGetProgramParameterfvNV: procedure(target: GLenum; index: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetProgramivNV: procedure(id: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetProgramStringNV: procedure(id: GLuint; pname: GLenum; _program: PGLubyte); stdcall;
  glGetTrackMatrixivNV: procedure(target: GLenum; address: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVertexAttribdvNV: procedure(index: GLuint; pname: GLenum; params: PGLdouble); stdcall;
  glGetVertexAttribfvNV: procedure(index: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetVertexAttribivNV: procedure(index: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVertexAttribPointervNV: procedure(index: GLuint; pname: GLenum; pointer:Ppointer); stdcall;
  glIsProgramNV: function(id: GLuint): GLboolean; stdcall;
  glLoadProgramNV: procedure(target: GLenum; id: GLuint; len: GLsizei; const _program: PGLubyte); stdcall;
  glProgramParameter4dNV: procedure(target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glProgramParameter4dvNV: procedure(target: GLenum; index: GLuint; const v: PGLdouble); stdcall;
  glProgramParameter4fNV: procedure(target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glProgramParameter4fvNV: procedure(target: GLenum; index: GLuint; const v: PGLfloat); stdcall;
  glProgramParameters4dvNV: procedure(target: GLenum; index: GLuint; count: GLsizei; const v: PGLdouble); stdcall;
  glProgramParameters4fvNV: procedure(target: GLenum; index: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glRequestResidentProgramsNV: procedure(n: GLsizei; const programs: PGLuint); stdcall;
  glTrackMatrixNV: procedure(target: GLenum; address: GLuint; matrix: GLenum; transform: GLenum); stdcall;
  glVertexAttribPointerNV: procedure(index: GLuint; fsize: GLint; _type: GLenum; stride: GLsizei; const _pointer: pointer); stdcall;
  glVertexAttrib1dNV: procedure(index: GLuint; x: GLdouble); stdcall;
  glVertexAttrib1dvNV: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib1fNV: procedure(index: GLuint; x: GLfloat); stdcall;
  glVertexAttrib1fvNV: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib1sNV: procedure(index: GLuint; x: GLshort); stdcall;
  glVertexAttrib1svNV: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib2dNV: procedure(index: GLuint; x: GLdouble; y: GLdouble); stdcall;
  glVertexAttrib2dvNV: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib2fNV: procedure(index: GLuint; x: GLfloat; y: GLfloat); stdcall;
  glVertexAttrib2fvNV: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib2sNV: procedure(index: GLuint; x: GLshort; y: GLshort); stdcall;
  glVertexAttrib2svNV: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib3dNV: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); stdcall;
  glVertexAttrib3dvNV: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib3fNV: procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glVertexAttrib3fvNV: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib3sNV: procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort); stdcall;
  glVertexAttrib3svNV: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4dNV: procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); stdcall;
  glVertexAttrib4dvNV: procedure(index: GLuint; const v: PGLdouble); stdcall;
  glVertexAttrib4fNV: procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glVertexAttrib4fvNV: procedure(index: GLuint; const v: PGLfloat); stdcall;
  glVertexAttrib4sNV: procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort); stdcall;
  glVertexAttrib4svNV: procedure(index: GLuint; const v: PGLshort); stdcall;
  glVertexAttrib4ubNV: procedure(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte); stdcall;
  glVertexAttrib4ubvNV: procedure(index: GLuint; const v: PGLubyte); stdcall;
  glVertexAttribs1dvNV: procedure(index: GLuint; count: GLsizei; const v: PGLdouble); stdcall;
  glVertexAttribs1fvNV: procedure(index: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glVertexAttribs1svNV: procedure(index: GLuint; count: GLsizei; const v: PGLshort); stdcall;
  glVertexAttribs2dvNV: procedure(index: GLuint; count: GLsizei; const v: PGLdouble); stdcall;
  glVertexAttribs2fvNV: procedure(index: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glVertexAttribs2svNV: procedure(index: GLuint; count: GLsizei; const v: PGLshort); stdcall;
  glVertexAttribs3dvNV: procedure(index: GLuint; count: GLsizei; const v: PGLdouble); stdcall;
  glVertexAttribs3fvNV: procedure(index: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glVertexAttribs3svNV: procedure(index: GLuint; count: GLsizei; const v: PGLshort); stdcall;
  glVertexAttribs4dvNV: procedure(index: GLuint; count: GLsizei; const v: PGLdouble); stdcall;
  glVertexAttribs4fvNV: procedure(index: GLuint; count: GLsizei; const v: PGLfloat); stdcall;
  glVertexAttribs4svNV: procedure(index: GLuint; count: GLsizei; const v: PGLshort); stdcall;
  glVertexAttribs4ubvNV: procedure(index: GLuint; count: GLsizei; const v: PGLubyte); stdcall;
  {$EndIf}

  {$IfDef GL_NV_video_capture}
  glBeginVideoCaptureNV: procedure(video_capture_slot: GLuint); stdcall;
  glBindVideoCaptureStreamBufferNV: procedure(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; offset: GLintptrARB); stdcall;
  glBindVideoCaptureStreamTextureNV: procedure(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; target: GLenum; texture: GLuint); stdcall;
  glEndVideoCaptureNV: procedure(video_capture_slot: GLuint); stdcall;
  glGetVideoCaptureivNV: procedure(video_capture_slot: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVideoCaptureStreamivNV: procedure(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLint); stdcall;
  glGetVideoCaptureStreamfvNV: procedure(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetVideoCaptureStreamdvNV: procedure(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLdouble); stdcall;
  glVideoCaptureNV: function(video_capture_slot: GLuint; sequence_num: PGLuint; capture_time: PGLuint64EXT): GLenum; stdcall;
  glVideoCaptureStreamParameterivNV: procedure(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; const params: PGLint); stdcall;
  glVideoCaptureStreamParameterfvNV: procedure(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; const params: PGLfloat); stdcall;
  glVideoCaptureStreamParameterdvNV: procedure(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; const params: PGLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_NV_viewport_swizzle}
  glViewportSwizzleNV: procedure(index: GLuint; swizzlex: GLenum; swizzley: GLenum; swizzlez: GLenum; swizzlew: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_OVR_multiview}
  glFramebufferTextureMultiviewOVR: procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; baseViewIndex: GLint; numViews: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_PGI_misc_hints}
  glHintPGI: procedure(target: GLenum; mode: GLint); stdcall;       // = glHint
  {$EndIf}

  {$IfDef GL_SGIS_detail_texture}
  glDetailTexFuncSGIS: procedure(target: GLenum; n: GLsizei; const points: PGLfloat); stdcall;
  glGetDetailTexFuncSGIS: procedure(target: GLenum; points: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_fog_function}
  glFogFuncSGIS: procedure(n: GLsizei; const points: PGLfloat); stdcall;
  glGetFogFuncSGIS: procedure(points: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_multisample}
  glSampleMaskSGIS: procedure(value: GLclampf; invert: GLboolean); stdcall;
  glSamplePatternSGIS: procedure(pattern: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_pixel_texture}
  glPixelTexGenParameteriSGIS: procedure(pname: GLenum; param: GLint); stdcall;
  glPixelTexGenParameterivSGIS: procedure(pname: GLenum; const params: PGLint); stdcall;
  glPixelTexGenParameterfSGIS: procedure(pname: GLenum; param: GLfloat); stdcall;
  glPixelTexGenParameterfvSGIS: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  glGetPixelTexGenParameterivSGIS: procedure(pname: GLenum; params: PGLint); stdcall;
  glGetPixelTexGenParameterfvSGIS: procedure(pname: GLenum; params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_point_parameters}
  glPointParameterfSGIS: procedure(pname: GLenum; param: GLfloat); stdcall;
  glPointParameterfvSGIS: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_sharpen_texture}
  glSharpenTexFuncSGIS: procedure(target: GLenum; n: GLsizei; const points: PGLfloat); stdcall;
  glGetSharpenTexFuncSGIS: procedure(target: GLenum; points: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_texture4D}
  glTexImage4DSGIS: procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; size4d: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  glTexSubImage4DSGIS: procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; woffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; size4d: GLsizei; format: GLenum; _type: GLenum; const pixels: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_texture_color_mask}
  glTextureColorMaskSGIS: procedure(red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean); stdcall;
  {$EndIf}

  {$IfDef GL_SGIS_texture_filter4}
  glGetTexFilterFuncSGIS: procedure(target: GLenum; filter: GLenum; weights: PGLfloat); stdcall;
  glTexFilterFuncSGIS: procedure(target: GLenum; filter: GLenum; n: GLsizei; const weights: PGLfloat); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_async}
  glAsyncMarkerSGIX: procedure(marker: GLuint); stdcall;
  glFinishAsyncSGIX: function(markerp: PGLuint): GLint; stdcall;
  glPollAsyncSGIX: function(markerp: PGLuint): GLint; stdcall;
  glGenAsyncMarkersSGIX: function(range: GLsizei): GLuint; stdcall;
  glDeleteAsyncMarkersSGIX: procedure(marker: GLuint; range: GLsizei); stdcall;
  glIsAsyncMarkerSGIX: function(marker: GLuint): GLboolean; stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_flush_raster}
  glFlushRasterSGIX: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_fragment_lighting}
  glFragmentColorMaterialSGIX: procedure(face: GLenum; mode: GLenum); stdcall;
  glFragmentLightfSGIX: procedure(light: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glFragmentLightfvSGIX: procedure(light: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glFragmentLightiSGIX: procedure(light: GLenum; pname: GLenum; param: GLint); stdcall;
  glFragmentLightivSGIX: procedure(light: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glFragmentLightModelfSGIX: procedure(pname: GLenum; param: GLfloat); stdcall;
  glFragmentLightModelfvSGIX: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  glFragmentLightModeliSGIX: procedure(pname: GLenum; param: GLint); stdcall;
  glFragmentLightModelivSGIX: procedure(pname: GLenum; const params: PGLint); stdcall;
  glFragmentMaterialfSGIX: procedure(face: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glFragmentMaterialfvSGIX: procedure(face: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glFragmentMaterialiSGIX: procedure(face: GLenum; pname: GLenum; param: GLint); stdcall;
  glFragmentMaterialivSGIX: procedure(face: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glGetFragmentLightfvSGIX: procedure(light: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetFragmentLightivSGIX: procedure(light: GLenum; pname: GLenum; params: PGLint); stdcall;
  glGetFragmentMaterialfvSGIX: procedure(face: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetFragmentMaterialivSGIX: procedure(face: GLenum; pname: GLenum; params: PGLint); stdcall;
  glLightEnviSGIX: procedure(pname: GLenum; param: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_framezoom}
  glFrameZoomSGIX: procedure(factor: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_igloo_interface}
  glIglooInterfaceSGIX: procedure(pname: GLenum; const params: pointer); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_instruments}
  glGetInstrumentsSGIX: function: GLint; stdcall;
  glInstrumentsBufferSGIX: procedure(size: GLsizei; buffer: PGLint); stdcall;
  glPollInstrumentsSGIX: function(marker_p: PGLint): GLint; stdcall;
  glReadInstrumentsSGIX: procedure(marker: GLint); stdcall;
  glStartInstrumentsSGIX: procedure; stdcall;
  glStopInstrumentsSGIX: procedure(marker: GLint); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_list_priority}
  glGetListParameterfvSGIX: procedure(list: GLuint; pname: GLenum; params: PGLfloat); stdcall;
  glGetListParameterivSGIX: procedure(list: GLuint; pname: GLenum; params: PGLint); stdcall;
  glListParameterfSGIX: procedure(list: GLuint; pname: GLenum; param: GLfloat); stdcall;
  glListParameterfvSGIX: procedure(list: GLuint; pname: GLenum; const params: PGLfloat); stdcall;
  glListParameteriSGIX: procedure(list: GLuint; pname: GLenum; param: GLint); stdcall;
  glListParameterivSGIX: procedure(list: GLuint; pname: GLenum; const params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_pixel_texture}
  glPixelTexGenSGIX: procedure(mode: GLenum); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_polynomial_ffd}
  glDeformationMap3dSGIX: procedure(target: GLenum; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; w1: GLdouble; w2: GLdouble; wstride: GLint; worder: GLint; const points: PGLdouble); stdcall;
  glDeformationMap3fSGIX: procedure(target: GLenum; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; w1: GLfloat; w2: GLfloat; wstride: GLint; worder: GLint; const points: PGLfloat); stdcall;
  glDeformSGIX: procedure(mask: GLbitfield); stdcall;
  glLoadIdentityDeformationMapSGIX: procedure(mask: GLbitfield); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_reference_plane}
  glReferencePlaneSGIX: procedure(const equation: PGLdouble); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_sprite}
  glSpriteParameterfSGIX: procedure(pname: GLenum; param: GLfloat); stdcall;
  glSpriteParameterfvSGIX: procedure(pname: GLenum; const params: PGLfloat); stdcall;
  glSpriteParameteriSGIX: procedure(pname: GLenum; param: GLint); stdcall;
  glSpriteParameterivSGIX: procedure(pname: GLenum; const params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_SGIX_tag_sample_buffer}
  glTagSampleBufferSGIX: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_SGI_color_table}
  glColorTableSGI: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; table: pointer); stdcall;
  glColorTableParameterfvSGI: procedure(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;
  glColorTableParameterivSGI: procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;
  glCopyColorTableSGI: procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei); stdcall;
  glGetColorTableSGI: procedure(target: GLenum; format: GLenum; _type: GLenum; table: pointer); stdcall;
  glGetColorTableParameterfvSGI: procedure(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;
  glGetColorTableParameterivSGI: procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
  {$EndIf}

  {$IfDef GL_SUNX_constant_data}
  glFinishTextureSUNX: procedure; stdcall;
  {$EndIf}

  {$IfDef GL_SUN_global_alpha}
  glGlobalAlphaFactorbSUN: procedure(factor: GLbyte); stdcall;
  glGlobalAlphaFactorsSUN: procedure(factor: GLshort); stdcall;
  glGlobalAlphaFactoriSUN: procedure(factor: GLint); stdcall;
  glGlobalAlphaFactorfSUN: procedure(factor: GLfloat); stdcall;
  glGlobalAlphaFactordSUN: procedure(factor: GLdouble); stdcall;
  glGlobalAlphaFactorubSUN: procedure(factor: GLubyte); stdcall;
  glGlobalAlphaFactorusSUN: procedure(factor: GLushort); stdcall;
  glGlobalAlphaFactoruiSUN: procedure(factor: GLuint); stdcall;
  {$EndIf}

  {$IfDef GL_SUN_mesh_array}
  glDrawMeshArraysSUN: procedure(mode: GLenum; first: GLint; count: GLsizei; width: GLsizei); stdcall;
  {$EndIf}

  {$IfDef GL_SUN_triangle_list}
  glReplacementCodeuiSUN: procedure(code: GLuint); stdcall;
  glReplacementCodeusSUN: procedure(code: GLushort); stdcall;
  glReplacementCodeubSUN: procedure(code: GLubyte); stdcall;
  glReplacementCodeuivSUN: procedure(const code: PGLuint); stdcall;
  glReplacementCodeusvSUN: procedure(const code: PGLushort); stdcall;
  glReplacementCodeubvSUN: procedure(const code: PGLubyte); stdcall;
  glReplacementCodePointerSUN: procedure(_type: GLenum; stride: GLsizei; const _pointer: {P}Ppointer); stdcall;
  {$EndIf}

  {$IfDef GL_SUN_vertex}
  glColor4ubVertex2fSUN: procedure(r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat); stdcall;
  glColor4ubVertex2fvSUN: procedure(const c: PGLubyte; const v: PGLfloat); stdcall;
  glColor4ubVertex3fSUN: procedure(r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glColor4ubVertex3fvSUN: procedure(const c: PGLubyte; const v: PGLfloat); stdcall;
  glColor3fVertex3fSUN: procedure(r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glColor3fVertex3fvSUN: procedure(const c: PGLfloat; const v: PGLfloat); stdcall;
  glNormal3fVertex3fSUN: procedure(nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glNormal3fVertex3fvSUN: procedure(const n: PGLfloat; const v: PGLfloat); stdcall;
  glColor4fNormal3fVertex3fSUN: procedure(r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glColor4fNormal3fVertex3fvSUN: procedure(const c: PGLfloat; const n: PGLfloat; const v: PGLfloat); stdcall;
  glTexCoord2fVertex3fSUN: procedure(s: GLfloat; t: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glTexCoord2fVertex3fvSUN: procedure(const tc: PGLfloat; const v: PGLfloat); stdcall;
  glTexCoord4fVertex4fSUN: procedure(s: GLfloat; t: GLfloat; p: GLfloat; q: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glTexCoord4fVertex4fvSUN: procedure(const tc: PGLfloat; const v: PGLfloat); stdcall;
  glTexCoord2fColor4ubVertex3fSUN: procedure(s: GLfloat; t: GLfloat; r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glTexCoord2fColor4ubVertex3fvSUN: procedure(const tc: PGLfloat; const c: PGLubyte; const v: PGLfloat); stdcall;
  glTexCoord2fColor3fVertex3fSUN: procedure(s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glTexCoord2fColor3fVertex3fvSUN: procedure(const tc: PGLfloat; const c: PGLfloat; const v: PGLfloat); stdcall;
  glTexCoord2fNormal3fVertex3fSUN: procedure(s: GLfloat; t: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glTexCoord2fNormal3fVertex3fvSUN: procedure(const tc: PGLfloat; const n: PGLfloat; const v: PGLfloat); stdcall;
  glTexCoord2fColor4fNormal3fVertex3fSUN: procedure(s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glTexCoord2fColor4fNormal3fVertex3fvSUN: procedure(const tc: PGLfloat; const c: PGLfloat; const n: PGLfloat; const v: PGLfloat); stdcall;
  glTexCoord4fColor4fNormal3fVertex4fSUN: procedure(s: GLfloat; t: GLfloat; p: GLfloat; q: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); stdcall;
  glTexCoord4fColor4fNormal3fVertex4fvSUN: procedure(const tc: PGLfloat; const c: PGLfloat; const n: PGLfloat; const v: PGLfloat); stdcall;
  glReplacementCodeuiVertex3fSUN: procedure(rc: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiVertex3fvSUN: procedure(const rc: PGLuint; const v: PGLfloat); stdcall;
  glReplacementCodeuiColor4ubVertex3fSUN: procedure(rc: GLuint; r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiColor4ubVertex3fvSUN: procedure(const rc: PGLuint; const c: PGLubyte; const v: PGLfloat); stdcall;
  glReplacementCodeuiColor3fVertex3fSUN: procedure(rc: GLuint; r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiColor3fVertex3fvSUN: procedure(const rc: PGLuint; const c: PGLfloat; const v: PGLfloat); stdcall;
  glReplacementCodeuiNormal3fVertex3fSUN: procedure(rc: GLuint; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiNormal3fVertex3fvSUN: procedure(const rc: PGLuint; const n: PGLfloat; const v: PGLfloat); stdcall;
  glReplacementCodeuiColor4fNormal3fVertex3fSUN: procedure(rc: GLuint; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiColor4fNormal3fVertex3fvSUN: procedure(const rc: PGLuint; const c: PGLfloat; const n: PGLfloat; const v: PGLfloat); stdcall;
  glReplacementCodeuiTexCoord2fVertex3fSUN: procedure(rc: GLuint; s: GLfloat; t: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiTexCoord2fVertex3fvSUN: procedure(const rc: PGLuint; const tc: PGLfloat; const v: PGLfloat); stdcall;
  glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN: procedure(rc: GLuint; s: GLfloat; t: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN: procedure(const rc: PGLuint; const tc: PGLfloat; const n: PGLfloat; const v: PGLfloat); stdcall;
  glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN: procedure(rc: GLuint; s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat); stdcall;
  glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN: procedure(const rc: PGLuint; const tc: PGLfloat; const c: PGLfloat; const n: PGLfloat; const v: PGLfloat); stdcall;
  {$EndIf}

var
  gl_Library: Pointer;

{$If defined(USE_GLEXT) or defined(USE_GLCORE)}
// Rus: проверка всех расширений.
// Eng:
procedure AllCheckGLExtension;
{$IfEnd}
// Rus: проверка версии OpenGL. Вернёт действующее значение или значение,
//      максимально возможное. Если в файле конфигурации (GLdefine.cfg) задано
//      использовать версию OpenGL 2.1 (USE_GL_21), а ваша видеокарта может
//      работать с OpenGL версии 4.4, то вы будете работать с версией OpengL не
//      выше 2.1.    !!! Обратите на это нвимание!!!
// Eng:
procedure CheckGLVersion;
// Rus: загрузка динамических функций.
// Eng:
function LoadOpenGL: Boolean;

implementation

uses
  zgl_opengl,
  zgl_opengl_all,
  zgl_glu;

(*{$IFDEF LINUX}

function dlopen(Name: PAnsiChar; Flags: LongInt): Pointer; cdecl; external 'dl';
function dlclose(Lib: Pointer): LongInt; cdecl; external 'dl';

function dlsym(Lib: Pointer; Name: PAnsiChar): Pointer; cdecl; external 'dl';
{$ENDIF}

function glLoadLib(Name: PChar): Pointer;
begin
  {$IfDef WINDOWS}
  Result := Pointer(LoadLibrary(Name));
  {$EndIf}
  {$IfDef LINUX}
  Result := dlopen(Name, $001);
  {$EndIf}
end;

function glFreeLib(Lib: Pointer): Boolean;
begin
  {$IfDef WINDOWS}
  Result := FreeLibrary();
  {$EndIf}
  {$IfDef LINUX}
  Result := dlclose(Lib) = 0;
  {$EndIf}
end; *)

(* function gl_GetProcAddr(const procName: PAnsiChar): Pointer;  // в ZenGL это не нужно
begin
  {$IfDef WINDOWS}
  if Assigned(wglGetProcAddress) then
    Result := wglGetProcAddress(procName);
  if Result = nil then
    Result := GetProcAddress(HMODULE(gl_Library), procName);
  {$EndIf}
  {$IfDef LINUX}
  if Assigned(glXGetProcAddress) then
    Result := glXGetProcAddress(procName);
  if Result = nil then
    if Assigned(glXGetProcAddressARB) then
      Result := glXGetProcAddressARB(procName);
  if Result = nil then
    Result := dlsym(gl_Library, procName);
  {$EndIf}
end; *)

{$If defined(USE_GLCORE) or defined(USE_GLEXT)}
procedure AllCheckGLExtension;
begin
  GL_ARB_ES2_compatibility := gl_IsSupported('GL_ARB_ES2_compatibility', oglExtensions);
  GL_ARB_ES3_1_compatibility := gl_IsSupported('GL_ARB_ES3_1_compatibility', oglExtensions);
  GL_ARB_ES3_2_compatibility := gl_IsSupported('GL_ARB_ES3_2_compatibility', oglExtensions);
  GL_ARB_ES3_compatibility := gl_IsSupported('GL_ARB_ES3_compatibility', oglExtensions);
  GL_ARB_arrays_of_arrays := gl_IsSupported('GL_ARB_arrays_of_arrays', oglExtensions);
  GL_ARB_base_instance := gl_IsSupported('GL_ARB_base_instance', oglExtensions);
  GL_ARB_bindless_texture := gl_IsSupported('GL_ARB_bindless_texture', oglExtensions);
  GL_ARB_blend_func_extended := gl_IsSupported('GL_ARB_blend_func_extended', oglExtensions);
  GL_ARB_buffer_storage := gl_IsSupported('GL_ARB_buffer_storage', oglExtensions);
  GL_ARB_cl_event := gl_IsSupported('GL_ARB_cl_event', oglExtensions);
  GL_ARB_clear_buffer_object := gl_IsSupported('GL_ARB_clear_buffer_object', oglExtensions);
  GL_ARB_clear_texture := gl_IsSupported('GL_ARB_clear_texture', oglExtensions);
  GL_ARB_clip_control := gl_IsSupported('GL_ARB_clip_control', oglExtensions);
  {$IFDEF GL_VERSION_3_0}
  GL_ARB_compatibility := gl_IsSupported('GL_ARB_compatibility', oglExtensions);
  {$ENDIF}
  {$IFDEF USE_GLEXT}
  GL_ARB_color_buffer_float := gl_IsSupported('GL_ARB_color_buffer_float', oglExtensions);
  {$EndIf}
  GL_ARB_compressed_texture_pixel_storage := gl_IsSupported('GL_ARB_compressed_texture_pixel_storage', oglExtensions);
  GL_ARB_compute_shader := gl_IsSupported('GL_ARB_compute_shader', oglExtensions);
  GL_ARB_compute_variable_group_size := gl_IsSupported('GL_ARB_compute_variable_group_size', oglExtensions);
  GL_ARB_conditional_render_inverted := gl_IsSupported('GL_ARB_conditional_render_inverted', oglExtensions);
  GL_ARB_conservative_depth := gl_IsSupported('GL_ARB_conservative_depth', oglExtensions);
  GL_ARB_copy_buffer := gl_IsSupported('GL_ARB_copy_buffer', oglExtensions);
  GL_ARB_copy_image := gl_IsSupported('GL_ARB_copy_image', oglExtensions);
  GL_ARB_cull_distance := gl_IsSupported('GL_ARB_cull_distance', oglExtensions);
  GL_ARB_debug_output := gl_IsSupported('GL_ARB_debug_output', oglExtensions);
  GL_ARB_depth_buffer_float := gl_IsSupported('GL_ARB_depth_buffer_float', oglExtensions);
  GL_ARB_depth_clamp := gl_IsSupported('GL_ARB_depth_clamp', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_depth_texture := gl_IsSupported('GL_ARB_depth_texture', oglExtensions);
  {$EndIf}
  GL_ARB_derivative_control := gl_IsSupported('GL_ARB_derivative_control', oglExtensions);
  GL_ARB_direct_state_access := gl_IsSupported('GL_ARB_direct_state_access', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_draw_buffers := gl_IsSupported('GL_ARB_draw_buffers', oglExtensions);
  {$EndIf}
  GL_ARB_draw_buffers_blend := gl_IsSupported('GL_ARB_draw_buffers_blend', oglExtensions);
  GL_ARB_draw_elements_base_vertex := gl_IsSupported('GL_ARB_draw_elements_base_vertex', oglExtensions);
  GL_ARB_draw_indirect := gl_IsSupported('GL_ARB_draw_indirect', oglExtensions);
  GL_ARB_draw_instanced := gl_IsSupported('GL_ARB_draw_instanced', oglExtensions);
  GL_ARB_enhanced_layouts := gl_IsSupported('GL_ARB_enhanced_layouts', oglExtensions);
  GL_ARB_explicit_attrib_location := gl_IsSupported('GL_ARB_explicit_attrib_location', oglExtensions);
  GL_ARB_explicit_uniform_location := gl_IsSupported('GL_ARB_explicit_uniform_location', oglExtensions);
  GL_ARB_fragment_coord_conventions := gl_IsSupported('GL_ARB_fragment_coord_conventions', oglExtensions);
  GL_ARB_fragment_layer_viewport := gl_IsSupported('GL_ARB_fragment_layer_viewport', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_fragment_program := gl_IsSupported('GL_ARB_fragment_program', oglExtensions);
  GL_ARB_fragment_program_shadow := gl_IsSupported('GL_ARB_fragment_program_shadow', oglExtensions);
  GL_ARB_fragment_shader := gl_IsSupported('GL_ARB_fragment_shader', oglExtensions);
  {$EndIf}
  GL_ARB_fragment_shader_interlock := gl_IsSupported('GL_ARB_fragment_shader_interlock', oglExtensions);
  GL_ARB_framebuffer_no_attachments := gl_IsSupported('GL_ARB_framebuffer_no_attachments', oglExtensions);
  GL_ARB_framebuffer_object := gl_IsSupported('GL_ARB_framebuffer_object', oglExtensions);
  GL_ARB_framebuffer_sRGB := gl_IsSupported('GL_ARB_framebuffer_sRGB', oglExtensions);
  GL_ARB_geometry_shader4 := gl_IsSupported('GL_ARB_geometry_shader4', oglExtensions);
  GL_ARB_get_program_binary := gl_IsSupported('GL_ARB_get_program_binary', oglExtensions);
  GL_ARB_get_texture_sub_image := gl_IsSupported('GL_ARB_get_texture_sub_image', oglExtensions);
  GL_ARB_gl_spirv := gl_IsSupported('GL_ARB_gl_spirv', oglExtensions);
  GL_ARB_gpu_shader5 := gl_IsSupported('GL_ARB_gpu_shader5', oglExtensions);
  GL_ARB_gpu_shader_fp64 := gl_IsSupported('GL_ARB_gpu_shader_fp64', oglExtensions);
  GL_ARB_gpu_shader_int64 := gl_IsSupported('GL_ARB_gpu_shader_int64', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_half_float_pixel := gl_IsSupported('GL_ARB_half_float_pixel', oglExtensions);
  GL_ARB_imaging := gl_IsSupported('GL_ARB_imaging', oglExtensions);
  {$EndIf}
  GL_ARB_half_float_vertex := gl_IsSupported('GL_ARB_half_float_vertex', oglExtensions);
  GL_ARB_indirect_parameters := gl_IsSupported('GL_ARB_indirect_parameters', oglExtensions);
  GL_ARB_instanced_arrays := gl_IsSupported('GL_ARB_instanced_arrays', oglExtensions);
  GL_ARB_internalformat_query := gl_IsSupported('GL_ARB_internalformat_query', oglExtensions);
  GL_ARB_internalformat_query2 := gl_IsSupported('GL_ARB_internalformat_query2', oglExtensions);
  GL_ARB_invalidate_subdata := gl_IsSupported('GL_ARB_invalidate_subdata', oglExtensions);
  GL_ARB_map_buffer_alignment := gl_IsSupported('GL_ARB_map_buffer_alignment', oglExtensions);
  GL_ARB_map_buffer_range := gl_IsSupported('GL_ARB_map_buffer_range', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_matrix_palette := gl_IsSupported('GL_ARB_matrix_palette', oglExtensions);
  {$EndIf}
  GL_ARB_multi_bind := gl_IsSupported('GL_ARB_multi_bind', oglExtensions);
  GL_ARB_multi_draw_indirect := gl_IsSupported('GL_ARB_multi_draw_indirect', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_multisample := gl_IsSupported('GL_ARB_multisample', oglExtensions);
  GL_ARB_multitexture := gl_IsSupported('GL_ARB_multitexture', oglExtensions);
  GL_ARB_occlusion_query := gl_IsSupported('GL_ARB_occlusion_query', oglExtensions);
  {$EndIf}
  GL_ARB_occlusion_query2 := gl_IsSupported('GL_ARB_occlusion_query2', oglExtensions);
  GL_ARB_parallel_shader_compile := gl_IsSupported('GL_ARB_parallel_shader_compile', oglExtensions);
  GL_ARB_pipeline_statistics_query := gl_IsSupported('GL_ARB_pipeline_statistics_query', oglExtensions);
  GL_ARB_pixel_buffer_object := gl_IsSupported('GL_ARB_pixel_buffer_object', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_point_parameters := gl_IsSupported('GL_ARB_point_parameters', oglExtensions);
  GL_ARB_point_sprite := gl_IsSupported('GL_ARB_point_sprite', oglExtensions);
  {$EndIf}
  GL_ARB_polygon_offset_clamp := gl_IsSupported('GL_ARB_polygon_offset_clamp', oglExtensions);
  GL_ARB_post_depth_coverage := gl_IsSupported('GL_ARB_post_depth_coverage', oglExtensions);
  GL_ARB_program_interface_query := gl_IsSupported('GL_ARB_program_interface_query', oglExtensions);
  GL_ARB_provoking_vertex := gl_IsSupported('GL_ARB_provoking_vertex', oglExtensions);
  GL_ARB_query_buffer_object := gl_IsSupported('GL_ARB_query_buffer_object', oglExtensions);
  GL_ARB_robust_buffer_access_behavior := gl_IsSupported('GL_ARB_robust_buffer_access_behavior', oglExtensions);
  GL_ARB_robustness := gl_IsSupported('GL_ARB_robustness', oglExtensions);
  GL_ARB_robustness_isolation := gl_IsSupported('GL_ARB_robustness_isolation', oglExtensions);
  GL_ARB_sample_locations := gl_IsSupported('GL_ARB_sample_locations', oglExtensions);
  GL_ARB_sample_shading := gl_IsSupported('GL_ARB_sample_shading', oglExtensions);
  GL_ARB_sampler_objects := gl_IsSupported('GL_ARB_sampler_objects', oglExtensions);
  GL_ARB_seamless_cube_map := gl_IsSupported('GL_ARB_seamless_cube_map', oglExtensions);
  GL_ARB_seamless_cubemap_per_texture := gl_IsSupported('GL_ARB_seamless_cubemap_per_texture', oglExtensions);
  GL_ARB_separate_shader_objects := gl_IsSupported('GL_ARB_separate_shader_objects', oglExtensions);
  GL_ARB_shader_atomic_counter_ops := gl_IsSupported('GL_ARB_shader_atomic_counter_ops', oglExtensions);
  GL_ARB_shader_atomic_counters := gl_IsSupported('GL_ARB_shader_atomic_counters', oglExtensions);
  GL_ARB_shader_ballot := gl_IsSupported('GL_ARB_shader_ballot', oglExtensions);
  GL_ARB_shader_bit_encoding := gl_IsSupported('GL_ARB_shader_bit_encoding', oglExtensions);
  GL_ARB_shader_clock := gl_IsSupported('GL_ARB_shader_clock', oglExtensions);
  GL_ARB_shader_draw_parameters := gl_IsSupported('GL_ARB_shader_draw_parameters', oglExtensions);
  GL_ARB_shader_group_vote := gl_IsSupported('GL_ARB_shader_group_vote', oglExtensions);
  GL_ARB_shader_image_load_store := gl_IsSupported('GL_ARB_shader_image_load_store', oglExtensions);
  GL_ARB_shader_image_size := gl_IsSupported('GL_ARB_shader_image_size', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_shader_objects := gl_IsSupported('GL_ARB_shader_objects', oglExtensions);
  {$EndIf}
  GL_ARB_shader_precision := gl_IsSupported('GL_ARB_shader_precision', oglExtensions);
  GL_ARB_shader_stencil_export := gl_IsSupported('GL_ARB_shader_stencil_export', oglExtensions);
  GL_ARB_shader_storage_buffer_object := gl_IsSupported('GL_ARB_shader_storage_buffer_object', oglExtensions);
  GL_ARB_shader_subroutine := gl_IsSupported('GL_ARB_shader_subroutine', oglExtensions);
  GL_ARB_shader_texture_image_samples := gl_IsSupported('GL_ARB_shader_texture_image_samples', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_shader_texture_lod := gl_IsSupported('GL_ARB_shader_texture_lod', oglExtensions);
  GL_ARB_shading_language_100 := gl_IsSupported('GL_ARB_shading_language_100', oglExtensions);
  {$EndIf}
  GL_ARB_shader_viewport_layer_array := gl_IsSupported('GL_ARB_shader_viewport_layer_array', oglExtensions);
  GL_ARB_shading_language_420pack := gl_IsSupported('GL_ARB_shading_language_420pack', oglExtensions);
  GL_ARB_shading_language_include := gl_IsSupported('GL_ARB_shading_language_include', oglExtensions);
  GL_ARB_shading_language_packing := gl_IsSupported('GL_ARB_shading_language_packing', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_shadow := gl_IsSupported('GL_ARB_shadow', oglExtensions);
  GL_ARB_shadow_ambient := gl_IsSupported('GL_ARB_shadow_ambient', oglExtensions);
  {$EndIf}
  GL_ARB_sparse_buffer := gl_IsSupported('GL_ARB_sparse_buffer', oglExtensions);
  GL_ARB_sparse_texture := gl_IsSupported('GL_ARB_sparse_texture', oglExtensions);
  GL_ARB_sparse_texture2 := gl_IsSupported('GL_ARB_sparse_texture2', oglExtensions);
  GL_ARB_sparse_texture_clamp := gl_IsSupported('GL_ARB_sparse_texture_clamp', oglExtensions);
  GL_ARB_spirv_extensions := gl_IsSupported('GL_ARB_spirv_extensions', oglExtensions);
  GL_ARB_stencil_texturing := gl_IsSupported('GL_ARB_stencil_texturing', oglExtensions);
  GL_ARB_sync := gl_IsSupported('GL_ARB_sync', oglExtensions);
  GL_ARB_tessellation_shader := gl_IsSupported('GL_ARB_tessellation_shader', oglExtensions);
  GL_ARB_texture_barrier := gl_IsSupported('GL_ARB_texture_barrier', oglExtensions);
  GL_ARB_texture_border_clamp := gl_IsSupported('GL_ARB_texture_border_clamp', oglExtensions);
  GL_ARB_texture_buffer_object := gl_IsSupported('GL_ARB_texture_buffer_object', oglExtensions);
  GL_ARB_texture_buffer_object_rgb32 := gl_IsSupported('GL_ARB_texture_buffer_object_rgb32', oglExtensions);
  GL_ARB_texture_buffer_range := gl_IsSupported('GL_ARB_texture_buffer_range', oglExtensions);
  GL_ARB_texture_compression_bptc := gl_IsSupported('GL_ARB_texture_compression_bptc', oglExtensions);
  GL_ARB_texture_compression_rgtc := gl_IsSupported('GL_ARB_texture_compression_rgtc', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_texture_compression := gl_IsSupported('GL_ARB_texture_compression', oglExtensions);
  GL_ARB_texture_cube_map := gl_IsSupported('GL_ARB_texture_cube_map', oglExtensions);
  {$EndIf}
  GL_ARB_texture_cube_map_array := gl_IsSupported('GL_ARB_texture_cube_map_array', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_texture_env_add := gl_IsSupported('GL_ARB_texture_env_add', oglExtensions);
  GL_ARB_texture_env_combine := gl_IsSupported('GL_ARB_texture_env_combine', oglExtensions);
  GL_ARB_texture_env_crossbar := gl_IsSupported('GL_ARB_texture_env_crossbar', oglExtensions);
  GL_ARB_texture_env_dot3 := gl_IsSupported('GL_ARB_texture_env_dot3', oglExtensions);
  GL_ARB_texture_float := gl_IsSupported('GL_ARB_texture_float', oglExtensions);
  {$EndIf}
  GL_ARB_texture_filter_anisotropic := gl_IsSupported('GL_ARB_texture_filter_anisotropic', oglExtensions);
  GL_ARB_texture_filter_minmax := gl_IsSupported('GL_ARB_texture_filter_minmax', oglExtensions);

  GL_ARB_texture_gather := gl_IsSupported('GL_ARB_texture_gather', oglExtensions);
  GL_ARB_texture_mirror_clamp_to_edge := gl_IsSupported('GL_ARB_texture_mirror_clamp_to_edge', oglExtensions);
  GL_ARB_texture_mirrored_repeat := gl_IsSupported('GL_ARB_texture_mirrored_repeat', oglExtensions);
  GL_ARB_texture_multisample := gl_IsSupported('GL_ARB_texture_multisample', oglExtensions);
  GL_ARB_texture_non_power_of_two := gl_IsSupported('GL_ARB_texture_non_power_of_two', oglExtensions);
  GL_ARB_texture_query_levels := gl_IsSupported('GL_ARB_texture_query_levels', oglExtensions);
  GL_ARB_texture_query_lod := gl_IsSupported('GL_ARB_texture_query_lod', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_texture_rectangle := gl_IsSupported('GL_ARB_texture_rectangle', oglExtensions);
  {$EndIf}
  GL_ARB_texture_rg := gl_IsSupported('GL_ARB_texture_rg', oglExtensions);
  GL_ARB_texture_rgb10_a2ui := gl_IsSupported('GL_ARB_texture_rgb10_a2ui', oglExtensions);
  GL_ARB_texture_stencil8 := gl_IsSupported('GL_ARB_texture_stencil8', oglExtensions);
  GL_ARB_texture_storage := gl_IsSupported('GL_ARB_texture_storage', oglExtensions);
  GL_ARB_texture_storage_multisample := gl_IsSupported('GL_ARB_texture_storage_multisample', oglExtensions);
  GL_ARB_texture_swizzle := gl_IsSupported('GL_ARB_texture_swizzle', oglExtensions);
  GL_ARB_texture_view := gl_IsSupported('GL_ARB_texture_view', oglExtensions);
  GL_ARB_timer_query := gl_IsSupported('GL_ARB_timer_query', oglExtensions);
  GL_ARB_transform_feedback2 := gl_IsSupported('GL_ARB_transform_feedback2', oglExtensions);
  GL_ARB_transform_feedback3 := gl_IsSupported('GL_ARB_transform_feedback3', oglExtensions);
  GL_ARB_transform_feedback_instanced := gl_IsSupported('GL_ARB_transform_feedback_instanced', oglExtensions);
  GL_ARB_transform_feedback_overflow_query := gl_IsSupported('GL_ARB_transform_feedback_overflow_query', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_transpose_matrix := gl_IsSupported('GL_ARB_transpose_matrix', oglExtensions);
  {$EndIf}
  GL_ARB_uniform_buffer_object := gl_IsSupported('GL_ARB_uniform_buffer_object', oglExtensions);
  GL_ARB_vertex_array_bgra := gl_IsSupported('GL_ARB_vertex_array_bgra', oglExtensions);
  GL_ARB_vertex_array_object := gl_IsSupported('GL_ARB_vertex_array_object', oglExtensions);
  GL_ARB_vertex_attrib_64bit := gl_IsSupported('GL_ARB_vertex_attrib_64bit', oglExtensions);
  GL_ARB_vertex_attrib_binding := gl_IsSupported('GL_ARB_vertex_attrib_binding', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_ARB_vertex_blend := gl_IsSupported('GL_ARB_vertex_blend', oglExtensions);
  GL_ARB_vertex_buffer_object := gl_IsSupported('GL_ARB_vertex_buffer_object', oglExtensions);
  GL_ARB_vertex_program := gl_IsSupported('GL_ARB_vertex_program', oglExtensions);
  GL_ARB_vertex_shader := gl_IsSupported('GL_ARB_vertex_shader', oglExtensions);
  GL_ARB_window_pos := gl_IsSupported('GL_ARB_window_pos', oglExtensions);
  {$EndIf}
  GL_ARB_vertex_type_10f_11f_11f_rev := gl_IsSupported('GL_ARB_vertex_type_10f_11f_11f_rev', oglExtensions);
  GL_ARB_vertex_type_2_10_10_10_rev := gl_IsSupported('GL_ARB_vertex_type_2_10_10_10_rev', oglExtensions);
  GL_ARB_viewport_array := gl_IsSupported('GL_ARB_viewport_array', oglExtensions);
  GL_KHR_blend_equation_advanced := gl_IsSupported('GL_KHR_blend_equation_advanced', oglExtensions);
  GL_KHR_blend_equation_advanced_coherent := gl_IsSupported('GL_KHR_blend_equation_advanced_coherent', oglExtensions);
  GL_KHR_context_flush_control := gl_IsSupported('GL_KHR_context_flush_control', oglExtensions);
  GL_KHR_debug := gl_IsSupported('GL_KHR_debug', oglExtensions);
  GL_KHR_no_error := gl_IsSupported('GL_KHR_no_error', oglExtensions);
  GL_KHR_parallel_shader_compile := gl_IsSupported('GL_KHR_parallel_shader_compile', oglExtensions);
  GL_KHR_robust_buffer_access_behavior := gl_IsSupported('GL_KHR_robust_buffer_access_behavior', oglExtensions);
  GL_KHR_robustness := gl_IsSupported('GL_KHR_robustness', oglExtensions);
  GL_KHR_shader_subgroup := gl_IsSupported('GL_KHR_shader_subgroup', oglExtensions);
  GL_KHR_texture_compression_astc_hdr := gl_IsSupported('GL_KHR_texture_compression_astc_hdr', oglExtensions);
  GL_KHR_texture_compression_astc_ldr := gl_IsSupported('GL_KHR_texture_compression_astc_ldr', oglExtensions);
  GL_KHR_texture_compression_astc_sliced_3d := gl_IsSupported('GL_KHR_texture_compression_astc_sliced_3d', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_OES_byte_coordinates := gl_IsSupported('GL_OES_byte_coordinates', oglExtensions);
  GL_OES_compressed_paletted_texture := gl_IsSupported('GL_OES_compressed_paletted_texture', oglExtensions);
  GL_OES_fixed_point := gl_IsSupported('GL_OES_fixed_point', oglExtensions);
  GL_OES_query_matrix := gl_IsSupported('GL_OES_query_matrix', oglExtensions);
  GL_OES_read_format := gl_IsSupported('GL_OES_read_format', oglExtensions);
  GL_OES_single_precision := gl_IsSupported('GL_OES_single_precision', oglExtensions);
  GL_3DFX_multisample := gl_IsSupported('GL_3DFX_multisample', oglExtensions);
  GL_3DFX_tbuffer := gl_IsSupported('GL_3DFX_tbuffer', oglExtensions);
  GL_3DFX_texture_compression_FXT1 := gl_IsSupported('GL_3DFX_texture_compression_FXT1', oglExtensions);
  GL_AMD_blend_minmax_factor := gl_IsSupported('GL_AMD_blend_minmax_factor', oglExtensions);
  GL_AMD_conservative_depth := gl_IsSupported('GL_AMD_conservative_depth', oglExtensions);
  GL_AMD_debug_output := gl_IsSupported('GL_AMD_debug_output', oglExtensions);
  GL_AMD_depth_clamp_separate := gl_IsSupported('GL_AMD_depth_clamp_separate', oglExtensions);
  GL_AMD_draw_buffers_blend := gl_IsSupported('GL_AMD_draw_buffers_blend', oglExtensions);
  {$EndIf}
  GL_AMD_framebuffer_multisample_advanced := gl_IsSupported('GL_AMD_framebuffer_multisample_advanced', oglExtensions);
  GL_AMD_gpu_shader_int64 := gl_IsSupported('GL_AMD_gpu_shader_int64', oglExtensions); // хотя это GL_EXT
  {$IFDEF USE_GLEXT}
  GL_AMD_framebuffer_sample_positions := gl_IsSupported('GL_AMD_framebuffer_sample_positions', oglExtensions);
  GL_AMD_gcn_shader := gl_IsSupported('GL_AMD_gcn_shader', oglExtensions);
  GL_AMD_gpu_shader_half_float := gl_IsSupported('GL_AMD_gpu_shader_half_float', oglExtensions);
  GL_AMD_gpu_shader_int16 := gl_IsSupported('GL_AMD_gpu_shader_int16', oglExtensions);
  GL_AMD_interleaved_elements := gl_IsSupported('GL_AMD_interleaved_elements', oglExtensions);
  GL_AMD_multi_draw_indirect := gl_IsSupported('GL_AMD_multi_draw_indirect', oglExtensions);
  GL_AMD_name_gen_delete := gl_IsSupported('GL_AMD_name_gen_delete', oglExtensions);
  GL_AMD_occlusion_query_event := gl_IsSupported('GL_AMD_occlusion_query_event', oglExtensions);
  {$EndIf}
  GL_AMD_performance_monitor := gl_IsSupported('GL_AMD_performance_monitor', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_AMD_pinned_memory := gl_IsSupported('GL_AMD_pinned_memory', oglExtensions);
  GL_AMD_query_buffer_object := gl_IsSupported('GL_AMD_query_buffer_object', oglExtensions);
  GL_AMD_sample_positions := gl_IsSupported('GL_AMD_sample_positions', oglExtensions);
  GL_AMD_seamless_cubemap_per_texture := gl_IsSupported('GL_AMD_seamless_cubemap_per_texture', oglExtensions);
  GL_AMD_shader_atomic_counter_ops := gl_IsSupported('GL_AMD_shader_atomic_counter_ops', oglExtensions);
  GL_AMD_shader_ballot := gl_IsSupported('GL_AMD_shader_ballot', oglExtensions);
  GL_AMD_shader_explicit_vertex_parameter := gl_IsSupported('GL_AMD_shader_explicit_vertex_parameter', oglExtensions);
  GL_AMD_shader_gpu_shader_half_float_fetch := gl_IsSupported('GL_AMD_shader_gpu_shader_half_float_fetch', oglExtensions);
  GL_AMD_shader_image_load_store_lod := gl_IsSupported('GL_AMD_shader_image_load_store_lod', oglExtensions);
  GL_AMD_shader_stencil_export := gl_IsSupported('GL_AMD_shader_stencil_export', oglExtensions);
  GL_AMD_shader_trinary_minmax := gl_IsSupported('GL_AMD_shader_trinary_minmax', oglExtensions);
  GL_AMD_sparse_texture := gl_IsSupported('GL_AMD_sparse_texture', oglExtensions);
  GL_AMD_stencil_operation_extended := gl_IsSupported('GL_AMD_stencil_operation_extended', oglExtensions);
  GL_AMD_texture_gather_bias_lod := gl_IsSupported('GL_AMD_texture_gather_bias_lod', oglExtensions);
  GL_AMD_texture_texture4 := gl_IsSupported('GL_AMD_texture_texture4', oglExtensions);
  GL_AMD_transform_feedback3_lines_triangles := gl_IsSupported('GL_AMD_transform_feedback3_lines_triangles', oglExtensions);
  GL_AMD_transform_feedback4 := gl_IsSupported('GL_AMD_transform_feedback4', oglExtensions);
  GL_AMD_vertex_shader_layer := gl_IsSupported('GL_AMD_vertex_shader_layer', oglExtensions);
  GL_AMD_vertex_shader_tessellator := gl_IsSupported('GL_AMD_vertex_shader_tessellator', oglExtensions);
  GL_AMD_vertex_shader_viewport_index := gl_IsSupported('GL_AMD_vertex_shader_viewport_index', oglExtensions);
  GL_APPLE_aux_depth_stencil := gl_IsSupported('GL_APPLE_aux_depth_stencil', oglExtensions);
  GL_APPLE_client_storage := gl_IsSupported('GL_APPLE_client_storage', oglExtensions);
  GL_APPLE_element_array := gl_IsSupported('GL_APPLE_element_array', oglExtensions);
  GL_APPLE_fence := gl_IsSupported('GL_APPLE_fence', oglExtensions);
  GL_APPLE_float_pixels := gl_IsSupported('GL_APPLE_float_pixels', oglExtensions);
  GL_APPLE_flush_buffer_range := gl_IsSupported('GL_APPLE_flush_buffer_range', oglExtensions);
  GL_APPLE_object_purgeable := gl_IsSupported('GL_APPLE_object_purgeable', oglExtensions);
  {$EndIf}
  GL_APPLE_rgb_422 := gl_IsSupported('GL_APPLE_rgb_422', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_APPLE_row_bytes := gl_IsSupported('GL_APPLE_row_bytes', oglExtensions);
  GL_APPLE_specular_vector := gl_IsSupported('GL_APPLE_specular_vector', oglExtensions);
  GL_APPLE_texture_range := gl_IsSupported('GL_APPLE_texture_range', oglExtensions);
  GL_APPLE_transform_hint := gl_IsSupported('GL_APPLE_transform_hint', oglExtensions);
  GL_APPLE_vertex_array_object := gl_IsSupported('GL_APPLE_vertex_array_object', oglExtensions);
  GL_APPLE_vertex_array_range := gl_IsSupported('GL_APPLE_vertex_array_range', oglExtensions);
  GL_APPLE_vertex_program_evaluators := gl_IsSupported('GL_APPLE_vertex_program_evaluators', oglExtensions);
  GL_APPLE_ycbcr_422 := gl_IsSupported('GL_APPLE_ycbcr_422', oglExtensions);
  GL_ATI_draw_buffers := gl_IsSupported('GL_ATI_draw_buffers', oglExtensions);
  GL_ATI_element_array := gl_IsSupported('GL_ATI_element_array', oglExtensions);
  GL_ATI_envmap_bumpmap := gl_IsSupported('GL_ATI_envmap_bumpmap', oglExtensions);
  GL_ATI_fragment_shader := gl_IsSupported('GL_ATI_fragment_shader', oglExtensions);
  GL_ATI_map_object_buffer := gl_IsSupported('GL_ATI_map_object_buffer', oglExtensions);
  GL_ATI_meminfo := gl_IsSupported('GL_ATI_meminfo', oglExtensions);
  GL_ATI_pixel_format_float := gl_IsSupported('GL_ATI_pixel_format_float', oglExtensions);
  GL_ATI_pn_triangles := gl_IsSupported('GL_ATI_pn_triangles', oglExtensions);
  GL_ATI_separate_stencil := gl_IsSupported('GL_ATI_separate_stencil', oglExtensions);
  GL_ATI_text_fragment_shader := gl_IsSupported('GL_ATI_text_fragment_shader', oglExtensions);
  GL_ATI_texture_env_combine3 := gl_IsSupported('GL_ATI_texture_env_combine3', oglExtensions);
  GL_ATI_texture_float := gl_IsSupported('GL_ATI_texture_float', oglExtensions);
  GL_ATI_texture_mirror_once := gl_IsSupported('GL_ATI_texture_mirror_once', oglExtensions);
  GL_ATI_vertex_array_object := gl_IsSupported('GL_ATI_vertex_array_object', oglExtensions);
  GL_ATI_vertex_attrib_array_object := gl_IsSupported('GL_ATI_vertex_attrib_array_object', oglExtensions);
  GL_ATI_vertex_streams := gl_IsSupported('GL_ATI_vertex_streams', oglExtensions);
  GL_EXT_422_pixels := gl_IsSupported('GL_EXT_422_pixels', oglExtensions);
  {$EndIf}
  GL_EXT_EGL_image_storage := gl_IsSupported('GL_EXT_EGL_image_storage', oglExtensions);
  GL_EXT_EGL_sync := gl_IsSupported('GL_EXT_EGL_sync', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_abgr := gl_IsSupported('GL_EXT_abgr', oglExtensions);
  GL_EXT_bgra := gl_IsSupported('GL_EXT_bgra', oglExtensions);
  GL_EXT_bindable_uniform := gl_IsSupported('GL_EXT_bindable_uniform', oglExtensions);
  GL_EXT_blend_color := gl_IsSupported('GL_EXT_blend_color', oglExtensions);
  GL_EXT_blend_equation_separate := gl_IsSupported('GL_EXT_blend_equation_separate', oglExtensions);
//  GL_EXT_blend_func_separate := gl_IsSupported('GL_EXT_blend_func_separate', oglExtensions);
  GL_EXT_blend_logic_op := gl_IsSupported('GL_EXT_blend_logic_op', oglExtensions);
  GL_EXT_blend_minmax := gl_IsSupported('GL_EXT_blend_minmax', oglExtensions);
  GL_EXT_blend_subtract := gl_IsSupported('GL_EXT_blend_subtract', oglExtensions);
  GL_EXT_clip_volume_hint := gl_IsSupported('GL_EXT_clip_volume_hint', oglExtensions);
  GL_EXT_cmyka := gl_IsSupported('GL_EXT_cmyka', oglExtensions);
  GL_EXT_color_subtable := gl_IsSupported('GL_EXT_color_subtable', oglExtensions);
  GL_EXT_compiled_vertex_array := gl_IsSupported('GL_EXT_compiled_vertex_array', oglExtensions);
  GL_EXT_convolution := gl_IsSupported('GL_EXT_convolution', oglExtensions);
  GL_EXT_coordinate_frame := gl_IsSupported('GL_EXT_coordinate_frame', oglExtensions);
  GL_EXT_copy_texture := gl_IsSupported('GL_EXT_copy_texture', oglExtensions);
  GL_EXT_cull_vertex := gl_IsSupported('GL_EXT_cull_vertex', oglExtensions);
  GL_EXT_depth_bounds_test := gl_IsSupported('GL_EXT_depth_bounds_test', oglExtensions);
  GL_EXT_draw_buffers2 := gl_IsSupported('GL_EXT_draw_buffers2', oglExtensions);
  {$EndIf}
  GL_EXT_debug_label := gl_IsSupported('GL_EXT_debug_label', oglExtensions);
  GL_EXT_debug_marker := gl_IsSupported('GL_EXT_debug_marker', oglExtensions);
  GL_EXT_direct_state_access := gl_IsSupported('GL_EXT_direct_state_access', oglExtensions);
  GL_EXT_draw_instanced := gl_IsSupported('GL_EXT_draw_instanced', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_draw_range_elements := gl_IsSupported('GL_EXT_draw_range_elements', oglExtensions);
  GL_EXT_external_buffer := gl_IsSupported('GL_EXT_external_buffer', oglExtensions);
  GL_EXT_fog_coord := gl_IsSupported('GL_EXT_fog_coord', oglExtensions);
  GL_EXT_framebuffer_blit := gl_IsSupported('GL_EXT_framebuffer_blit', oglExtensions);
  GL_EXT_framebuffer_multisample := gl_IsSupported('GL_EXT_framebuffer_multisample', oglExtensions);
  GL_EXT_framebuffer_multisample_blit_scaled := gl_IsSupported('GL_EXT_framebuffer_multisample_blit_scaled', oglExtensions);
  GL_EXT_framebuffer_object := gl_IsSupported('GL_EXT_framebuffer_object', oglExtensions);
  GL_EXT_framebuffer_sRGB := gl_IsSupported('GL_EXT_framebuffer_sRGB', oglExtensions);
  GL_EXT_geometry_shader4 := gl_IsSupported('GL_EXT_geometry_shader4', oglExtensions);
  GL_EXT_gpu_program_parameters := gl_IsSupported('GL_EXT_gpu_program_parameters', oglExtensions);
  GL_EXT_gpu_shader4 := gl_IsSupported('GL_EXT_gpu_shader4', oglExtensions);
  GL_EXT_histogram := gl_IsSupported('GL_EXT_histogram', oglExtensions);
  GL_EXT_index_array_formats := gl_IsSupported('GL_EXT_index_array_formats', oglExtensions);
  GL_EXT_index_func := gl_IsSupported('GL_EXT_index_func', oglExtensions);
  GL_EXT_index_material := gl_IsSupported('GL_EXT_index_material', oglExtensions);
  GL_EXT_index_texture := gl_IsSupported('GL_EXT_index_texture', oglExtensions);
  GL_EXT_light_texture := gl_IsSupported('GL_EXT_light_texture', oglExtensions);
  GL_EXT_memory_object := gl_IsSupported('GL_EXT_memory_object', oglExtensions);
  GL_EXT_memory_object_fd := gl_IsSupported('GL_EXT_memory_object_fd', oglExtensions);
  GL_EXT_memory_object_win32 := gl_IsSupported('GL_EXT_memory_object_win32', oglExtensions);
  GL_EXT_misc_attribute := gl_IsSupported('GL_EXT_misc_attribute', oglExtensions);
  GL_EXT_multi_draw_arrays := gl_IsSupported('GL_EXT_multi_draw_arrays', oglExtensions);
  GL_EXT_multisample := gl_IsSupported('GL_EXT_multisample', oglExtensions);
  {$EndIf}
  GL_EXT_multiview_tessellation_geometry_shader := gl_IsSupported('GL_EXT_multiview_tessellation_geometry_shader', oglExtensions);
  GL_EXT_multiview_texture_multisample := gl_IsSupported('GL_EXT_multiview_texture_multisample', oglExtensions);
  GL_EXT_multiview_timer_query := gl_IsSupported('GL_EXT_multiview_timer_query', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_packed_depth_stencil := gl_IsSupported('GL_EXT_packed_depth_stencil', oglExtensions);
  GL_EXT_packed_float := gl_IsSupported('GL_EXT_packed_float', oglExtensions);
  GL_EXT_packed_pixels := gl_IsSupported('GL_EXT_packed_pixels', oglExtensions);
  GL_EXT_paletted_texture := gl_IsSupported('GL_EXT_paletted_texture', oglExtensions);
  GL_EXT_pixel_buffer_object := gl_IsSupported('GL_EXT_pixel_buffer_object', oglExtensions);
  GL_EXT_pixel_transform := gl_IsSupported('GL_EXT_pixel_transform', oglExtensions);
  GL_EXT_pixel_transform_color_table := gl_IsSupported('GL_EXT_pixel_transform_color_table', oglExtensions);
  GL_EXT_point_parameters := gl_IsSupported('GL_EXT_point_parameters', oglExtensions);
  GL_EXT_polygon_offset := gl_IsSupported('GL_EXT_polygon_offset', oglExtensions);
  GL_EXT_provoking_vertex := gl_IsSupported('GL_EXT_provoking_vertex', oglExtensions);
  {$EndIf}
  GL_EXT_polygon_offset_clamp := gl_IsSupported('GL_EXT_polygon_offset_clamp', oglExtensions);
  GL_EXT_post_depth_coverage := gl_IsSupported('GL_EXT_post_depth_coverage', oglExtensions);
  GL_EXT_raster_multisample := gl_IsSupported('GL_EXT_raster_multisample', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_rescale_normal := gl_IsSupported('GL_EXT_rescale_normal', oglExtensions);
  GL_EXT_secondary_color := gl_IsSupported('GL_EXT_secondary_color', oglExtensions);
  GL_EXT_semaphore := gl_IsSupported('GL_EXT_semaphore', oglExtensions);
  GL_EXT_semaphore_fd := gl_IsSupported('GL_EXT_semaphore_fd', oglExtensions);
  GL_EXT_semaphore_win32 := gl_IsSupported('GL_EXT_semaphore_win32', oglExtensions);
  GL_EXT_separate_specular_color := gl_IsSupported('GL_EXT_separate_specular_color', oglExtensions);
  {$EndIf}
  GL_EXT_separate_shader_objects := gl_IsSupported('GL_EXT_separate_shader_objects', oglExtensions);
  GL_EXT_shader_framebuffer_fetch := gl_IsSupported('GL_EXT_shader_framebuffer_fetch', oglExtensions);
  GL_EXT_shader_framebuffer_fetch_non_coherent := gl_IsSupported('GL_EXT_shader_framebuffer_fetch_non_coherent', oglExtensions);
  GL_EXT_shader_integer_mix := gl_IsSupported('GL_EXT_shader_integer_mix', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_shader_image_load_formatted := gl_IsSupported('GL_EXT_shader_image_load_formatted', oglExtensions);
  GL_EXT_shader_image_load_store := gl_IsSupported('GL_EXT_shader_image_load_store', oglExtensions);
  GL_EXT_shadow_funcs := gl_IsSupported('GL_EXT_shadow_funcs', oglExtensions);
  GL_EXT_shared_texture_palette := gl_IsSupported('GL_EXT_shared_texture_palette', oglExtensions);
  GL_EXT_sparse_texture2 := gl_IsSupported('GL_EXT_sparse_texture2', oglExtensions);
  GL_EXT_stencil_clear_tag := gl_IsSupported('GL_EXT_stencil_clear_tag', oglExtensions);
  GL_EXT_stencil_two_side := gl_IsSupported('GL_EXT_stencil_two_side', oglExtensions);
  GL_EXT_stencil_wrap := gl_IsSupported('GL_EXT_stencil_wrap', oglExtensions);
  GL_EXT_subtexture := gl_IsSupported('GL_EXT_subtexture', oglExtensions);
  GL_EXT_texture := gl_IsSupported('GL_EXT_texture', oglExtensions);
  GL_EXT_texture3D := gl_IsSupported('GL_EXT_texture3D', oglExtensions);
  GL_EXT_texture_array := gl_IsSupported('GL_EXT_texture_array', oglExtensions);
  GL_EXT_texture_buffer_object := gl_IsSupported('GL_EXT_texture_buffer_object', oglExtensions);
  GL_EXT_texture_compression_latc := gl_IsSupported('GL_EXT_texture_compression_latc', oglExtensions);
  GL_EXT_texture_compression_rgtc := gl_IsSupported('GL_EXT_texture_compression_rgtc', oglExtensions);
//  GL_EXT_texture_compression_s3tc := gl_IsSupported('GL_EXT_texture_compression_s3tc', oglExtensions);
  GL_EXT_texture_cube_map := gl_IsSupported('GL_EXT_texture_cube_map', oglExtensions);
  GL_EXT_texture_env_add := gl_IsSupported('GL_EXT_texture_env_add', oglExtensions);
  GL_EXT_texture_env_combine := gl_IsSupported('GL_EXT_texture_env_combine', oglExtensions);
  GL_EXT_texture_env_dot3 := gl_IsSupported('GL_EXT_texture_env_dot3', oglExtensions);
//  GL_EXT_texture_filter_anisotropic := gl_IsSupported('GL_EXT_texture_filter_anisotropic', oglExtensions);
  {$EndIf}
  GL_EXT_texture_filter_minmax := gl_IsSupported('GL_EXT_texture_filter_minmax', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_texture_integer := gl_IsSupported('GL_EXT_texture_integer', oglExtensions);
  GL_EXT_texture_lod_bias := gl_IsSupported('GL_EXT_texture_lod_bias', oglExtensions);
  GL_EXT_texture_mirror_clamp := gl_IsSupported('GL_EXT_texture_mirror_clamp', oglExtensions);
  GL_EXT_texture_object := gl_IsSupported('GL_EXT_texture_object', oglExtensions);
  GL_EXT_texture_perturb_normal := gl_IsSupported('GL_EXT_texture_perturb_normal', oglExtensions);
  GL_EXT_texture_sRGB := gl_IsSupported('GL_EXT_texture_sRGB', oglExtensions);
  GL_EXT_texture_shared_exponent := gl_IsSupported('GL_EXT_texture_shared_exponent', oglExtensions);
  GL_EXT_texture_snorm := gl_IsSupported('GL_EXT_texture_snorm', oglExtensions);
  {$EndIf}
  GL_EXT_texture_sRGB_R8 := gl_IsSupported('GL_EXT_texture_sRGB_R8', oglExtensions);
  GL_EXT_texture_sRGB_RG8 := gl_IsSupported('GL_EXT_texture_sRGB_RG8', oglExtensions);
  GL_EXT_texture_sRGB_decode := gl_IsSupported('GL_EXT_texture_sRGB_decode', oglExtensions);
  GL_EXT_texture_shadow_lod := gl_IsSupported('GL_EXT_texture_shadow_lod', oglExtensions);
  GL_EXT_texture_storage := gl_IsSupported('GL_EXT_texture_storage', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_texture_swizzle := gl_IsSupported('GL_EXT_texture_swizzle', oglExtensions);
  GL_EXT_timer_query := gl_IsSupported('GL_EXT_timer_query', oglExtensions);
  GL_EXT_transform_feedback := gl_IsSupported('GL_EXT_transform_feedback', oglExtensions);
  GL_EXT_vertex_array := gl_IsSupported('GL_EXT_vertex_array', oglExtensions);
  GL_EXT_vertex_array_bgra := gl_IsSupported('GL_EXT_vertex_array_bgra', oglExtensions);
  GL_EXT_vertex_attrib_64bit := gl_IsSupported('GL_EXT_vertex_attrib_64bit', oglExtensions);
  GL_EXT_vertex_shader := gl_IsSupported('GL_EXT_vertex_shader', oglExtensions);
  GL_EXT_vertex_weighting := gl_IsSupported('GL_EXT_vertex_weighting', oglExtensions);
  GL_EXT_win32_keyed_mutex := gl_IsSupported('GL_EXT_win32_keyed_mutex', oglExtensions);
  {$EndIf}
  GL_EXT_window_rectangles := gl_IsSupported('GL_EXT_window_rectangles', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_EXT_x11_sync_object := gl_IsSupported('GL_EXT_x11_sync_object', oglExtensions);
  GL_GREMEDY_frame_terminator := gl_IsSupported('GL_GREMEDY_frame_terminator', oglExtensions);
  GL_GREMEDY_string_marker := gl_IsSupported('GL_GREMEDY_string_marker', oglExtensions);
  GL_HP_convolution_border_modes := gl_IsSupported('GL_HP_convolution_border_modes', oglExtensions);
  GL_HP_image_transform := gl_IsSupported('GL_HP_image_transform', oglExtensions);
  GL_HP_occlusion_test := gl_IsSupported('GL_HP_occlusion_test', oglExtensions);
  GL_HP_texture_lighting := gl_IsSupported('GL_HP_texture_lighting', oglExtensions);
  GL_IBM_cull_vertex := gl_IsSupported('GL_IBM_cull_vertex', oglExtensions);
  GL_IBM_multimode_draw_arrays := gl_IsSupported('GL_IBM_multimode_draw_arrays', oglExtensions);
  GL_IBM_rasterpos_clip := gl_IsSupported('GL_IBM_rasterpos_clip', oglExtensions);
  GL_IBM_static_data := gl_IsSupported('GL_IBM_static_data', oglExtensions);
  GL_IBM_texture_mirrored_repeat := gl_IsSupported('GL_IBM_texture_mirrored_repeat', oglExtensions);
  GL_IBM_vertex_array_lists := gl_IsSupported('GL_IBM_vertex_array_lists', oglExtensions);
  GL_INGR_blend_func_separate := gl_IsSupported('GL_INGR_blend_func_separate', oglExtensions);
  GL_INGR_color_clamp := gl_IsSupported('GL_INGR_color_clamp', oglExtensions);
  GL_INGR_interlace_read := gl_IsSupported('GL_INGR_interlace_read', oglExtensions);
  GL_INTEL_fragment_shader_ordering := gl_IsSupported('GL_INTEL_fragment_shader_ordering', oglExtensions);
  {$EndIf}
  GL_INTEL_blackhole_render := gl_IsSupported('GL_INTEL_blackhole_render', oglExtensions);
  GL_INTEL_conservative_rasterization := gl_IsSupported('GL_INTEL_conservative_rasterization', oglExtensions);
  GL_INTEL_framebuffer_CMAA := gl_IsSupported('GL_INTEL_framebuffer_CMAA', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_INTEL_map_texture := gl_IsSupported('GL_INTEL_map_texture', oglExtensions);
  GL_INTEL_parallel_arrays := gl_IsSupported('GL_INTEL_parallel_arrays', oglExtensions);
  GL_MESAX_texture_stack := gl_IsSupported('GL_MESAX_texture_stack', oglExtensions);
  {$EndIf}
  GL_INTEL_performance_query := gl_IsSupported('GL_INTEL_performance_query', oglExtensions);
  GL_MESA_framebuffer_flip_x := gl_IsSupported('GL_MESA_framebuffer_flip_x', oglExtensions);
  GL_MESA_framebuffer_flip_y := gl_IsSupported('GL_MESA_framebuffer_flip_y', oglExtensions);
  GL_MESA_framebuffer_swap_xy := gl_IsSupported('GL_MESA_framebuffer_swap_xy', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_MESA_pack_invert := gl_IsSupported('GL_MESA_pack_invert', oglExtensions);
  GL_MESA_program_binary_formats := gl_IsSupported('GL_MESA_program_binary_formats', oglExtensions);
  GL_MESA_resize_buffers := gl_IsSupported('GL_MESA_resize_buffers', oglExtensions);
  GL_MESA_shader_integer_functions := gl_IsSupported('GL_MESA_shader_integer_functions', oglExtensions);
  GL_MESA_tile_raster_order := gl_IsSupported('GL_MESA_tile_raster_order', oglExtensions);
  GL_MESA_window_pos := gl_IsSupported('GL_MESA_window_pos', oglExtensions);
  GL_MESA_ycbcr_texture := gl_IsSupported('GL_MESA_ycbcr_texture', oglExtensions);
  GL_NVX_blend_equation_advanced_multi_draw_buffers := gl_IsSupported('GL_NVX_blend_equation_advanced_multi_draw_buffers', oglExtensions);
  GL_NVX_conditional_render := gl_IsSupported('GL_NVX_conditional_render', oglExtensions);
  GL_NVX_gpu_memory_info := gl_IsSupported('GL_NVX_gpu_memory_info', oglExtensions);
  GL_NVX_gpu_multicast2 := gl_IsSupported('GL_NVX_gpu_multicast2', oglExtensions);
  GL_NVX_linked_gpu_multicast := gl_IsSupported('GL_NVX_linked_gpu_multicast', oglExtensions);
  GL_NVX_progress_fence := gl_IsSupported('GL_NVX_progress_fence', oglExtensions);
  GL_NV_alpha_to_coverage_dither_control := gl_IsSupported('GL_NV_alpha_to_coverage_dither_control', oglExtensions);
  {$EndIf}
  GL_NV_bindless_multi_draw_indirect := gl_IsSupported('GL_NV_bindless_multi_draw_indirect', oglExtensions);
  GL_NV_bindless_multi_draw_indirect_count := gl_IsSupported('GL_NV_bindless_multi_draw_indirect_count', oglExtensions);
  GL_NV_bindless_texture := gl_IsSupported('GL_NV_bindless_texture', oglExtensions);
  GL_NV_blend_equation_advanced := gl_IsSupported('GL_NV_blend_equation_advanced', oglExtensions);
  GL_NV_blend_equation_advanced_coherent := gl_IsSupported('GL_NV_blend_equation_advanced_coherent', oglExtensions);
  GL_NV_blend_minmax_factor := gl_IsSupported('GL_NV_blend_minmax_factor', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_blend_square := gl_IsSupported('GL_NV_blend_square', oglExtensions);   
  GL_NV_compute_program5 := gl_IsSupported('GL_NV_compute_program5', oglExtensions);
  {$EndIf}
  GL_NV_clip_space_w_scaling := gl_IsSupported('GL_NV_clip_space_w_scaling', oglExtensions);
  GL_NV_command_list := gl_IsSupported('GL_NV_command_list', oglExtensions);
  GL_NV_compute_shader_derivatives := gl_IsSupported('GL_NV_compute_shader_derivatives', oglExtensions);
  GL_NV_conditional_render := gl_IsSupported('GL_NV_conditional_render', oglExtensions);
  GL_NV_conservative_raster := gl_IsSupported('GL_NV_conservative_raster', oglExtensions);
  GL_NV_conservative_raster_dilate := gl_IsSupported('GL_NV_conservative_raster_dilate', oglExtensions);
  GL_NV_conservative_raster_pre_snap := gl_IsSupported('GL_NV_conservative_raster_pre_snap', oglExtensions);
  GL_NV_conservative_raster_pre_snap_triangles := gl_IsSupported('GL_NV_conservative_raster_pre_snap_triangles', oglExtensions);
  GL_NV_conservative_raster_underestimation := gl_IsSupported('GL_NV_conservative_raster_underestimation', oglExtensions);
  GL_NV_depth_buffer_float := gl_IsSupported('GL_NV_depth_buffer_float', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_copy_depth_to_color := gl_IsSupported('GL_NV_copy_depth_to_color', oglExtensions);
  GL_NV_copy_image := gl_IsSupported('GL_NV_copy_image', oglExtensions);
  GL_NV_deep_texture3D := gl_IsSupported('GL_NV_deep_texture3D', oglExtensions);
  GL_NV_depth_clamp := gl_IsSupported('GL_NV_depth_clamp', oglExtensions);
  GL_NV_draw_texture := gl_IsSupported('GL_NV_draw_texture', oglExtensions);
  GL_NV_evaluators := gl_IsSupported('GL_NV_evaluators', oglExtensions);
  GL_NV_explicit_multisample := gl_IsSupported('GL_NV_explicit_multisample', oglExtensions);
  GL_NV_fence := gl_IsSupported('GL_NV_fence', oglExtensions);
  {$EndIf}
  GL_NV_draw_vulkan_image := gl_IsSupported('GL_NV_draw_vulkan_image', oglExtensions);
  GL_NV_fill_rectangle := gl_IsSupported('GL_NV_fill_rectangle', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_float_buffer := gl_IsSupported('GL_NV_float_buffer', oglExtensions);
  GL_NV_fog_distance := gl_IsSupported('GL_NV_fog_distance', oglExtensions);     
  GL_NV_fragment_program := gl_IsSupported('GL_NV_fragment_program', oglExtensions);
  GL_NV_fragment_program2 := gl_IsSupported('GL_NV_fragment_program2', oglExtensions);
  GL_NV_fragment_program4 := gl_IsSupported('GL_NV_fragment_program4', oglExtensions);
  GL_NV_fragment_program_option := gl_IsSupported('GL_NV_fragment_program_option', oglExtensions);
  {$EndIf}
  GL_NV_fragment_coverage_to_color := gl_IsSupported('GL_NV_fragment_coverage_to_color', oglExtensions);
  GL_NV_fragment_shader_barycentric := gl_IsSupported('GL_NV_fragment_shader_barycentric', oglExtensions);
  GL_NV_fragment_shader_interlock := gl_IsSupported('GL_NV_fragment_shader_interlock', oglExtensions);
  GL_NV_framebuffer_mixed_samples := gl_IsSupported('GL_NV_framebuffer_mixed_samples', oglExtensions);
  GL_NV_framebuffer_multisample_coverage := gl_IsSupported('GL_NV_framebuffer_multisample_coverage', oglExtensions);  
  GL_NV_geometry_shader_passthrough := gl_IsSupported('GL_NV_geometry_shader_passthrough', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_geometry_program4 := gl_IsSupported('GL_NV_geometry_program4', oglExtensions);
  GL_NV_geometry_shader4 := gl_IsSupported('GL_NV_geometry_shader4', oglExtensions);
  GL_NV_gpu_multicast := gl_IsSupported('GL_NV_gpu_multicast', oglExtensions);
  GL_NV_gpu_program4 := gl_IsSupported('GL_NV_gpu_program4', oglExtensions);
  GL_NV_gpu_program5 := gl_IsSupported('GL_NV_gpu_program5', oglExtensions);
  GL_NV_gpu_program5_mem_extended := gl_IsSupported('GL_NV_gpu_program5_mem_extended', oglExtensions);
  {$EndIf}
  // узнать, работает ли эта часть при GLext!!!!
  // хотя функции подменены в другом разделе.
  GL_NV_gpu_shader5 := gl_IsSupported('GL_NV_gpu_shader5', oglExtensions);  
  GL_NV_internalformat_sample_query := gl_IsSupported('GL_NV_internalformat_sample_query', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_half_float := gl_IsSupported('GL_NV_half_float', oglExtensions);
  GL_NV_light_max_exponent := gl_IsSupported('GL_NV_light_max_exponent', oglExtensions);
  {$EndIf}
  GL_NV_memory_attachment := gl_IsSupported('GL_NV_memory_attachment', oglExtensions);
  GL_NV_memory_object_sparse := gl_IsSupported('GL_NV_memory_object_sparse', oglExtensions);
  GL_NV_mesh_shader := gl_IsSupported('GL_NV_mesh_shader', oglExtensions);    
  GL_NV_path_rendering := gl_IsSupported('GL_NV_path_rendering', oglExtensions);
  GL_NV_path_rendering_shared_edge := gl_IsSupported('GL_NV_path_rendering_shared_edge', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_multisample_coverage := gl_IsSupported('GL_NV_multisample_coverage', oglExtensions);
  GL_NV_multisample_filter_hint := gl_IsSupported('GL_NV_multisample_filter_hint', oglExtensions);
  GL_NV_occlusion_query := gl_IsSupported('GL_NV_occlusion_query', oglExtensions);
  GL_NV_packed_depth_stencil := gl_IsSupported('GL_NV_packed_depth_stencil', oglExtensions);
  GL_NV_parameter_buffer_object := gl_IsSupported('GL_NV_parameter_buffer_object', oglExtensions);
  GL_NV_parameter_buffer_object2 := gl_IsSupported('GL_NV_parameter_buffer_object2', oglExtensions); 
  GL_NV_pixel_data_range := gl_IsSupported('GL_NV_pixel_data_range', oglExtensions);
  GL_NV_point_sprite := gl_IsSupported('GL_NV_point_sprite', oglExtensions);
  GL_NV_present_video := gl_IsSupported('GL_NV_present_video', oglExtensions);
  GL_NV_primitive_restart := gl_IsSupported('GL_NV_primitive_restart', oglExtensions);
  {$EndIf}
  GL_NV_primitive_shading_rate := gl_IsSupported('GL_NV_primitive_shading_rate', oglExtensions);    
  GL_NV_representative_fragment_test := gl_IsSupported('GL_NV_representative_fragment_test', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_query_resource := gl_IsSupported('GL_NV_query_resource', oglExtensions);
  GL_NV_query_resource_tag := gl_IsSupported('GL_NV_query_resource_tag', oglExtensions);
  GL_NV_register_combiners := gl_IsSupported('GL_NV_register_combiners', oglExtensions);
  GL_NV_register_combiners2 := gl_IsSupported('GL_NV_register_combiners2', oglExtensions);
  GL_NV_robustness_video_memory_purge := gl_IsSupported('GL_NV_robustness_video_memory_purge', oglExtensions);
  {$EndIf}
  GL_NV_sample_locations := gl_IsSupported('GL_NV_sample_locations', oglExtensions);
  GL_NV_sample_mask_override_coverage := gl_IsSupported('GL_NV_sample_mask_override_coverage', oglExtensions);
  GL_NV_scissor_exclusive := gl_IsSupported('GL_NV_scissor_exclusive', oglExtensions);
  GL_NV_shader_atomic_counters := gl_IsSupported('GL_NV_shader_atomic_counters', oglExtensions);
  GL_NV_shader_atomic_float := gl_IsSupported('GL_NV_shader_atomic_float', oglExtensions);
  GL_NV_shader_atomic_float64 := gl_IsSupported('GL_NV_shader_atomic_float64', oglExtensions);
  GL_NV_shader_atomic_fp16_vector := gl_IsSupported('GL_NV_shader_atomic_fp16_vector', oglExtensions);
  GL_NV_shader_atomic_int64 := gl_IsSupported('GL_NV_shader_atomic_int64', oglExtensions);
  GL_NV_shader_buffer_load := gl_IsSupported('GL_NV_shader_buffer_load', oglExtensions);
  GL_NV_shader_buffer_store := gl_IsSupported('GL_NV_shader_buffer_store', oglExtensions);  
  GL_NV_shader_subgroup_partitioned := gl_IsSupported('GL_NV_shader_subgroup_partitioned', oglExtensions);
  GL_NV_shader_texture_footprint := gl_IsSupported('GL_NV_shader_texture_footprint', oglExtensions);
  GL_NV_shader_thread_group := gl_IsSupported('GL_NV_shader_thread_group', oglExtensions);
  GL_NV_shader_thread_shuffle := gl_IsSupported('GL_NV_shader_thread_shuffle', oglExtensions);
  GL_NV_shading_rate_image := gl_IsSupported('GL_NV_shading_rate_image', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_shader_storage_buffer_object := gl_IsSupported('GL_NV_shader_storage_buffer_object', oglExtensions);  
  GL_NV_stereo_view_rendering := gl_IsSupported('GL_NV_stereo_view_rendering', oglExtensions);
  GL_NV_tessellation_program5 := gl_IsSupported('GL_NV_tessellation_program5', oglExtensions);
  GL_NV_texgen_emboss := gl_IsSupported('GL_NV_texgen_emboss', oglExtensions);
  GL_NV_texgen_reflection := gl_IsSupported('GL_NV_texgen_reflection', oglExtensions);   
  GL_NV_texture_compression_vtc := gl_IsSupported('GL_NV_texture_compression_vtc', oglExtensions);
  GL_NV_texture_env_combine4 := gl_IsSupported('GL_NV_texture_env_combine4', oglExtensions);
  GL_NV_texture_expand_normal := gl_IsSupported('GL_NV_texture_expand_normal', oglExtensions);
  GL_NV_texture_multisample := gl_IsSupported('GL_NV_texture_multisample', oglExtensions);
  GL_NV_texture_rectangle := gl_IsSupported('GL_NV_texture_rectangle', oglExtensions);
  {$EndIf}
  GL_NV_texture_barrier := gl_IsSupported('GL_NV_texture_barrier', oglExtensions);
  GL_NV_texture_rectangle_compressed := gl_IsSupported('GL_NV_texture_rectangle_compressed', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_texture_shader := gl_IsSupported('GL_NV_texture_shader', oglExtensions);
  GL_NV_texture_shader2 := gl_IsSupported('GL_NV_texture_shader2', oglExtensions);
  GL_NV_texture_shader3 := gl_IsSupported('GL_NV_texture_shader3', oglExtensions);
  GL_NV_timeline_semaphore := gl_IsSupported('GL_NV_timeline_semaphore', oglExtensions);
  GL_NV_transform_feedback := gl_IsSupported('GL_NV_transform_feedback', oglExtensions);
  GL_NV_transform_feedback2 := gl_IsSupported('GL_NV_transform_feedback2', oglExtensions);  
  GL_NV_vdpau_interop := gl_IsSupported('GL_NV_vdpau_interop', oglExtensions);
  GL_NV_vdpau_interop2 := gl_IsSupported('GL_NV_vdpau_interop2', oglExtensions);
  GL_NV_vertex_array_range := gl_IsSupported('GL_NV_vertex_array_range', oglExtensions);
  GL_NV_vertex_array_range2 := gl_IsSupported('GL_NV_vertex_array_range2', oglExtensions);
  {$EndIf}
  GL_NV_uniform_buffer_unified_memory := gl_IsSupported('GL_NV_uniform_buffer_unified_memory', oglExtensions);
  GL_NV_vertex_attrib_integer_64bit := gl_IsSupported('GL_NV_vertex_attrib_integer_64bit', oglExtensions);
  GL_NV_vertex_buffer_unified_memory := gl_IsSupported('GL_NV_vertex_buffer_unified_memory', oglExtensions);    
  GL_NV_viewport_array2 := gl_IsSupported('GL_NV_viewport_array2', oglExtensions);
  GL_NV_viewport_swizzle := gl_IsSupported('GL_NV_viewport_swizzle', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_NV_vertex_program := gl_IsSupported('GL_NV_vertex_program', oglExtensions);
  GL_NV_vertex_program1_1 := gl_IsSupported('GL_NV_vertex_program1_1', oglExtensions);
  GL_NV_vertex_program2 := gl_IsSupported('GL_NV_vertex_program2', oglExtensions);
  GL_NV_vertex_program2_option := gl_IsSupported('GL_NV_vertex_program2_option', oglExtensions);
  GL_NV_vertex_program3 := gl_IsSupported('GL_NV_vertex_program3', oglExtensions);
  GL_NV_vertex_program4 := gl_IsSupported('GL_NV_vertex_program4', oglExtensions);
  GL_NV_video_capture := gl_IsSupported('GL_NV_video_capture', oglExtensions);
  GL_OML_interlace := gl_IsSupported('GL_OML_interlace', oglExtensions);
  GL_OML_resample := gl_IsSupported('GL_OML_resample', oglExtensions);
  GL_OML_subsample := gl_IsSupported('GL_OML_subsample', oglExtensions);
  {$EndIf}
  GL_OVR_multiview := gl_IsSupported('GL_OVR_multiview', oglExtensions);
  GL_OVR_multiview2 := gl_IsSupported('GL_OVR_multiview2', oglExtensions);
  {$IFDEF USE_GLEXT}
  GL_PGI_misc_hints := gl_IsSupported('GL_PGI_misc_hints', oglExtensions);
  GL_PGI_vertex_hints := gl_IsSupported('GL_PGI_vertex_hints', oglExtensions);
  GL_REND_screen_coordinates := gl_IsSupported('GL_REND_screen_coordinates', oglExtensions);
  GL_S3_s3tc := gl_IsSupported('GL_S3_s3tc', oglExtensions);
  GL_SGIS_detail_texture := gl_IsSupported('GL_SGIS_detail_texture', oglExtensions);
  GL_SGIS_fog_function := gl_IsSupported('GL_SGIS_fog_function', oglExtensions);
//  GL_SGIS_generate_mipmap := gl_IsSupported('GL_SGIS_generate_mipmap', oglExtensions);
  GL_SGIS_multisample := gl_IsSupported('GL_SGIS_multisample', oglExtensions);
  GL_SGIS_pixel_texture := gl_IsSupported('GL_SGIS_pixel_texture', oglExtensions);
  GL_SGIS_point_line_texgen := gl_IsSupported('GL_SGIS_point_line_texgen', oglExtensions);
  GL_SGIS_point_parameters := gl_IsSupported('GL_SGIS_point_parameters', oglExtensions);
  GL_SGIS_sharpen_texture := gl_IsSupported('GL_SGIS_sharpen_texture', oglExtensions);
  GL_SGIS_texture4D := gl_IsSupported('GL_SGIS_texture4D', oglExtensions);
  GL_SGIS_texture_border_clamp := gl_IsSupported('GL_SGIS_texture_border_clamp', oglExtensions);
  GL_SGIS_texture_color_mask := gl_IsSupported('GL_SGIS_texture_color_mask', oglExtensions);
  GL_SGIS_texture_edge_clamp := gl_IsSupported('GL_SGIS_texture_edge_clamp', oglExtensions);
  GL_SGIS_texture_filter4 := gl_IsSupported('GL_SGIS_texture_filter4', oglExtensions);
  GL_SGIS_texture_lod := gl_IsSupported('GL_SGIS_texture_lod', oglExtensions);
  GL_SGIS_texture_select := gl_IsSupported('GL_SGIS_texture_select', oglExtensions);
  GL_SGIX_async := gl_IsSupported('GL_SGIX_async', oglExtensions);
  GL_SGIX_async_histogram := gl_IsSupported('GL_SGIX_async_histogram', oglExtensions);
  GL_SGIX_async_pixel := gl_IsSupported('GL_SGIX_async_pixel', oglExtensions);
  GL_SGIX_blend_alpha_minmax := gl_IsSupported('GL_SGIX_blend_alpha_minmax', oglExtensions);
  GL_SGIX_calligraphic_fragment := gl_IsSupported('GL_SGIX_calligraphic_fragment', oglExtensions);
  GL_SGIX_clipmap := gl_IsSupported('GL_SGIX_clipmap', oglExtensions);
  GL_SGIX_convolution_accuracy := gl_IsSupported('GL_SGIX_convolution_accuracy', oglExtensions);
  GL_SGIX_depth_pass_instrument := gl_IsSupported('GL_SGIX_depth_pass_instrument', oglExtensions);
  GL_SGIX_depth_texture := gl_IsSupported('GL_SGIX_depth_texture', oglExtensions);
  GL_SGIX_flush_raster := gl_IsSupported('GL_SGIX_flush_raster', oglExtensions);
  GL_SGIX_fog_offset := gl_IsSupported('GL_SGIX_fog_offset', oglExtensions);
  GL_SGIX_fragment_lighting := gl_IsSupported('GL_SGIX_fragment_lighting', oglExtensions);
  GL_SGIX_framezoom := gl_IsSupported('GL_SGIX_framezoom', oglExtensions);
  GL_SGIX_igloo_interface := gl_IsSupported('GL_SGIX_igloo_interface', oglExtensions);
  GL_SGIX_instruments := gl_IsSupported('GL_SGIX_instruments', oglExtensions);
  GL_SGIX_interlace := gl_IsSupported('GL_SGIX_interlace', oglExtensions);
  GL_SGIX_ir_instrument1 := gl_IsSupported('GL_SGIX_ir_instrument1', oglExtensions);
  GL_SGIX_list_priority := gl_IsSupported('GL_SGIX_list_priority', oglExtensions);
  GL_SGIX_pixel_texture := gl_IsSupported('GL_SGIX_pixel_texture', oglExtensions);
  GL_SGIX_pixel_tiles := gl_IsSupported('GL_SGIX_pixel_tiles', oglExtensions);
  GL_SGIX_polynomial_ffd := gl_IsSupported('GL_SGIX_polynomial_ffd', oglExtensions);
  GL_SGIX_reference_plane := gl_IsSupported('GL_SGIX_reference_plane', oglExtensions);
  GL_SGIX_resample := gl_IsSupported('GL_SGIX_resample', oglExtensions);
  GL_SGIX_scalebias_hint := gl_IsSupported('GL_SGIX_scalebias_hint', oglExtensions);
  GL_SGIX_shadow := gl_IsSupported('GL_SGIX_shadow', oglExtensions);
  GL_SGIX_shadow_ambient := gl_IsSupported('GL_SGIX_shadow_ambient', oglExtensions);
  GL_SGIX_sprite := gl_IsSupported('GL_SGIX_sprite', oglExtensions);
  GL_SGIX_subsample := gl_IsSupported('GL_SGIX_subsample', oglExtensions);
  GL_SGIX_tag_sample_buffer := gl_IsSupported('GL_SGIX_tag_sample_buffer', oglExtensions);
  GL_SGIX_texture_add_env := gl_IsSupported('GL_SGIX_texture_add_env', oglExtensions);
  GL_SGIX_texture_coordinate_clamp := gl_IsSupported('GL_SGIX_texture_coordinate_clamp', oglExtensions);
  GL_SGIX_texture_lod_bias := gl_IsSupported('GL_SGIX_texture_lod_bias', oglExtensions);
  GL_SGIX_texture_multi_buffer := gl_IsSupported('GL_SGIX_texture_multi_buffer', oglExtensions);
  GL_SGIX_texture_scale_bias := gl_IsSupported('GL_SGIX_texture_scale_bias', oglExtensions);
  GL_SGIX_vertex_preclip := gl_IsSupported('GL_SGIX_vertex_preclip', oglExtensions);
  GL_SGIX_ycrcb := gl_IsSupported('GL_SGIX_ycrcb', oglExtensions);
  GL_SGIX_ycrcb_subsample := gl_IsSupported('GL_SGIX_ycrcb_subsample', oglExtensions);
  GL_SGIX_ycrcba := gl_IsSupported('GL_SGIX_ycrcba', oglExtensions);
  GL_SGI_color_matrix := gl_IsSupported('GL_SGI_color_matrix', oglExtensions);
  GL_SGI_color_table := gl_IsSupported('GL_SGI_color_table', oglExtensions);
  GL_SGI_texture_color_table := gl_IsSupported('GL_SGI_texture_color_table', oglExtensions);
  GL_SUNX_constant_data := gl_IsSupported('GL_SUNX_constant_data', oglExtensions);
  GL_SUN_convolution_border_modes := gl_IsSupported('GL_SUN_convolution_border_modes', oglExtensions);
  GL_SUN_global_alpha := gl_IsSupported('GL_SUN_global_alpha', oglExtensions);
  GL_SUN_mesh_array := gl_IsSupported('GL_SUN_mesh_array', oglExtensions);
  GL_SUN_slice_accum := gl_IsSupported('GL_SUN_slice_accum', oglExtensions);
  GL_SUN_triangle_list := gl_IsSupported('GL_SUN_triangle_list', oglExtensions);
  GL_SUN_vertex := gl_IsSupported('GL_SUN_vertex', oglExtensions);
  GL_WIN_phong_shading := gl_IsSupported('GL_WIN_phong_shading', oglExtensions);
  GL_WIN_specular_fog := gl_IsSupported('GL_WIN_specular_fog', oglExtensions);
  {$EndIf}
end;
{$IfEnd}

procedure CheckGLVersion;
var
  Buffer: String;
begin
  {$IfDef USE_GLU}
  GLU_VERSION_1_1 := False;
  GLU_VERSION_1_2 := False;
  GLU_VERSION_1_3 := False;

  Buffer := gluGetString(GLU_VERSION);
  GLUVersion := Integer(buffer[3]) - 48;

  GLU_VERSION_1_1 := True;

  if GLUVersion >= 2 then
    GLU_VERSION_1_2 := True;

  if GLUVersion >= 3 then
    GLU_VERSION_1_3 := True;
  {$EndIf}

  {$IfDef USE_GL_33}
  glGetIntegerv(GL_MAJOR_VERSION, @GLVersion[0]);
  glGetIntegerv(GL_MINOR_VERSION, @GLVersion[1]);
  {$Else}
  Buffer := glGetString(GL_VERSION);
  GLVersion[0] := Integer(Buffer[1]) - 48;
  GLVersion[1] := Integer(buffer[3]) - 48;
  {$EndIf}
  use_glMinorVer := 0;
  use_glMajorVer := 1;

  if GLVersion[0] > maxGLVerMajor then
    GLVersion[0] := maxGLVerMajor;
  if GLVersion[1] > maxGLVerMinor then
    GLVersion[1] := maxGLVerMinor;

  GL_VERSION_1_0 := True;
  {$IfDef GL_VERSION_1_1}
  GL_VERSION_1_1 := False;
  {$EndIf}
  {$IfDef GL_VERSION_1_2}
  GL_VERSION_1_2 := False;
  {$EndIf}
  {$IfDef GL_VERSION_1_3}
  GL_VERSION_1_3 := False;
  {$EndIf}
  {$IfDef GL_VERSION_1_4}
  GL_VERSION_1_4 := False;
  {$EndIf}
  {$IfDef GL_VERSION_1_5}
  GL_VERSION_1_5 := False;
  {$EndIf}
  {$IfDef GL_VERSION_2_0}
  GL_VERSION_2_0 := False;
  {$EndIf}
  {$IfDef GL_VERSION_2_1}
  GL_VERSION_2_1 := False;
  {$EndIf}
  {$IfDef GL_VERSION_3_0}
  GL_VERSION_3_0 := False;
  {$EndIf}
  {$IfDef GL_VERSION_3_1}
  GL_VERSION_3_1 := False;
  {$EndIf}
  {$IfDef GL_VERSION_3_2}
  GL_VERSION_3_2 := False;
  {$EndIf}
  {$IfDef GL_VERSION_3_3}
  GL_VERSION_3_3 := False;
  {$EndIf}
  {$IfDef GL_VERSION_4_0}
  GL_VERSION_4_0 := False;
  {$EndIf}
  {$IfDef GL_VERSION_4_1}
  GL_VERSION_4_1 := False;
  {$EndIf}
  {$IfDef GL_VERSION_4_2}
  GL_VERSION_4_2 := False;
  {$EndIf}
  {$IfDef GL_VERSION_4_3}
  GL_VERSION_4_3 := False;
  {$EndIf}
  {$IfDef GL_VERSION_4_4}
  GL_VERSION_4_4 := False;
  {$EndIf}
  {$IfDef GL_VERSION_4_5}
  GL_VERSION_4_5 := False;
  {$EndIf}
  {$IfDef GL_VERSION_4_6}
  GL_VERSION_4_6 := False;
  {$EndIf}

  {$if defined(GL_VERSION_4_0) or defined(GL_VERSION_4_1) or defined(GL_VERSION_4_2) or defined(GL_VERSION_4_3) or defined(GL_VERSION_4_4) or defined(GL_VERSION_4_5) or defined(GL_VERSION_4_6)}
  if GLVersion[0] >= 4 then
  begin
    use_glMajorVer := 4;
    {$IfDef GL_VERSION_1_1}
    GL_VERSION_1_1 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_2}
    GL_VERSION_1_2 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_3}
    GL_VERSION_1_3 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_4}
    GL_VERSION_1_4 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_5}
    GL_VERSION_1_5 := True;
    {$EndIf}
    {$IfDef GL_VERSION_2_0}
    GL_VERSION_2_0 := True;
    {$EndIf}
    {$IfDef GL_VERSION_2_0}
    GL_VERSION_2_1 := True;
    {$EndIf}
    {.$IfDef GL_VERSION_3_0}
    GL_VERSION_3_0 := True;
    {.$EndIf}
    {$IfDef GL_VERSION_3_1}
    GL_VERSION_3_1 := True;
    {$EndIf}
    {$IfDef GL_VERSION_3_2}
    GL_VERSION_3_2 := True;
    {$EndIf}
    {$IfDef GL_VERSION_3_3}
    GL_VERSION_3_3 := True;
    {$EndIf}
    {$IfDef GL_VERSION_4_0}
    GL_VERSION_4_0 := True;
    {$EndIf}
    {$IfDef GL_VERSION_4_1}
    if GLVersion[1] >= 1 then
    begin
      GL_VERSION_4_1 := True;
      use_glMinorVer := 1;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_4_2}
    if GLVersion[1] >= 2 then
    begin
      GL_VERSION_4_2 := True;
      use_glMinorVer := 2;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_4_3}
    if GLVersion[1] >= 3 then
    begin
      GL_VERSION_4_3 := True;
      use_glMinorVer := 3;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_4_4}
    if GLVersion[1] >= 4 then
    begin
      GL_VERSION_4_4 := True;
      use_glMinorVer := 4;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_4_5}
    if GLVersion[1] >= 5 then
    begin
      GL_VERSION_4_5 := True;
      use_glMinorVer := 5;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_4_6}
    if GLVersion[1] >= 6 then
    begin
      GL_VERSION_4_6 := True;
      use_glMinorVer := 1;
    end;
    {$EndIf}
    exit;
  end;
  {$IfEnd}

  {$if defined(GL_VERSION_3_0) or defined(GL_VERSION_3_1) or defined(GL_VERSION_3_2) or defined(GL_VERSION_3_3)}
  if GLVersion[0] >= 3 then
  begin
    // проверку на то какой контекст делаем надо делать или нет???
    use_glMajorVer := 3;
    {$IfDef GL_VERSION_1_1}
    GL_VERSION_1_1 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_2}
    GL_VERSION_1_2 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_3}
    GL_VERSION_1_3 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_4}
    GL_VERSION_1_4 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_5}
    GL_VERSION_1_5 := True;
    {$EndIf}
    {$IfDef GL_VERSION_2_0}
    GL_VERSION_2_0 := True;
    {$EndIf}
    {$IfDef GL_VERSION_2_0}
    GL_VERSION_2_1 := True;
    {$EndIf}
    {.$IfDef GL_VERSION_3_0}
    GL_VERSION_3_0 := True;
    {.$EndIf}
    {$IfDef GL_VERSION_3_1}
    if GLVersion[1] >= 1 then
    begin
      GL_VERSION_3_1 := True;
      use_glMinorVer := 1;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_3_2}
    if GLVersion[1] >= 2 then
    begin
      GL_VERSION_3_2 := True;
      use_glMinorVer := 2;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_3_3}
    if GLVersion[1] >= 3 then
    begin
      GL_VERSION_3_3 := True;
      use_glMinorVer := 3;
    end;
    {$EndIf}
    exit;
  end;
  {$IfEnd}

  {$If defined(GL_VERSION_2_0) or defined(GL_VERSION_2_1)}
  if GLVersion[0] >= 2 then
  begin
    use_glMajorVer := 2;
    {$IfDef GL_VERSION_1_1}
    GL_VERSION_1_1 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_2}
    GL_VERSION_1_2 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_3}
    GL_VERSION_1_3 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_4}
    GL_VERSION_1_4 := True;
    {$EndIf}
    {$IfDef GL_VERSION_1_5}
    GL_VERSION_1_5 := True;
    {$EndIf}
    {$IfDef GL_VERSION_2_0}
    GL_VERSION_2_0 := True;
    {$EndIf}
    {$IfDef GL_VERSION_2_1}
    if GLVersion[1] >= 1 then
    begin
      GL_VERSION_2_1 := True;
      use_glMinorVer := 1;
    end;
    {$EndIf}
    exit;
  end;
  {$IfEnd}

  {$if defined(GL_VERSION_1_1) or defined(GL_VERSION_1_2) or defined(GL_VERSION_1_3) or defined(GL_VERSION_1_4) or defined(GL_VERSION_1_5)}
  if GLVersion[0] = 1 then
  begin
    {$IfDef GL_VERSION_1_1}
    if GLVersion[1] >= 1 then
    begin
      GL_VERSION_1_1 := True;
      use_glMinorVer := 1;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_1_2}
    if GLVersion[1] >= 2 then
    begin
      GL_VERSION_1_2 := True;
      use_glMinorVer := 2;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_1_3}
    if GLVersion[1] >= 3 then
    begin
      GL_VERSION_1_3 := True;
      use_glMinorVer := 3;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_1_4}
    if GLVersion[1] >= 4 then
    begin
      GL_VERSION_1_4 := True;
      use_glMinorVer := 4;
    end;
    {$EndIf}
    {$IfDef GL_VERSION_1_5}
    if GLVersion[1] >= 5 then
    begin
      GL_VERSION_1_5 := True;
      use_glMinorVer := 5;
    end;
    {$EndIf}
  end;
  {$IfEnd}
end;

function LoadOpenGL: Boolean;
begin
{  Result := False;
  if gl_Library <> Nil then
    glFreeLib(gl_Library);
  gl_Library := glLoadLib(PChar(libGL));
  if gl_Library = nil then
    exit;                    // Error!!! }

  Result := True;

  {$IfDef LINUX}
  oglExtensions := '';
  {$IfDef GL_VERSION_3_0}
  if use_glMajorVer >= 3 then
  begin
    if not Assigned(glGetStringi) then
      glGetStringi := gl_GetProc('glGetStringi');
    if Assigned(glGetStringi) then
    begin
      glGetIntegerv(GL_NUM_EXTENSIONS, @j);
      for i := 0 to j - 1 do
        oglExtensions := oglExtensions + PAnsiChar(glGetStringi(GL_EXTENSIONS, i)) + #32;
    end;
  end;
  {$EndIf}
  if oglExtensions = '' then
    oglExtensions := glGetString(GL_EXTENSIONS);
  {$EndIf}

  {$If defined(USE_GLEXT) or defined(USE_GLCORE)}
  AllCheckGLExtension;
  {$IfEnd}
  // ZenGL ++
  GL_SGIS_generate_mipmap := gl_IsSupported('GL_SGIS_generate_mipmap', oglExtensions);
  GL_EXT_texture_compression_s3tc := gl_IsSupported('GL_EXT_texture_compression_s3tc', oglExtensions);
  GL_EXT_texture_filter_anisotropic := gl_IsSupported('GL_EXT_texture_filter_anisotropic', oglExtensions);
  GL_EXT_blend_func_separate := gl_IsSupported('GL_EXT_blend_func_separate', oglExtensions);

  {$IfDef USE_DEPRECATED}
(*  glAccum := gl_GetProc('glAccum');
//  glAlphaFunc := gl_GetProc('glAlphaFunc');
  glAreTexturesResident := gl_GetProc('glAreTexturesResident');
//  glArrayElement := gl_GetProc('glArrayElement');
//  glBegin := gl_GetProc('glBegin');
  glBitmap := gl_GetProc('glBitmap');
  glCallList := gl_GetProc('glCallList');
  glCallLists := gl_GetProc('glCallLists');
  glClearAccum := gl_GetProc('glClearAccum');
  glClearIndex := gl_GetProc('glClearIndex');
  glClipPlane := gl_GetProc('glClipPlane');
  glColor3b := gl_GetProc('glColor3b');
  glColor3bv := gl_GetProc('glColor3bv');
  glColor3d := gl_GetProc('glColor3d');
  glColor3dv := gl_GetProc('glColor3dv');
  glColor3f := gl_GetProc('glColor3f');
  glColor3fv := gl_GetProc('glColor3fv');
  glColor3i := gl_GetProc('glColor3i');
  glColor3iv := gl_GetProc('glColor3iv');
  glColor3s := gl_GetProc('glColor3s');
  glColor3sv := gl_GetProc('glColor3sv');
//  glColor3ub := gl_GetProc('glColor3ub');
//  glColor3ubv := gl_GetProc('glColor3ubv');
  glColor3ui := gl_GetProc('glColor3ui');
  glColor3uiv := gl_GetProc('glColor3uiv');
  glColor3us := gl_GetProc('glColor3us');
  glColor3usv := gl_GetProc('glColor3usv');
  glColor4b := gl_GetProc('glColor4b');
  glColor4bv := gl_GetProc('glColor4bv');
  glColor4d := gl_GetProc('glColor4d');
  glColor4dv := gl_GetProc('glColor4dv');
//  glColor4f := gl_GetProc('glColor4f');
//  glColor4fv := gl_GetProc('glColor4fv');
  glColor4i := gl_GetProc('glColor4i');
  glColor4iv := gl_GetProc('glColor4iv');
  glColor4s := gl_GetProc('glColor4s');
  glColor4sv := gl_GetProc('glColor4sv');
//  glColor4ub := gl_GetProc('glColor4ub');
//  glColor4ubv := gl_GetProc('glColor4ubv');
  glColor4ui := gl_GetProc('glColor4ui');
  glColor4uiv := gl_GetProc('glColor4uiv');
  glColor4us := gl_GetProc('glColor4us');
  glColor4usv := gl_GetProc('glColor4usv');
//  glColorMaterial := gl_GetProc('glColorMaterial');
//  glColorPointer := gl_GetProc('glColorPointer');
  glCopyPixels := gl_GetProc('glCopyPixels');
  glDeleteLists := gl_GetProc('glDeleteLists');
//  glDisableClientState := gl_GetProc('glDisableClientState');
  glDrawPixels := gl_GetProc('glDrawPixels');
  glEdgeFlag := gl_GetProc('glEdgeFlag');
//  glEdgeFlagPointer := gl_GetProc('glEdgeFlagPointer');
  glEdgeFlagv := gl_GetProc('glEdgeFlagv');
//  glEnableClientState := gl_GetProc('glEnableClientState');
//  glEnd := gl_GetProc('glEnd');
  glEndList := gl_GetProc('glEndList');
  glEvalCoord1d := gl_GetProc('glEvalCoord1d');
  glEvalCoord1dv := gl_GetProc('glEvalCoord1dv');
  glEvalCoord1f := gl_GetProc('glEvalCoord1f');
  glEvalCoord1fv := gl_GetProc('glEvalCoord1fv');
  glEvalCoord2d := gl_GetProc('glEvalCoord2d');
  glEvalCoord2dv := gl_GetProc('glEvalCoord2dv');
  glEvalCoord2f := gl_GetProc('glEvalCoord2f');
  glEvalCoord2fv := gl_GetProc('glEvalCoord2fv');
  glEvalMesh1 := gl_GetProc('glEvalMesh1');
  glEvalMesh2 := gl_GetProc('glEvalMesh2');
  glEvalPoint1 := gl_GetProc('glEvalPoint1');
  glEvalPoint2 := gl_GetProc('glEvalPoint2');
  glFeedbackBuffer := gl_GetProc('glFeedbackBuffer');
  glFogf := gl_GetProc('glFogf');
  glFogfv := gl_GetProc('glFogfv');
  glFogi := gl_GetProc('glFogi');
  glFogiv := gl_GetProc('glFogiv');
//  glFrustum := gl_GetProc('glFrustum');
  glGenLists := gl_GetProc('glGenLists');
  glGetClipPlane := gl_GetProc('glGetClipPlane');
//  glGetLightfv := gl_GetProc('glGetLightfv');
//  glGetLightiv := gl_GetProc('glGetLightiv');
  glGetMapdv := gl_GetProc('glGetMapdv');
  glGetMapfv := gl_GetProc('glGetMapfv');
  glGetMapiv := gl_GetProc('glGetMapiv');
//  glGetMaterialfv := gl_GetProc('glGetMaterialfv');
//  glGetMaterialiv := gl_GetProc('glGetMaterialiv');
  glGetPixelMapfv := gl_GetProc('glGetPixelMapfv');
  glGetPixelMapuiv := gl_GetProc('glGetPixelMapuiv');
  glGetPixelMapusv := gl_GetProc('glGetPixelMapusv');
  glGetPolygonStipple := gl_GetProc('glGetPolygonStipple');
  glGetTexEnvfv := gl_GetProc('glGetTexEnvfv');
  glGetTexEnviv := gl_GetProc('glGetTexEnviv');
  glGetTexGendv := gl_GetProc('glGetTexGendv');
  glGetTexGenfv := gl_GetProc('glGetTexGenfv');
  glGetTexGeniv := gl_GetProc('glGetTexGeniv');
  glIndexMask := gl_GetProc('glIndexMask');
  glIndexPointer := gl_GetProc('glIndexPointer');
  glIndexd := gl_GetProc('glIndexd');
  glIndexdv := gl_GetProc('glIndexdv');
  glIndexf := gl_GetProc('glIndexf');
  glIndexfv := gl_GetProc('glIndexfv');
  glIndexi := gl_GetProc('glIndexi');
  glIndexiv := gl_GetProc('glIndexiv');
  glIndexs := gl_GetProc('glIndexs');
  glIndexsv := gl_GetProc('glIndexsv');
  glIndexub := gl_GetProc('glIndexub');
  glIndexubv := gl_GetProc('glIndexubv');
  glInitNames := gl_GetProc('glInitNames');
//  glInterleavedArrays := gl_GetProc('glInterleavedArrays');
  glIsList := gl_GetProc('glIsList');
//  glLightModelf := gl_GetProc('glLightModelf');
//  glLightModelfv := gl_GetProc('glLightModelfv');
  glLightModeli := gl_GetProc('glLightModeli');
  glLightModeliv := gl_GetProc('glLightModeliv');
//  glLightf := gl_GetProc('glLightf');
//  glLightfv := gl_GetProc('glLightfv');
  glLighti := gl_GetProc('glLighti');
  glLightiv := gl_GetProc('glLightiv');
  glLineStipple := gl_GetProc('glLineStipple');
  glListBase := gl_GetProc('glListBase');
//  glLoadIdentity := gl_GetProc('glLoadIdentity');
  glLoadMatrixd := gl_GetProc('glLoadMatrixd');
//  glLoadMatrixf := gl_GetProc('glLoadMatrixf');
  glLoadName := gl_GetProc('glLoadName');
  glMap1d := gl_GetProc('glMap1d');
  glMap1f := gl_GetProc('glMap1f');
  glMap2d := gl_GetProc('glMap2d');
  glMap2f := gl_GetProc('glMap2f');
  glMapGrid1d := gl_GetProc('glMapGrid1d');
  glMapGrid1f := gl_GetProc('glMapGrid1f');
  glMapGrid2d := gl_GetProc('glMapGrid2d');
  glMapGrid2f := gl_GetProc('glMapGrid2f');
//  glMaterialf := gl_GetProc('glMaterialf');
//  glMaterialfv := gl_GetProc('glMaterialfv');
  glMateriali := gl_GetProc('glMateriali');
  glMaterialiv := gl_GetProc('glMaterialiv');
//  glMatrixMode := gl_GetProc('glMatrixMode');
  glMultMatrixd := gl_GetProc('glMultMatrixd');
  glMultMatrixf := gl_GetProc('glMultMatrixf');
  glNewList := gl_GetProc('glNewList');
  glNormal3b := gl_GetProc('glNormal3b');
  glNormal3bv := gl_GetProc('glNormal3bv');
  glNormal3d := gl_GetProc('glNormal3d');
  glNormal3dv := gl_GetProc('glNormal3dv');
//  glNormal3f := gl_GetProc('glNormal3f');
//  glNormal3fv := gl_GetProc('glNormal3fv');
  glNormal3i := gl_GetProc('glNormal3i');
  glNormal3iv := gl_GetProc('glNormal3iv');
  glNormal3s := gl_GetProc('glNormal3s');
  glNormal3sv := gl_GetProc('glNormal3sv');
//  glNormalPointer := gl_GetProc('glNormalPointer');
//  glOrtho := gl_GetProc('glOrtho');
  glPassThrough := gl_GetProc('glPassThrough');
  glPixelMapfv := gl_GetProc('glPixelMapfv');
  glPixelMapuiv := gl_GetProc('glPixelMapuiv');
  glPixelMapusv := gl_GetProc('glPixelMapusv');
  glPixelTransferf := gl_GetProc('glPixelTransferf');
  glPixelTransferi := gl_GetProc('glPixelTransferi');
  glPixelZoom := gl_GetProc('glPixelZoom');
  glPolygonStipple := gl_GetProc('glPolygonStipple');
  glPopAttrib := gl_GetProc('glPopAttrib');
  glPopClientAttrib := gl_GetProc('glPopClientAttrib');
//  glPopMatrix := gl_GetProc('glPopMatrix');
  glPopName := gl_GetProc('glPopName');
  glPrioritizeTextures := gl_GetProc('glPrioritizeTextures');
  glPushAttrib := gl_GetProc('glPushAttrib');
  glPushClientAttrib := gl_GetProc('glPushClientAttrib');
//  glPushMatrix := gl_GetProc('glPushMatrix');
  glPushName := gl_GetProc('glPushName');
  glRasterPos2d := gl_GetProc('glRasterPos2d');
  glRasterPos2dv := gl_GetProc('glRasterPos2dv');
  glRasterPos2f := gl_GetProc('glRasterPos2f');
  glRasterPos2fv := gl_GetProc('glRasterPos2fv');
  glRasterPos2i := gl_GetProc('glRasterPos2i');
  glRasterPos2iv := gl_GetProc('glRasterPos2iv');
  glRasterPos2s := gl_GetProc('glRasterPos2s');
  glRasterPos2sv := gl_GetProc('glRasterPos2sv');
  glRasterPos3d := gl_GetProc('glRasterPos3d');
  glRasterPos3dv := gl_GetProc('glRasterPos3dv');
  glRasterPos3f := gl_GetProc('glRasterPos3f');
  glRasterPos3fv := gl_GetProc('glRasterPos3fv');
  glRasterPos3i := gl_GetProc('glRasterPos3i');
  glRasterPos3iv := gl_GetProc('glRasterPos3iv');
  glRasterPos3s := gl_GetProc('glRasterPos3s');
  glRasterPos3sv := gl_GetProc('glRasterPos3sv');
  glRasterPos4d := gl_GetProc('glRasterPos4d');
  glRasterPos4dv := gl_GetProc('glRasterPos4dv');
  glRasterPos4f := gl_GetProc('glRasterPos4f');
  glRasterPos4fv := gl_GetProc('glRasterPos4fv');
  glRasterPos4i := gl_GetProc('glRasterPos4i');
  glRasterPos4iv := gl_GetProc('glRasterPos4iv');
  glRasterPos4s := gl_GetProc('glRasterPos4s');
  glRasterPos4sv := gl_GetProc('glRasterPos4sv');
  glRectd := gl_GetProc('glRectd');
  glRectdv := gl_GetProc('glRectdv');
  glRectf := gl_GetProc('glRectf');
  glRectfv := gl_GetProc('glRectfv');
  glRecti := gl_GetProc('glRecti');
  glRectiv := gl_GetProc('glRectiv');
  glRects := gl_GetProc('glRects');
  glRectsv := gl_GetProc('glRectsv');
  glRenderMode := gl_GetProc('glRenderMode');
  glRotated := gl_GetProc('glRotated');
//  glRotatef := gl_GetProc('glRotatef');
  glScaled := gl_GetProc('glScaled');
//  glScalef := gl_GetProc('glScalef');
  glSelectBuffer := gl_GetProc('glSelectBuffer');
//  glShadeModel := gl_GetProc('glShadeModel');
  glTexCoord1d := gl_GetProc('glTexCoord1d');
  glTexCoord1dv := gl_GetProc('glTexCoord1dv');
  glTexCoord1f := gl_GetProc('glTexCoord1f');
  glTexCoord1fv := gl_GetProc('glTexCoord1fv');
  glTexCoord1i := gl_GetProc('glTexCoord1i');
  glTexCoord1iv := gl_GetProc('glTexCoord1iv');
  glTexCoord1s := gl_GetProc('glTexCoord1s');
  glTexCoord1sv := gl_GetProc('glTexCoord1sv');
  glTexCoord2d := gl_GetProc('glTexCoord2d');
  glTexCoord2dv := gl_GetProc('glTexCoord2dv');
//  glTexCoord2f := gl_GetProc('glTexCoord2f');
//  glTexCoord2fv := gl_GetProc('glTexCoord2fv');
  glTexCoord2i := gl_GetProc('glTexCoord2i');
  glTexCoord2iv := gl_GetProc('glTexCoord2iv');
  glTexCoord2s := gl_GetProc('glTexCoord2s');
  glTexCoord2sv := gl_GetProc('glTexCoord2sv');
  glTexCoord3d := gl_GetProc('glTexCoord3d');
  glTexCoord3dv := gl_GetProc('glTexCoord3dv');
  glTexCoord3f := gl_GetProc('glTexCoord3f');
  glTexCoord3fv := gl_GetProc('glTexCoord3fv');
  glTexCoord3i := gl_GetProc('glTexCoord3i');
  glTexCoord3iv := gl_GetProc('glTexCoord3iv');
  glTexCoord3s := gl_GetProc('glTexCoord3s');
  glTexCoord3sv := gl_GetProc('glTexCoord3sv');
  glTexCoord4d := gl_GetProc('glTexCoord4d');
  glTexCoord4dv := gl_GetProc('glTexCoord4dv');
  glTexCoord4f := gl_GetProc('glTexCoord4f');
  glTexCoord4fv := gl_GetProc('glTexCoord4fv');
  glTexCoord4i := gl_GetProc('glTexCoord4i');
  glTexCoord4iv := gl_GetProc('glTexCoord4iv');
  glTexCoord4s := gl_GetProc('glTexCoord4s');
  glTexCoord4sv := gl_GetProc('glTexCoord4sv');
//  glTexCoordPointer := gl_GetProc('glTexCoordPointer');
  glTexEnvf := gl_GetProc('glTexEnvf');
  glTexEnvfv := gl_GetProc('glTexEnvfv');
//  glTexEnvi := gl_GetProc('glTexEnvi');
//  glTexEnviv := gl_GetProc('glTexEnviv');
  glTexGend := gl_GetProc('glTexGend');
  glTexGendv := gl_GetProc('glTexGendv');
  glTexGenf := gl_GetProc('glTexGenf');
  glTexGenfv := gl_GetProc('glTexGenfv');
  glTexGeni := gl_GetProc('glTexGeni');
  glTexGeniv := gl_GetProc('glTexGeniv');
  glTranslated := gl_GetProc('glTranslated');
//  glTranslatef := gl_GetProc('glTranslatef');
  glVertex2d := gl_GetProc('glVertex2d');
  glVertex2dv := gl_GetProc('glVertex2dv');
//  glVertex2f := gl_GetProc('glVertex2f');
//  glVertex2fv := gl_GetProc('glVertex2fv');
  glVertex2i := gl_GetProc('glVertex2i');
  glVertex2iv := gl_GetProc('glVertex2iv');
  glVertex2s := gl_GetProc('glVertex2s');
  glVertex2sv := gl_GetProc('glVertex2sv');
  glVertex3d := gl_GetProc('glVertex3d');
  glVertex3dv := gl_GetProc('glVertex3dv');
//  glVertex3f := gl_GetProc('glVertex3f');
//  glVertex3fv := gl_GetProc('glVertex3fv');
  glVertex3i := gl_GetProc('glVertex3i');
  glVertex3iv := gl_GetProc('glVertex3iv');
  glVertex3s := gl_GetProc('glVertex3s');
  glVertex3sv := gl_GetProc('glVertex3sv');
  glVertex4d := gl_GetProc('glVertex4d');
  glVertex4dv := gl_GetProc('glVertex4dv');
  glVertex4f := gl_GetProc('glVertex4f');
  glVertex4fv := gl_GetProc('glVertex4fv');
  glVertex4i := gl_GetProc('glVertex4i');
  glVertex4iv := gl_GetProc('glVertex4iv');
  glVertex4s := gl_GetProc('glVertex4s');
  glVertex4sv := gl_GetProc('glVertex4sv');
//  glVertexPointer := gl_GetProc('glVertexPointer'); *)
  {$EndIf}

  {$IfDef GL_VERSION_1_0}
(*  glCullFace := gl_GetProc('glCullFace');
  glFrontFace := gl_GetProc('glFrontFace');
//  glHint := gl_GetProc('glHint');
  glLineWidth := gl_GetProc('glLineWidth');
//  glPointSize := gl_GetProc('glPointSize');
  glPolygonMode := gl_GetProc('glPolygonMode');
//  glScissor := gl_GetProc('glScissor');
//  glTexParameterf := gl_GetProc('glTexParameterf');
//  glTexParameterfv := gl_GetProc('glTexParameterfv');
//  glTexParameteri := gl_GetProc('glTexParameteri');
//  glTexParameteriv := gl_GetProc('glTexParameteriv');
  glTexImage1D := gl_GetProc('glTexImage1D');
//  glTexImage2D := gl_GetProc('glTexImage2D');
  glDrawBuffer := gl_GetProc('glDrawBuffer');
//  glClear := gl_GetProc('glClear');
//  glClearColor := gl_GetProc('glClearColor');
  glClearStencil := gl_GetProc('glClearStencil');
//  glClearDepth := gl_GetProc('glClearDepth');
  glStencilMask := gl_GetProc('glStencilMask');
//  glColorMask := gl_GetProc('glColorMask');
//  glDepthMask := gl_GetProc('glDepthMask');
//  glDisable := gl_GetProc('glDisable');
//  glEnable := gl_GetProc('glEnable');
  glFinish := gl_GetProc('glFinish');
  glFlush := gl_GetProc('glFlush');
//  glBlendFunc := gl_GetProc('glBlendFunc');
  glLogicOp := gl_GetProc('glLogicOp');
  glStencilFunc := gl_GetProc('glStencilFunc');
  glStencilOp := gl_GetProc('glStencilOp');
//  glDepthFunc := gl_GetProc('glDepthFunc');
//  glPixelStoref := gl_GetProc('glPixelStoref');
//  glPixelStorei := gl_GetProc('glPixelStorei');
  glReadBuffer := gl_GetProc('glReadBuffer');
//  glReadPixels := gl_GetProc('glReadPixels');
  glGetBooleanv := gl_GetProc('glGetBooleanv');
  glGetDoublev := gl_GetProc('glGetDoublev');
  glGetError := gl_GetProc('glGetError');
//  glGetFloatv := gl_GetProc('glGetFloatv');
//  glGetIntegerv := gl_GetProc('glGetIntegerv');
//  glGetString := gl_GetProc('glGetString');
//  glGetTexImage := gl_GetProc('glGetTexImage');
  glGetTexParameterfv := gl_GetProc('glGetTexParameterfv');
  glGetTexParameteriv := gl_GetProc('glGetTexParameteriv');
  glGetTexLevelParameterfv := gl_GetProc('glGetTexLevelParameterfv');
  glGetTexLevelParameteriv := gl_GetProc('glGetTexLevelParameteriv');
  glIsEnabled := gl_GetProc('glIsEnabled');
//  glDepthRange := gl_GetProc('glDepthRange');
//  glViewport := gl_GetProc('glViewport'); *)
  {$EndIf}

  {$IfDef GL_VERSION_1_1}
(*//  glDrawArrays := gl_GetProc('glDrawArrays');
//  glDrawElements := gl_GetProc('glDrawElements');
  glGetPointerv := gl_GetProc('glGetPointerv');
  glPolygonOffset := gl_GetProc('glPolygonOffset');
  glCopyTexImage1D := gl_GetProc('glCopyTexImage1D');
  glCopyTexImage2D := gl_GetProc('glCopyTexImage2D');
  glCopyTexSubImage1D := gl_GetProc('glCopyTexSubImage1D');
//  glCopyTexSubImage2D := gl_GetProc('glCopyTexSubImage2D');
  glTexSubImage1D := gl_GetProc('glTexSubImage1D');
//  glTexSubImage2D := gl_GetProc('glTexSubImage2D');
//  glBindTexture := gl_GetProc('glBindTexture');
//  glDeleteTextures := gl_GetProc('glDeleteTextures');
//  glGenTextures := gl_GetProc('glGenTextures');
  glIsTexture := gl_GetProc('glIsTexture'); *)
  {$EndIf}

  {$IfDef GL_VERSION_1_2}
(*//  glDrawRangeElements := gl_GetProc('glDrawRangeElements');
  glTexImage3D := gl_GetProc('glTexImage3D');
  glTexSubImage3D := gl_GetProc('glTexSubImage3D');
  glCopyTexSubImage3D := gl_GetProc('glCopyTexSubImage3D'); *)
  {$EndIf}

  {$IfDef GL_VERSION_1_3}
(*  glActiveTexture := gl_GetProc('glActiveTexture');
  glSampleCoverage := gl_GetProc('glSampleCoverage');
  glCompressedTexImage3D := gl_GetProc('glCompressedTexImage3D');
//  glCompressedTexImage2D := gl_GetProc('glCompressedTexImage2D');
  glCompressedTexImage1D:= gl_GetProc('glCompressedTexImage1D');
  glCompressedTexSubImage3D := gl_GetProc('glCompressedTexSubImage3D');
  glCompressedTexSubImage2D := gl_GetProc('glCompressedTexSubImage2D');
  glCompressedTexSubImage1D := gl_GetProc('glCompressedTexSubImage1D');
  glGetCompressedTexImage := gl_GetProc('glGetCompressedTexImage');
  {$IfNDef USE_GLCORE}
  glClientActiveTexture := gl_GetProc('glClientActiveTexture');
  glMultiTexCoord1d := gl_GetProc('glMultiTexCoord1d');
  glMultiTexCoord1dv := gl_GetProc('glMultiTexCoord1dv');
  glMultiTexCoord1f := gl_GetProc('glMultiTexCoord1f');
  glMultiTexCoord1fv := gl_GetProc('glMultiTexCoord1fv');
  glMultiTexCoord1i := gl_GetProc('glMultiTexCoord1i');
  glMultiTexCoord1iv := gl_GetProc('glMultiTexCoord1iv');
  glMultiTexCoord1s := gl_GetProc('glMultiTexCoord1s');
  glMultiTexCoord1sv := gl_GetProc('glMultiTexCoord1sv');
  glMultiTexCoord2d := gl_GetProc('glMultiTexCoord2d');
  glMultiTexCoord2dv := gl_GetProc('glMultiTexCoord2dv');
  glMultiTexCoord2f := gl_GetProc('glMultiTexCoord2f');
  glMultiTexCoord2fv := gl_GetProc('glMultiTexCoord2fv');
  glMultiTexCoord2i := gl_GetProc('glMultiTexCoord2i');
  glMultiTexCoord2iv := gl_GetProc('glMultiTexCoord2iv');
  glMultiTexCoord2s := gl_GetProc('glMultiTexCoord2s');
  glMultiTexCoord2sv := gl_GetProc('glMultiTexCoord2sv');
  glMultiTexCoord3d := gl_GetProc('glMultiTexCoord3d');
  glMultiTexCoord3dv := gl_GetProc('glMultiTexCoord3dv');
  glMultiTexCoord3f := gl_GetProc('glMultiTexCoord3f');
  glMultiTexCoord3fv := gl_GetProc('glMultiTexCoord3fv');
  glMultiTexCoord3i := gl_GetProc('glMultiTexCoord3i');
  glMultiTexCoord3iv := gl_GetProc('glMultiTexCoord3iv');
  glMultiTexCoord3s := gl_GetProc('glMultiTexCoord3s');
  glMultiTexCoord3sv := gl_GetProc('glMultiTexCoord3sv');
  glMultiTexCoord4d := gl_GetProc('glMultiTexCoord4d');
  glMultiTexCoord4dv := gl_GetProc('glMultiTexCoord4dv');
  glMultiTexCoord4f := gl_GetProc('glMultiTexCoord4f');
  glMultiTexCoord4fv := gl_GetProc('glMultiTexCoord4fv');
  glMultiTexCoord4i := gl_GetProc('glMultiTexCoord4i');
  glMultiTexCoord4iv := gl_GetProc('glMultiTexCoord4iv');
  glMultiTexCoord4s := gl_GetProc('glMultiTexCoord4s');
  glMultiTexCoord4sv := gl_GetProc('glMultiTexCoord4sv');
  glLoadTransposeMatrixf := gl_GetProc('glLoadTransposeMatrixf');
  glLoadTransposeMatrixd := gl_GetProc('glLoadTransposeMatrixd');
  glMultTransposeMatrixf := gl_GetProc('glMultTransposeMatrixf');
  glMultTransposeMatrixd := gl_GetProc('glMultTransposeMatrixd');
  {$EndIf} *)
  {$EndIf}

  {$IfDef GL_VERSION_1_4}
  if GL_VERSION_1_4 then
  begin
  //  glBlendFuncSeparate := gl_GetProc('glBlendFuncSeparate');
    glMultiDrawArrays := gl_GetProc('glMultiDrawArrays');
  //  glMultiDrawElements := gl_GetProc('glMultiDrawElements');
    glPointParameterf := gl_GetProc('glPointParameterf');
    glPointParameterfv := gl_GetProc('glPointParameterfv');
    glPointParameteri := gl_GetProc('glPointParameteri');
    glPointParameteriv := gl_GetProc('glPointParameteriv');
    glBlendColor := gl_GetProc('glBlendColor');
  //  glBlendEquation := gl_GetProc('glBlendEquation');
    {$IfNDef USE_GLCORE}
    glFogCoordf := gl_GetProc('glFogCoordf');
    glFogCoordfv := gl_GetProc('glFogCoordfv');
    glFogCoordd := gl_GetProc('glFogCoordd');
    glFogCoorddv := gl_GetProc('glFogCoorddv');
  //  glFogCoordPointer := gl_GetProc('glFogCoordPointer');
    glSecondaryColor3b := gl_GetProc('glSecondaryColor3b');
    glSecondaryColor3bv := gl_GetProc('glSecondaryColor3bv');
    glSecondaryColor3d := gl_GetProc('glSecondaryColor3d');
    glSecondaryColor3dv := gl_GetProc('glSecondaryColor3dv');
    glSecondaryColor3f := gl_GetProc('glSecondaryColor3f');
    glSecondaryColor3fv := gl_GetProc('glSecondaryColor3fv');
    glSecondaryColor3i := gl_GetProc('glSecondaryColor3i');
    glSecondaryColor3iv := gl_GetProc('glSecondaryColor3iv');
    glSecondaryColor3s := gl_GetProc('glSecondaryColor3s');
    glSecondaryColor3sv := gl_GetProc('glSecondaryColor3sv');
    glSecondaryColor3ub := gl_GetProc('glSecondaryColor3ub');
    glSecondaryColor3ubv := gl_GetProc('glSecondaryColor3ubv');
    glSecondaryColor3ui := gl_GetProc('glSecondaryColor3ui');
    glSecondaryColor3uiv := gl_GetProc('glSecondaryColor3uiv');
    glSecondaryColor3us := gl_GetProc('glSecondaryColor3us');
    glSecondaryColor3usv := gl_GetProc('glSecondaryColor3usv');
  //  glSecondaryColorPointer := gl_GetProc('glSecondaryColorPointer');
    glWindowPos2d := gl_GetProc('glWindowPos2d');
    glWindowPos2dv := gl_GetProc('glWindowPos2dv');
    glWindowPos2f := gl_GetProc('glWindowPos2f');
    glWindowPos2fv := gl_GetProc('glWindowPos2fv');
    glWindowPos2i := gl_GetProc('glWindowPos2i');
    glWindowPos2iv := gl_GetProc('glWindowPos2iv');
    glWindowPos2s := gl_GetProc('glWindowPos2s');
    glWindowPos2sv := gl_GetProc('glWindowPos2sv');
    glWindowPos3d := gl_GetProc('glWindowPos3d');
    glWindowPos3dv := gl_GetProc('glWindowPos3dv');
    glWindowPos3f := gl_GetProc('glWindowPos3f');
    glWindowPos3fv := gl_GetProc('glWindowPos3fv');
    glWindowPos3i := gl_GetProc('glWindowPos3i');
    glWindowPos3iv := gl_GetProc('glWindowPos3iv');
    glWindowPos3s := gl_GetProc('glWindowPos3s');
    glWindowPos3sv := gl_GetProc('glWindowPos3sv');
    {$EndIf}
  end;
  {$EndIf}

  {$IfDef GL_VERSION_1_5}
  if GL_VERSION_1_5 then
  begin
    glGenQueries := gl_GetProc('glGenQueries');
    glDeleteQueries := gl_GetProc('glDeleteQueries');
    glIsQuery := gl_GetProc('glIsQuery');
    glBeginQuery := gl_GetProc('glBeginQuery');
    glEndQuery := gl_GetProc('glEndQuery');
    glGetQueryiv := gl_GetProc('glGetQueryiv');
    glGetQueryObjectiv := gl_GetProc('glGetQueryObjectiv');
    glGetQueryObjectuiv := gl_GetProc('glGetQueryObjectuiv');
    glBindBuffer := gl_GetProc('glBindBuffer');
    glDeleteBuffers := gl_GetProc('glDeleteBuffers');
    glGenBuffers := gl_GetProc('glGenBuffers');
    glIsBuffer := gl_GetProc('glIsBuffer');
    glBufferData := gl_GetProc('glBufferData');
    glBufferSubData := gl_GetProc('glBufferSubData');
    glGetBufferSubData := gl_GetProc('glGetBufferSubData');
    glMapBuffer := gl_GetProc('glMapBuffer');
    glUnmapBuffer := gl_GetProc('glUnmapBuffer');
    glGetBufferParameteriv := gl_GetProc('glGetBufferParameteriv');
    glGetBufferPointerv := gl_GetProc('glGetBufferPointerv');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_2_0}
  if GL_VERSION_2_0 then
  begin
    glBlendEquationSeparate := gl_GetProc('glBlendEquationSeparate');
    glDrawBuffers := gl_GetProc('glDrawBuffers');
    glStencilOpSeparate := gl_GetProc('glStencilOpSeparate');
    glStencilFuncSeparate := gl_GetProc('glStencilFuncSeparate');
    glStencilMaskSeparate := gl_GetProc('glStencilMaskSeparate');
    glAttachShader := gl_GetProc('glAttachShader');
    glBindAttribLocation := gl_GetProc('glBindAttribLocation');
    glCompileShader := gl_GetProc('glCompileShader');
    glCreateProgram := gl_GetProc('glCreateProgram');
    glCreateShader := gl_GetProc('glCreateShader');
    glDeleteProgram := gl_GetProc('glDeleteProgram');
    glDeleteShader := gl_GetProc('glDeleteShader');
    glDetachShader := gl_GetProc('glDetachShader');
    glDisableVertexAttribArray := gl_GetProc('glDisableVertexAttribArray');
    glEnableVertexAttribArray := gl_GetProc('glEnableVertexAttribArray');
    glGetActiveAttrib := gl_GetProc('glGetActiveAttrib');
    glGetActiveUniform := gl_GetProc('glGetActiveUniform');
    glGetAttachedShaders := gl_GetProc('glGetAttachedShaders');
    glGetAttribLocation := gl_GetProc('glGetAttribLocation');
    glGetProgramiv := gl_GetProc('glGetProgramiv');
    glGetProgramInfoLog := gl_GetProc('glGetProgramInfoLog');
    glGetShaderiv := gl_GetProc('glGetShaderiv');
    glGetShaderInfoLog := gl_GetProc('glGetShaderInfoLog');
    glGetShaderSource := gl_GetProc('glGetShaderSource');
    glGetUniformLocation := gl_GetProc('glGetUniformLocation');
    glGetUniformfv := gl_GetProc('glGetUniformfv');
    glGetUniformiv := gl_GetProc('glGetUniformiv');
    glGetVertexAttribdv := gl_GetProc('glGetVertexAttribdv');
    glGetVertexAttribfv := gl_GetProc('glGetVertexAttribfv');
    glGetVertexAttribiv := gl_GetProc('glGetVertexAttribiv');
    glGetVertexAttribPointerv := gl_GetProc('glGetVertexAttribPointerv');
    glIsProgram := gl_GetProc('glIsProgram');
    glIsShader := gl_GetProc('glIsShader');
    glLinkProgram := gl_GetProc('glLinkProgram');
    glShaderSource := gl_GetProc('glShaderSource');
    glUseProgram := gl_GetProc('glUseProgram');
    glUniform1f := gl_GetProc('glUniform1f');
    glUniform2f := gl_GetProc('glUniform2f');
    glUniform3f := gl_GetProc('glUniform3f');
    glUniform4f := gl_GetProc('glUniform4f');
    glUniform1i := gl_GetProc('glUniform1i');
    glUniform2i := gl_GetProc('glUniform2i');
    glUniform3i := gl_GetProc('glUniform3i');
    glUniform4i := gl_GetProc('glUniform4i');
    glUniform1fv := gl_GetProc('glUniform1fv');
    glUniform2fv := gl_GetProc('glUniform2fv');
    glUniform3fv := gl_GetProc('glUniform3fv');
    glUniform4fv := gl_GetProc('glUniform4fv');
    glUniform1iv := gl_GetProc('glUniform1iv');
    glUniform2iv := gl_GetProc('glUniform2iv');
    glUniform3iv := gl_GetProc('glUniform3iv');
    glUniform4iv := gl_GetProc('glUniform4iv');
    glUniformMatrix2fv := gl_GetProc('glUniformMatrix2fv');
    glUniformMatrix3fv := gl_GetProc('glUniformMatrix3fv');
    glUniformMatrix4fv := gl_GetProc('glUniformMatrix4fv');
    glValidateProgram := gl_GetProc('glValidateProgram');
    glVertexAttrib1d := gl_GetProc('glVertexAttrib1d');
    glVertexAttrib1dv := gl_GetProc('glVertexAttrib1dv');
    glVertexAttrib1f := gl_GetProc('glVertexAttrib1f');
    glVertexAttrib1fv := gl_GetProc('glVertexAttrib1fv');
    glVertexAttrib1s := gl_GetProc('glVertexAttrib1s');
    glVertexAttrib1sv := gl_GetProc('glVertexAttrib1sv');
    glVertexAttrib2d := gl_GetProc('glVertexAttrib2d');
    glVertexAttrib2dv := gl_GetProc('glVertexAttrib2dv');
    glVertexAttrib2f := gl_GetProc('glVertexAttrib2f');
    glVertexAttrib2fv := gl_GetProc('glVertexAttrib2fv');
    glVertexAttrib2s := gl_GetProc('glVertexAttrib2s');
    glVertexAttrib2sv := gl_GetProc('glVertexAttrib2sv');
    glVertexAttrib3d := gl_GetProc('glVertexAttrib3d');
    glVertexAttrib3dv := gl_GetProc('glVertexAttrib3dv');
    glVertexAttrib3f := gl_GetProc('glVertexAttrib3f');
    glVertexAttrib3fv := gl_GetProc('glVertexAttrib3f');
    glVertexAttrib3s := gl_GetProc('glVertexAttrib3s');
    glVertexAttrib3sv := gl_GetProc('glVertexAttrib3sv');
    glVertexAttrib4Nbv := gl_GetProc('glVertexAttrib4Nbv');
    glVertexAttrib4Niv := gl_GetProc('glVertexAttrib4Niv');
    glVertexAttrib4Nsv := gl_GetProc('glVertexAttrib4Nsv');
    glVertexAttrib4Nub := gl_GetProc('glVertexAttrib4Nub');
    glVertexAttrib4Nubv := gl_GetProc('glVertexAttrib4Nubv');
    glVertexAttrib4Nuiv := gl_GetProc('glVertexAttrib4Nuiv');
    glVertexAttrib4Nusv := gl_GetProc('glVertexAttrib4Nusv');
    glVertexAttrib4bv := gl_GetProc('glVertexAttrib4bv');
    glVertexAttrib4d := gl_GetProc('glVertexAttrib4d');
    glVertexAttrib4dv := gl_GetProc('glVertexAttrib4dv');
    glVertexAttrib4f := gl_GetProc('glVertexAttrib4f');
    glVertexAttrib4fv := gl_GetProc('glVertexAttrib4fv');
    glVertexAttrib4iv := gl_GetProc('glVertexAttrib4iv');
    glVertexAttrib4s := gl_GetProc('glVertexAttrib4s');
    glVertexAttrib4sv := gl_GetProc('glVertexAttrib4sv');
    glVertexAttrib4ubv := gl_GetProc('glVertexAttrib4ubv');
    glVertexAttrib4uiv := gl_GetProc('glVertexAttrib4uiv');
    glVertexAttrib4usv := gl_GetProc('glVertexAttrib4usv');
    glVertexAttribPointer := gl_GetProc('glVertexAttribPointer');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_2_1}
  if GL_VERSION_2_1 then
  begin
    glUniformMatrix2x3fv := gl_GetProc('glUniformMatrix2x3fv');
    glUniformMatrix3x2fv := gl_GetProc('glUniformMatrix3x2fv');
    glUniformMatrix2x4fv := gl_GetProc('glUniformMatrix2x4fv');
    glUniformMatrix4x2fv := gl_GetProc('glUniformMatrix4x2fv');
    glUniformMatrix3x4fv := gl_GetProc('glUniformMatrix3x4fv');
    glUniformMatrix4x3fv := gl_GetProc('glUniformMatrix4x3fv');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_3_0}
  if GL_VERSION_3_0 then
  begin
    glColorMaski := gl_GetProc('glColorMaski');
    glGetBooleani_v := gl_GetProc('glGetBooleani_v');
    glGetIntegeri_v := gl_GetProc('glGetIntegeri_v');
    glEnablei := gl_GetProc('glEnablei');
    glDisablei := gl_GetProc('glDisablei');
    glIsEnabledi := gl_GetProc('glIsEnabledi');
    glBeginTransformFeedback := gl_GetProc('glBeginTransformFeedback');
    glEndTransformFeedback := gl_GetProc('glEndTransformFeedback');
    glBindBufferRange := gl_GetProc('glBindBufferRange');
    glBindBufferBase := gl_GetProc('glBindBufferBase');
    glTransformFeedbackVaryings := gl_GetProc('glTransformFeedbackVaryings');
    glGetTransformFeedbackVarying := gl_GetProc('glGetTransformFeedbackVarying');
    glClampColor := gl_GetProc('glClampColor');
    glBeginConditionalRender := gl_GetProc('glBeginConditionalRender');
    glEndConditionalRender := gl_GetProc('glEndConditionalRender');
    glVertexAttribIPointer := gl_GetProc('glVertexAttribIPointer');
    glGetVertexAttribIiv := gl_GetProc('glGetVertexAttribIiv');
    glGetVertexAttribIuiv := gl_GetProc('glGetVertexAttribIuiv');
    glVertexAttribI1i := gl_GetProc('glVertexAttribI1i');
    glVertexAttribI2i := gl_GetProc('glVertexAttribI2i');
    glVertexAttribI3i := gl_GetProc('glVertexAttribI3i');
    glVertexAttribI4i := gl_GetProc('glVertexAttribI4i');
    glVertexAttribI1ui := gl_GetProc('glVertexAttribI1ui');
    glVertexAttribI2ui := gl_GetProc('glVertexAttribI2ui');
    glVertexAttribI3ui := gl_GetProc('glVertexAttribI3ui');
    glVertexAttribI4ui := gl_GetProc('glVertexAttribI4ui');
    glVertexAttribI1iv := gl_GetProc('glVertexAttribI1iv');
    glVertexAttribI2iv := gl_GetProc('glVertexAttribI2iv');
    glVertexAttribI3iv := gl_GetProc('glVertexAttribI3iv');
    glVertexAttribI4iv := gl_GetProc('glVertexAttribI4iv');
    glVertexAttribI1uiv := gl_GetProc('glVertexAttribI1uiv');
    glVertexAttribI2uiv := gl_GetProc('glVertexAttribI2uiv');
    glVertexAttribI3uiv := gl_GetProc('glVertexAttribI3uiv');
    glVertexAttribI4uiv := gl_GetProc('glVertexAttribI4uiv');
    glVertexAttribI4bv := gl_GetProc('glVertexAttribI4bv');
    glVertexAttribI4sv := gl_GetProc('glVertexAttribI4sv');
    glVertexAttribI4ubv := gl_GetProc('glVertexAttribI4ubv');
    glVertexAttribI4usv := gl_GetProc('glVertexAttribI4usv');
    glGetUniformuiv := gl_GetProc('glGetUniformuiv');
    glBindFragDataLocation := gl_GetProc('glBindFragDataLocation');
    glGetFragDataLocation := gl_GetProc('glGetFragDataLocation');
    glUniform1ui := gl_GetProc('glUniform1ui');
    glUniform2ui := gl_GetProc('glUniform2ui');
    glUniform3ui := gl_GetProc('glUniform3ui');
    glUniform4ui := gl_GetProc('glUniform4ui');
    glUniform1uiv := gl_GetProc('glUniform1uiv');
    glUniform2uiv := gl_GetProc('glUniform2uiv');
    glUniform3uiv := gl_GetProc('glUniform3uiv');
    glUniform4uiv := gl_GetProc('glUniform4uiv');
    glTexParameterIiv := gl_GetProc('glTexParameterIiv');
    glTexParameterIuiv := gl_GetProc('glTexParameterIuiv');
    glGetTexParameterIiv := gl_GetProc('glGetTexParameterIiv');
    glGetTexParameterIuiv := gl_GetProc('glGetTexParameterIuiv');
    glClearBufferiv := gl_GetProc('glClearBufferiv');
    glClearBufferuiv := gl_GetProc('glClearBufferuiv');
    glClearBufferfv := gl_GetProc('glClearBufferfv');
    glClearBufferfi := gl_GetProc('glClearBufferfi');
    glGetStringi := gl_GetProc('glGetStringi');
//    glIsRenderbuffer := gl_GetProc('glIsRenderbuffer');
//    glBindRenderbuffer := gl_GetProc('glBindRenderbuffer');
//    glDeleteRenderbuffers := gl_GetProc('glDeleteRenderbuffers');
//    glGenRenderbuffers := gl_GetProc('glGenRenderbuffers');
//    glRenderbufferStorage := gl_GetProc('glRenderbufferStorage');
    glGetRenderbufferParameteriv := gl_GetProc('glGetRenderbufferParameteriv');
//    glIsFramebuffer := gl_GetProc('glIsFramebuffer');
//    glBindFramebuffer := gl_GetProc('glBindFramebuffer');
//    glDeleteFramebuffers := gl_GetProc('glDeleteFramebuffers');
//    glGenFramebuffers := gl_GetProc('glGenFramebuffers');
//    glCheckFramebufferStatus := gl_GetProc('glCheckFramebufferStatus');
    glFramebufferTexture1D := gl_GetProc('glFramebufferTexture1D');
//    glFramebufferTexture2D := gl_GetProc('glFramebufferTexture2D');
    glFramebufferTexture3D := gl_GetProc('glFramebufferTexture3D');
//    glFramebufferRenderbuffer := gl_GetProc('glFramebufferRenderbuffer');
    glGetFramebufferAttachmentParameteriv := gl_GetProc('glGetFramebufferAttachmentParameteriv');
    glGenerateMipmap := gl_GetProc('glGenerateMipmap');
    glBlitFramebuffer := gl_GetProc('glBlitFramebuffer');
    glRenderbufferStorageMultisample := gl_GetProc('glRenderbufferStorageMultisample');
    glFramebufferTextureLayer := gl_GetProc('glFramebufferTextureLayer');
    glMapBufferRange := gl_GetProc('glMapBufferRange');
    glFlushMappedBufferRange := gl_GetProc('glFlushMappedBufferRange');
    glBindVertexArray := gl_GetProc('glBindVertexArray');
    glDeleteVertexArrays := gl_GetProc('glDeleteVertexArrays');
    glGenVertexArrays := gl_GetProc('glGenVertexArrays');
    glIsVertexArray := gl_GetProc('glIsVertexArray');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_3_1}
  if GL_VERSION_3_1 then
  begin
    glDrawArraysInstanced := gl_GetProc('glDrawArraysInstanced');
    glDrawElementsInstanced := gl_GetProc('glDrawElementsInstanced');
    glTexBuffer := gl_GetProc('glTexBuffer');
    glPrimitiveRestartIndex := gl_GetProc('glPrimitiveRestartIndex');
    glCopyBufferSubData := gl_GetProc('glCopyBufferSubData');
    glGetUniformIndices := gl_GetProc('glGetUniformIndices');
    glGetActiveUniformsiv := gl_GetProc('glGetActiveUniformsiv');
    glGetActiveUniformName := gl_GetProc('glGetActiveUniformName');
    glGetUniformBlockIndex := gl_GetProc('glGetUniformBlockIndex');
    glGetActiveUniformBlockiv := gl_GetProc('glGetActiveUniformBlockiv');
    glGetActiveUniformBlockName := gl_GetProc('glGetActiveUniformBlockName');
    glUniformBlockBinding := gl_GetProc('glUniformBlockBinding');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_3_2}
  if GL_VERSION_3_2 then
  begin
    glDrawElementsBaseVertex := gl_GetProc('glDrawElementsBaseVertex');
    glDrawRangeElementsBaseVertex := gl_GetProc('glDrawRangeElementsBaseVertex');
    glDrawElementsInstancedBaseVertex := gl_GetProc('glDrawElementsInstancedBaseVertex');
    glMultiDrawElementsBaseVertex := gl_GetProc('glMultiDrawElementsBaseVertex');
    glProvokingVertex := gl_GetProc('glProvokingVertex');
    glFenceSync := gl_GetProc('glFenceSync');
    glIsSync := gl_GetProc('glIsSync');
    glDeleteSync := gl_GetProc('glDeleteSync');
    glClientWaitSync := gl_GetProc('glClientWaitSync');
    glWaitSync := gl_GetProc('glWaitSync');
    glGetInteger64v := gl_GetProc('glGetInteger64v');
    glGetSynciv := gl_GetProc('glGetSynciv');
    glGetInteger64i_v := gl_GetProc('glGetInteger64i_v');
    glGetBufferParameteri64v := gl_GetProc('glGetBufferParameteri64v');
    glFramebufferTexture := gl_GetProc('glFramebufferTexture');
    glTexImage2DMultisample := gl_GetProc('glTexImage2DMultisample');
    glTexImage3DMultisample := gl_GetProc('glTexImage3DMultisample');
    glGetMultisamplefv := gl_GetProc('glGetMultisamplefv');
    glSampleMaski := gl_GetProc('glSampleMaski');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_3_3}
  if GL_VERSION_3_3 then
  begin
    glBindFragDataLocationIndexed := gl_GetProc('glBindFragDataLocationIndexed');
    glGetFragDataIndex := gl_GetProc('glGetFragDataIndex');
    glGenSamplers := gl_GetProc('glGenSamplers');
    glDeleteSamplers := gl_GetProc('glDeleteSamplers');
    glIsSampler := gl_GetProc('glIsSampler');
    glBindSampler := gl_GetProc('glBindSampler');
    glSamplerParameteri := gl_GetProc('glSamplerParameteri');
    glSamplerParameteriv := gl_GetProc('glSamplerParameteriv');
    glSamplerParameterf := gl_GetProc('glSamplerParameterf');
    glSamplerParameterfv := gl_GetProc('glSamplerParameterfv');
    glSamplerParameterIiv := gl_GetProc('glSamplerParameterIiv');
    glSamplerParameterIuiv := gl_GetProc('glSamplerParameterIuiv');
    glGetSamplerParameteriv := gl_GetProc('glGetSamplerParameteriv');
    glGetSamplerParameterIiv := gl_GetProc('glGetSamplerParameterIiv');
    glGetSamplerParameterfv := gl_GetProc('glGetSamplerParameterfv');
    glGetSamplerParameterIuiv := gl_GetProc('glGetSamplerParameterIuiv');
    glQueryCounter := gl_GetProc('glQueryCounter');
    glGetQueryObjecti64v := gl_GetProc('glGetQueryObjecti64v');
    glGetQueryObjectui64v := gl_GetProc('glGetQueryObjectui64v');
    glVertexAttribDivisor := gl_GetProc('glVertexAttribDivisor');
    glVertexAttribP1ui := gl_GetProc('glVertexAttribP1ui');
    glVertexAttribP1uiv := gl_GetProc('glVertexAttribP1uiv');
    glVertexAttribP2ui := gl_GetProc('glVertexAttribP2ui');
    glVertexAttribP2uiv := gl_GetProc('glVertexAttribP2uiv');
    glVertexAttribP3ui := gl_GetProc('glVertexAttribP3ui');
    glVertexAttribP3uiv := gl_GetProc('glVertexAttribP3uiv');
    glVertexAttribP4ui := gl_GetProc('glVertexAttribP4ui');
    glVertexAttribP4uiv := gl_GetProc('glVertexAttribP4uiv');
    {$IfNDef USE_GLCORE}
    glVertexP2ui := gl_GetProc('glVertexP2ui');
    glVertexP2uiv := gl_GetProc('glVertexP2uiv');
    glVertexP3ui := gl_GetProc('glVertexP3ui');
    glVertexP3uiv := gl_GetProc('glVertexP3uiv');
    glVertexP4ui := gl_GetProc('glVertexP4ui');
    glVertexP4uiv := gl_GetProc('glVertexP4uiv');
    glTexCoordP1ui := gl_GetProc('glTexCoordP1ui');
    glTexCoordP1uiv := gl_GetProc('glTexCoordP1uiv');
    glTexCoordP2ui := gl_GetProc('glTexCoordP2ui');
    glTexCoordP2uiv := gl_GetProc('glTexCoordP2uiv');
    glTexCoordP3ui := gl_GetProc('glTexCoordP3ui');
    glTexCoordP3uiv := gl_GetProc('glTexCoordP3uiv');
    glTexCoordP4ui := gl_GetProc('glTexCoordP4ui');
    glTexCoordP4uiv := gl_GetProc('glTexCoordP4uiv');
    glMultiTexCoordP1ui := gl_GetProc('glMultiTexCoordP1ui');
    glMultiTexCoordP1uiv := gl_GetProc('glMultiTexCoordP1uiv');
    glMultiTexCoordP2ui := gl_GetProc('glMultiTexCoordP2ui');
    glMultiTexCoordP2uiv := gl_GetProc('glMultiTexCoordP2uiv');
    glMultiTexCoordP3ui := gl_GetProc('glMultiTexCoordP3ui');
    glMultiTexCoordP3uiv := gl_GetProc('glMultiTexCoordP3uiv');
    glMultiTexCoordP4ui := gl_GetProc('glMultiTexCoordP4ui');
    glMultiTexCoordP4uiv := gl_GetProc('glMultiTexCoordP4uiv');
    glNormalP3ui := gl_GetProc('glNormalP3ui');
    glNormalP3uiv := gl_GetProc('glNormalP3uiv');
    glColorP3ui := gl_GetProc('glColorP3ui');
    glColorP3uiv := gl_GetProc('glColorP3uiv');
    glColorP4ui := gl_GetProc('glColorP4ui');
    glColorP4uiv := gl_GetProc('glColorP4uiv');
    glSecondaryColorP3ui := gl_GetProc('glSecondaryColorP3ui');
    glSecondaryColorP3uiv := gl_GetProc('glSecondaryColorP3uiv');
    {$EndIf}
  end;
  {$EndIf}

  {$IfDef GL_VERSION_4_0}
  if GL_VERSION_4_0 then
  begin
    glMinSampleShading := gl_GetProc('glMinSampleShading');
    glBlendEquationi := gl_GetProc('glBlendEquationi');
    glBlendEquationSeparatei := gl_GetProc('glBlendEquationSeparatei');
    glBlendFunci := gl_GetProc('glBlendFunci');
    glBlendFuncSeparatei := gl_GetProc('glBlendFuncSeparatei');
    glDrawArraysIndirect := gl_GetProc('glDrawArraysIndirect');
    glDrawElementsIndirect := gl_GetProc('glDrawElementsIndirect');
    glUniform1d := gl_GetProc('glUniform1d');
    glUniform2d := gl_GetProc('glUniform2d');
    glUniform3d := gl_GetProc('glUniform3d');
    glUniform4d := gl_GetProc('glUniform4d');
    glUniform1dv := gl_GetProc('glUniform1dv');
    glUniform2dv := gl_GetProc('glUniform2dv');
    glUniform3dv := gl_GetProc('glUniform3dv');
    glUniform4dv := gl_GetProc('glUniform4dv');
    glUniformMatrix2dv := gl_GetProc('glUniformMatrix2dv');
    glUniformMatrix3dv := gl_GetProc('glUniformMatrix3dv');
    glUniformMatrix4dv := gl_GetProc('glUniformMatrix4dv');
    glUniformMatrix2x3dv := gl_GetProc('glUniformMatrix2x3dv');
    glUniformMatrix2x4dv := gl_GetProc('glUniformMatrix2x4dv');
    glUniformMatrix3x2dv := gl_GetProc('glUniformMatrix3x2dv');
    glUniformMatrix3x4dv := gl_GetProc('glUniformMatrix3x4dv');
    glUniformMatrix4x2dv := gl_GetProc('glUniformMatrix4x2dv');
    glUniformMatrix4x3dv := gl_GetProc('glUniformMatrix4x3dv');
    glGetUniformdv := gl_GetProc('glGetUniformdv');
    glGetSubroutineUniformLocation := gl_GetProc('glGetSubroutineUniformLocation');
    glGetSubroutineIndex := gl_GetProc('glGetSubroutineIndex');
    glGetActiveSubroutineUniformiv := gl_GetProc('glGetActiveSubroutineUniformiv');
    glGetActiveSubroutineUniformName := gl_GetProc('glGetActiveSubroutineUniformName');
    glGetActiveSubroutineName := gl_GetProc('glGetActiveSubroutineName');
    glUniformSubroutinesuiv := gl_GetProc('glUniformSubroutinesuiv');
    glGetUniformSubroutineuiv := gl_GetProc('glGetUniformSubroutineuiv');
    glGetProgramStageiv := gl_GetProc('glGetProgramStageiv');
    glPatchParameteri := gl_GetProc('glPatchParameteri');
    glPatchParameterfv := gl_GetProc('glPatchParameterfv');
    glBindTransformFeedback := gl_GetProc('glBindTransformFeedback');
    glDeleteTransformFeedbacks := gl_GetProc('glDeleteTransformFeedbacks');
    glGenTransformFeedbacks := gl_GetProc('glGenTransformFeedbacks');
    glIsTransformFeedback := gl_GetProc('glIsTransformFeedback');
    glPauseTransformFeedback := gl_GetProc('glPauseTransformFeedback');
    glResumeTransformFeedback := gl_GetProc('glResumeTransformFeedback');
    glDrawTransformFeedback := gl_GetProc('glDrawTransformFeedback');
    glDrawTransformFeedbackStream := gl_GetProc('glDrawTransformFeedbackStream');
    glBeginQueryIndexed := gl_GetProc('glBeginQueryIndexed');
    glEndQueryIndexed := gl_GetProc('glEndQueryIndexed');
    glGetQueryIndexediv := gl_GetProc('glGetQueryIndexediv');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_4_1}
  if GL_VERSION_4_1 then
  begin
    glReleaseShaderCompiler := gl_GetProc('glReleaseShaderCompiler');
    glShaderBinary := gl_GetProc('glShaderBinary');
    glGetShaderPrecisionFormat := gl_GetProc('glGetShaderPrecisionFormat');
    glDepthRangef := gl_GetProc('glDepthRangef');
    glClearDepthf := gl_GetProc('glClearDepthf');
    glGetProgramBinary := gl_GetProc('glGetProgramBinary');
    glProgramBinary := gl_GetProc('glProgramBinary');
    glProgramParameteri := gl_GetProc('glProgramParameteri');
    glUseProgramStages := gl_GetProc('glUseProgramStages');
    glActiveShaderProgram := gl_GetProc('glActiveShaderProgram');
    glCreateShaderProgramv := gl_GetProc('glCreateShaderProgramv');
    glBindProgramPipeline := gl_GetProc('glBindProgramPipeline');
    glDeleteProgramPipelines := gl_GetProc('glDeleteProgramPipelines');
    glGenProgramPipelines := gl_GetProc('glGenProgramPipelines');
    glIsProgramPipeline := gl_GetProc('glIsProgramPipeline');
    glGetProgramPipelineiv := gl_GetProc('glGetProgramPipelineiv');
    glProgramUniform1i := gl_GetProc('glProgramUniform1i');
    glProgramUniform1iv := gl_GetProc('glProgramUniform1iv');
    glProgramUniform1f := gl_GetProc('glProgramUniform1f');
    glProgramUniform1fv := gl_GetProc('glProgramUniform1fv');
    glProgramUniform1d := gl_GetProc('glProgramUniform1d');
    glProgramUniform1dv := gl_GetProc('glProgramUniform1dv');
    glProgramUniform1ui := gl_GetProc('glProgramUniform1ui');
    glProgramUniform1uiv := gl_GetProc('glProgramUniform1uiv');
    glProgramUniform2i := gl_GetProc('glProgramUniform2i');
    glProgramUniform2iv := gl_GetProc('glProgramUniform2iv');
    glProgramUniform2f := gl_GetProc('glProgramUniform2f');
    glProgramUniform2fv := gl_GetProc('glProgramUniform2fv');
    glProgramUniform2d := gl_GetProc('glProgramUniform2d');
    glProgramUniform2dv := gl_GetProc('glProgramUniform2dv');
    glProgramUniform2ui := gl_GetProc('glProgramUniform2ui');
    glProgramUniform2uiv := gl_GetProc('glProgramUniform2uiv');
    glProgramUniform3i := gl_GetProc('glProgramUniform3i');
    glProgramUniform3iv := gl_GetProc('glProgramUniform3iv');
    glProgramUniform3f := gl_GetProc('glProgramUniform3f');
    glProgramUniform3fv := gl_GetProc('glProgramUniform3fv');
    glProgramUniform3d := gl_GetProc('glProgramUniform3d');
    glProgramUniform3dv := gl_GetProc('glProgramUniform3dv');
    glProgramUniform3ui := gl_GetProc('glProgramUniform3ui');
    glProgramUniform3uiv := gl_GetProc('glProgramUniform3uiv');
    glProgramUniform4i := gl_GetProc('glProgramUniform4i');
    glProgramUniform4iv := gl_GetProc('glProgramUniform4iv');
    glProgramUniform4f := gl_GetProc('glProgramUniform4f');
    glProgramUniform4fv := gl_GetProc('glProgramUniform4fv');
    glProgramUniform4d := gl_GetProc('glProgramUniform4d');
    glProgramUniform4dv := gl_GetProc('glProgramUniform4dv');
    glProgramUniform4ui := gl_GetProc('glProgramUniform4ui');
    glProgramUniform4uiv := gl_GetProc('glProgramUniform4uiv');
    glProgramUniformMatrix2fv := gl_GetProc('glProgramUniformMatrix2fv');
    glProgramUniformMatrix3fv := gl_GetProc('glProgramUniformMatrix3fv');
    glProgramUniformMatrix4fv := gl_GetProc('glProgramUniformMatrix4fv');
    glProgramUniformMatrix2dv := gl_GetProc('glProgramUniformMatrix2dv');
    glProgramUniformMatrix3dv := gl_GetProc('glProgramUniformMatrix3dv');
    glProgramUniformMatrix4dv := gl_GetProc('glProgramUniformMatrix4dv');
    glProgramUniformMatrix2x3fv := gl_GetProc('glProgramUniformMatrix2x3fv');
    glProgramUniformMatrix3x2fv := gl_GetProc('glProgramUniformMatrix3x2fv');
    glProgramUniformMatrix2x4fv := gl_GetProc('glProgramUniformMatrix2x4fv');
    glProgramUniformMatrix4x2fv := gl_GetProc('glProgramUniformMatrix4x2fv');
    glProgramUniformMatrix3x4fv := gl_GetProc('glProgramUniformMatrix3x4fv');
    glProgramUniformMatrix4x3fv := gl_GetProc('glProgramUniformMatrix4x3fv');
    glProgramUniformMatrix2x3dv := gl_GetProc('glProgramUniformMatrix2x3dv');
    glProgramUniformMatrix3x2dv := gl_GetProc('glProgramUniformMatrix3x2dv');
    glProgramUniformMatrix2x4dv := gl_GetProc('glProgramUniformMatrix2x4dv');
    glProgramUniformMatrix4x2dv := gl_GetProc('glProgramUniformMatrix4x2dv');
    glProgramUniformMatrix3x4dv := gl_GetProc('glProgramUniformMatrix3x4dv');
    glProgramUniformMatrix4x3dv := gl_GetProc('glProgramUniformMatrix4x3dv');
    glValidateProgramPipeline := gl_GetProc('glValidateProgramPipeline');
    glGetProgramPipelineInfoLog := gl_GetProc('glGetProgramPipelineInfoLog');
    glVertexAttribL1d := gl_GetProc('glVertexAttribL1d');
    glVertexAttribL2d := gl_GetProc('glVertexAttribL2d');
    glVertexAttribL3d := gl_GetProc('glVertexAttribL3d');
    glVertexAttribL4d := gl_GetProc('glVertexAttribL4d');
    glVertexAttribL1dv := gl_GetProc('glVertexAttribL1dv');
    glVertexAttribL2dv := gl_GetProc('glVertexAttribL2dv');
    glVertexAttribL3dv := gl_GetProc('glVertexAttribL3dv');
    glVertexAttribL4dv := gl_GetProc('glVertexAttribL4dv');
    glVertexAttribLPointer := gl_GetProc('glVertexAttribLPointer');
    glGetVertexAttribLdv := gl_GetProc('glGetVertexAttribLdv');
    glViewportArrayv := gl_GetProc('glViewportArrayv');
    glViewportIndexedf := gl_GetProc('glViewportIndexedf');
    glViewportIndexedfv := gl_GetProc('glViewportIndexedfv');
    glScissorArrayv := gl_GetProc('glScissorArrayv');
    glScissorIndexed := gl_GetProc('glScissorIndexed');
    glScissorIndexedv := gl_GetProc('glScissorIndexedv');
    glDepthRangeArrayv := gl_GetProc('glDepthRangeArrayv');
    glDepthRangeIndexed := gl_GetProc('glDepthRangeIndexed');
    glGetFloati_v := gl_GetProc('glGetFloati_v');
    glGetDoublei_v := gl_GetProc('glGetDoublei_v');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_4_2}
  if GL_VERSION_4_2 then
  begin
    glDrawArraysInstancedBaseInstance := gl_GetProc('glDrawArraysInstancedBaseInstance');
    glDrawElementsInstancedBaseInstance := gl_GetProc('glDrawElementsInstancedBaseInstance');
    glDrawElementsInstancedBaseVertexBaseInstance := gl_GetProc('glDrawElementsInstancedBaseVertexBaseInstance');
    glGetInternalformativ := gl_GetProc('glGetInternalformativ');
    glGetActiveAtomicCounterBufferiv := gl_GetProc('glGetActiveAtomicCounterBufferiv');
    glBindImageTexture := gl_GetProc('glBindImageTexture');
    glMemoryBarrier := gl_GetProc('glMemoryBarrier');
    glTexStorage1D := gl_GetProc('glTexStorage1D');
    glTexStorage2D := gl_GetProc('glTexStorage2D');
    glTexStorage3D := gl_GetProc('glTexStorage3D');
    glDrawTransformFeedbackInstanced := gl_GetProc('glDrawTransformFeedbackInstanced');
    glDrawTransformFeedbackStreamInstanced := gl_GetProc('glDrawTransformFeedbackStreamInstanced');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_4_3}
  if GL_VERSION_4_3 then
  begin
    glClearBufferData := gl_GetProc('glClearBufferData');
    glClearBufferSubData := gl_GetProc('glClearBufferSubData');
    glDispatchCompute := gl_GetProc('glDispatchCompute');
    glDispatchComputeIndirect := gl_GetProc('glDispatchComputeIndirect');
    glCopyImageSubData := gl_GetProc('glCopyImageSubData');
    glFramebufferParameteri := gl_GetProc('glFramebufferParameteri');
    glGetFramebufferParameteriv := gl_GetProc('glGetFramebufferParameteriv');
    glGetInternalformati64v := gl_GetProc('glGetInternalformati64v');
    glInvalidateTexSubImage := gl_GetProc('glInvalidateTexSubImage');
    glInvalidateTexImage := gl_GetProc('glInvalidateTexImage');
    glInvalidateBufferSubData := gl_GetProc('glInvalidateBufferSubData');
    glInvalidateBufferData := gl_GetProc('glInvalidateBufferData');
    glInvalidateFramebuffer := gl_GetProc('glInvalidateFramebuffer');
    glInvalidateSubFramebuffer := gl_GetProc('glInvalidateSubFramebuffer');
    glMultiDrawArraysIndirect := gl_GetProc('glMultiDrawArraysIndirect');
    glMultiDrawElementsIndirect := gl_GetProc('glMultiDrawElementsIndirect');
    glGetProgramInterfaceiv := gl_GetProc('glGetProgramInterfaceiv');
    glGetProgramResourceIndex := gl_GetProc('glGetProgramResourceIndex');
    glGetProgramResourceName := gl_GetProc('glGetProgramResourceName');
    glGetProgramResourceiv := gl_GetProc('glGetProgramResourceiv');
    glGetProgramResourceLocation := gl_GetProc('glGetProgramResourceLocation');
    glGetProgramResourceLocationIndex := gl_GetProc('glGetProgramResourceLocationIndex');
    glShaderStorageBlockBinding := gl_GetProc('glShaderStorageBlockBinding');
    glTexBufferRange := gl_GetProc('glTexBufferRange');
    glTexStorage2DMultisample := gl_GetProc('glTexStorage2DMultisample');
    glTexStorage3DMultisample := gl_GetProc('glTexStorage3DMultisample');
    glTextureView := gl_GetProc('glTextureView');
    glBindVertexBuffer := gl_GetProc('glBindVertexBuffer');
    glVertexAttribFormat := gl_GetProc('glVertexAttribFormat');
    glVertexAttribIFormat := gl_GetProc('glVertexAttribIFormat');
    glVertexAttribLFormat := gl_GetProc('glVertexAttribLFormat');
    glVertexAttribBinding := gl_GetProc('glVertexAttribBinding');
    glVertexBindingDivisor := gl_GetProc('glVertexBindingDivisor');
    glDebugMessageControl := gl_GetProc('glDebugMessageControl');
    glDebugMessageInsert := gl_GetProc('glDebugMessageInsert');
    glDebugMessageCallback := gl_GetProc('glDebugMessageCallback');
    glGetDebugMessageLog := gl_GetProc('glGetDebugMessageLog');
    glPushDebugGroup := gl_GetProc('glPushDebugGroup');
    glPopDebugGroup := gl_GetProc('glPopDebugGroup');
    glObjectLabel := gl_GetProc('glObjectLabel');
    glGetObjectLabel := gl_GetProc('glGetObjectLabel');
    glObjectPtrLabel := gl_GetProc('glObjectPtrLabel');
    glGetObjectPtrLabel := gl_GetProc('glGetObjectPtrLabel');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_4_4}
  if GL_VERSION_4_4 then
  begin
    glBufferStorage := gl_GetProc('glBufferStorage');
    glClearTexImage := gl_GetProc('glClearTexImage');
    glClearTexSubImage := gl_GetProc('glClearTexSubImage');
    glBindBuffersBase := gl_GetProc('glBindBuffersBase');
    glBindBuffersRange := gl_GetProc('glBindBuffersRange');
    glBindTextures := gl_GetProc('glBindTextures');
    glBindSamplers := gl_GetProc('glBindSamplers');
    glBindImageTextures := gl_GetProc('glBindImageTextures');
    glBindVertexBuffers := gl_GetProc('glBindVertexBuffers');
  end;
  {$EndIf}

  {$IfDef GL_VERSION_4_5}
  if GL_VERSION_4_5 then
  begin
    glClipControl := gl_GetProc('glClipControl');
    glCreateTransformFeedbacks := gl_GetProc('glCreateTransformFeedbacks');
    glTransformFeedbackBufferBase := gl_GetProc('glTransformFeedbackBufferBase');
    glTransformFeedbackBufferRange := gl_GetProc('glTransformFeedbackBufferRange');
    glGetTransformFeedbackiv := gl_GetProc('glGetTransformFeedbackiv');
    glGetTransformFeedbacki_v := gl_GetProc('glGetTransformFeedbacki_v');
    glGetTransformFeedbacki64_v := gl_GetProc('glGetTransformFeedbacki64_v');
    glCreateBuffers := gl_GetProc('glCreateBuffers');
    glNamedBufferStorage := gl_GetProc('glNamedBufferStorage');
    glNamedBufferData := gl_GetProc('glNamedBufferData');
    glNamedBufferSubData := gl_GetProc('glNamedBufferSubData');
    glCopyNamedBufferSubData := gl_GetProc('glCopyNamedBufferSubData');
    glClearNamedBufferData := gl_GetProc('glClearNamedBufferData');
    glClearNamedBufferSubData := gl_GetProc('glClearNamedBufferSubData');
    glMapNamedBuffer := gl_GetProc('glMapNamedBuffer');
    glMapNamedBufferRange := gl_GetProc('glMapNamedBufferRange');
    glUnmapNamedBuffer := gl_GetProc('glUnmapNamedBuffer');
    glFlushMappedNamedBufferRange := gl_GetProc('glFlushMappedNamedBufferRange');
    glGetNamedBufferParameteriv := gl_GetProc('glGetNamedBufferParameteriv');
    glGetNamedBufferParameteri64v := gl_GetProc('glGetNamedBufferParameteri64v');
    glGetNamedBufferPointerv := gl_GetProc('glGetNamedBufferPointerv');
    glGetNamedBufferSubData := gl_GetProc('glGetNamedBufferSubData');
    glCreateFramebuffers := gl_GetProc('glCreateFramebuffers');
    glNamedFramebufferRenderbuffer := gl_GetProc('glNamedFramebufferRenderbuffer');
    glNamedFramebufferParameteri := gl_GetProc('glNamedFramebufferParameteri');
    glNamedFramebufferTexture := gl_GetProc('glNamedFramebufferTexture');
    glNamedFramebufferTextureLayer := gl_GetProc('glNamedFramebufferTextureLayer');
    glNamedFramebufferDrawBuffer := gl_GetProc('glNamedFramebufferDrawBuffer');
    glNamedFramebufferDrawBuffers := gl_GetProc('glNamedFramebufferDrawBuffers');
    glNamedFramebufferReadBuffer := gl_GetProc('glNamedFramebufferReadBuffer');
    glInvalidateNamedFramebufferData := gl_GetProc('glInvalidateNamedFramebufferData');
    glInvalidateNamedFramebufferSubData := gl_GetProc('glInvalidateNamedFramebufferSubData');
    glClearNamedFramebufferiv := gl_GetProc('glClearNamedFramebufferiv');
    glClearNamedFramebufferuiv := gl_GetProc('glClearNamedFramebufferuiv');
    glClearNamedFramebufferfv := gl_GetProc('glClearNamedFramebufferfv');
    glClearNamedFramebufferfi := gl_GetProc('glClearNamedFramebufferfi');
    glBlitNamedFramebuffer := gl_GetProc('glBlitNamedFramebuffer');
    glCheckNamedFramebufferStatus := gl_GetProc('glCheckNamedFramebufferStatus');
    glGetNamedFramebufferParameteriv := gl_GetProc('glGetNamedFramebufferParameteriv');
    glGetNamedFramebufferAttachmentParameteriv := gl_GetProc('glGetNamedFramebufferAttachmentParameteriv');
    glCreateRenderbuffers := gl_GetProc('glCreateRenderbuffers');
    glNamedRenderbufferStorage := gl_GetProc('glNamedRenderbufferStorage');
    glNamedRenderbufferStorageMultisample := gl_GetProc('glNamedRenderbufferStorageMultisample');
    glGetNamedRenderbufferParameteriv := gl_GetProc('glGetNamedRenderbufferParameteriv');
    glCreateTextures := gl_GetProc('glCreateTextures');
    glTextureBuffer := gl_GetProc('glTextureBuffer');
    glTextureBufferRange := gl_GetProc('glTextureBufferRange');
    glTextureStorage1D := gl_GetProc('glTextureStorage1D');
    glTextureStorage2D := gl_GetProc('glTextureStorage2D');
    glTextureStorage3D := gl_GetProc('glTextureStorage3D');
    glTextureStorage2DMultisample := gl_GetProc('glTextureStorage2DMultisample');
    glTextureStorage3DMultisample := gl_GetProc('glTextureStorage3DMultisample');
    glTextureSubImage1D := gl_GetProc('glTextureSubImage1D');
    glTextureSubImage2D := gl_GetProc('glTextureSubImage2D');
    glTextureSubImage3D := gl_GetProc('glTextureSubImage3D');
    glCompressedTextureSubImage1D := gl_GetProc('glCompressedTextureSubImage1D');
    glCompressedTextureSubImage2D := gl_GetProc('glCompressedTextureSubImage2D');
    glCompressedTextureSubImage3D := gl_GetProc('glCompressedTextureSubImage3D');
    glCopyTextureSubImage1D := gl_GetProc('glCopyTextureSubImage1D');
    glCopyTextureSubImage2D := gl_GetProc('glCopyTextureSubImage2D');
    glCopyTextureSubImage3D := gl_GetProc('glCopyTextureSubImage3D');
    glTextureParameterf := gl_GetProc('glTextureParameterf');
    glTextureParameterfv := gl_GetProc('glTextureParameterfv');
    glTextureParameteri := gl_GetProc('glTextureParameteri');
    glTextureParameterIiv := gl_GetProc('glTextureParameterIiv');
    glTextureParameterIuiv := gl_GetProc('glTextureParameterIuiv');
    glTextureParameteriv := gl_GetProc('glTextureParameteriv');
    glGenerateTextureMipmap := gl_GetProc('glGenerateTextureMipmap');
    glBindTextureUnit := gl_GetProc('glBindTextureUnit');
    glGetTextureImage := gl_GetProc('glGetTextureImage');
    glGetCompressedTextureImage := gl_GetProc('glGetCompressedTextureImage');
    glGetTextureLevelParameterfv := gl_GetProc('glGetTextureLevelParameterfv');
    glGetTextureLevelParameteriv := gl_GetProc('glGetTextureLevelParameteriv');
    glGetTextureParameterfv := gl_GetProc('glGetTextureParameterfv');
    glGetTextureParameterIiv := gl_GetProc('glGetTextureParameterIiv');
    glGetTextureParameterIuiv := gl_GetProc('glGetTextureParameterIuiv');
    glGetTextureParameteriv := gl_GetProc('glGetTextureParameteriv');
    glCreateVertexArrays := gl_GetProc('glCreateVertexArrays');
    glDisableVertexArrayAttrib := gl_GetProc('glDisableVertexArrayAttrib');
    glEnableVertexArrayAttrib := gl_GetProc('glEnableVertexArrayAttrib');
    glVertexArrayElementBuffer := gl_GetProc('glVertexArrayElementBuffer');
    glVertexArrayVertexBuffer := gl_GetProc('glVertexArrayVertexBuffer');
    glVertexArrayVertexBuffers := gl_GetProc('glVertexArrayVertexBuffers');
    glVertexArrayAttribBinding := gl_GetProc('glVertexArrayAttribBinding');
    glVertexArrayAttribFormat := gl_GetProc('glVertexArrayAttribFormat');
    glVertexArrayAttribIFormat := gl_GetProc('glVertexArrayAttribIFormat');
    glVertexArrayAttribLFormat := gl_GetProc('glVertexArrayAttribLFormat');
    glVertexArrayBindingDivisor := gl_GetProc('glVertexArrayBindingDivisor');
    glGetVertexArrayiv := gl_GetProc('glGetVertexArrayiv');
    glGetVertexArrayIndexediv := gl_GetProc('glGetVertexArrayIndexediv');
    glGetVertexArrayIndexed64iv := gl_GetProc('glGetVertexArrayIndexed64iv');
    glCreateSamplers := gl_GetProc('glCreateSamplers');
    glCreateProgramPipelines := gl_GetProc('glCreateProgramPipelines');
    glCreateQueries := gl_GetProc('glCreateQueries');
    glGetQueryBufferObjecti64v := gl_GetProc('glGetQueryBufferObjecti64v');
    glGetQueryBufferObjectiv := gl_GetProc('glGetQueryBufferObjectiv');
    glGetQueryBufferObjectui64v := gl_GetProc('glGetQueryBufferObjectui64v');
    glGetQueryBufferObjectuiv := gl_GetProc('glGetQueryBufferObjectuiv');
    glMemoryBarrierByRegion := gl_GetProc('glMemoryBarrierByRegion');
    glGetTextureSubImage := gl_GetProc('glGetTextureSubImage');
    glGetCompressedTextureSubImage := gl_GetProc('glGetCompressedTextureSubImage');
    glGetGraphicsResetStatus := gl_GetProc('glGetGraphicsResetStatus');
    glGetnCompressedTexImage := gl_GetProc('glGetnCompressedTexImage');
    glGetnTexImage := gl_GetProc('glGetnTexImage');
    glGetnUniformdv := gl_GetProc('glGetnUniformdv');
    glGetnUniformfv := gl_GetProc('glGetnUniformfv');
    glGetnUniformiv := gl_GetProc('glGetnUniformiv');
    glGetnUniformuiv := gl_GetProc('glGetnUniformuiv');
    glReadnPixels := gl_GetProc('glReadnPixels');
    glTextureBarrier := gl_GetProc('glTextureBarrier');
    {$IfNDef USE_GLCORE}
    glGetnMapdv := gl_GetProc('glGetnMapdv');
    glGetnMapfv := gl_GetProc('glGetnMapfv');
    glGetnMapiv := gl_GetProc('glGetnMapiv');
    glGetnPixelMapfv := gl_GetProc('glGetnPixelMapfv');
    glGetnPixelMapuiv := gl_GetProc('glGetnPixelMapuiv');
    glGetnPixelMapusv := gl_GetProc('glGetnPixelMapusv');
    glGetnPolygonStipple := gl_GetProc('glGetnPolygonStipple');
    glGetnColorTable := gl_GetProc('glGetnColorTable');
    glGetnConvolutionFilter := gl_GetProc('glGetnConvolutionFilter');
    glGetnSeparableFilter := gl_GetProc('glGetnSeparableFilter');
    glGetnHistogram := gl_GetProc('glGetnHistogram');
    glGetnMinmax := gl_GetProc('glGetnMinmax');
    {$EndIf}
  end;
  {$EndIf}

  {$IfDef GL_VERSION_4_6}
  if GL_VERSION_4_6 then
  begin
    glSpecializeShader := gl_GetProc('glSpecializeShader');
    glMultiDrawArraysIndirectCount := gl_GetProc('glMultiDrawArraysIndirectCount');
    glMultiDrawElementsIndirectCount := gl_GetProc('glMultiDrawElementsIndirectCount');
    glPolygonOffsetClamp := gl_GetProc('glPolygonOffsetClamp');
  end;
  {$EndIf}

  {$IfDef GL_ARB_ES3_2_compatibility}
  if GL_ARB_ES3_2_compatibility then
    glPrimitiveBoundingBoxARB := gl_GetProc('glPrimitiveBoundingBoxARB');
  {$EndIf}

  {$IfDef GL_ARB_bindless_texture}
  if GL_ARB_bindless_texture then
  begin
    glGetTextureHandleARB := gl_GetProc('glGetTextureHandleARB');
    glGetTextureSamplerHandleARB := gl_GetProc('glGetTextureSamplerHandleARB');
    glMakeTextureHandleResidentARB := gl_GetProc('glMakeTextureHandleResidentARB');
    glMakeTextureHandleNonResidentARB := gl_GetProc('glMakeTextureHandleNonResidentARB');
    glGetImageHandleARB := gl_GetProc('glGetImageHandleARB');
    glMakeImageHandleResidentARB := gl_GetProc('glMakeImageHandleResidentARB');
    glMakeImageHandleNonResidentARB := gl_GetProc('glMakeImageHandleNonResidentARB');
    glUniformHandleui64ARB := gl_GetProc('glUniformHandleui64ARB');
    glUniformHandleui64vARB := gl_GetProc('glUniformHandleui64vARB');
    glProgramUniformHandleui64ARB := gl_GetProc('glProgramUniformHandleui64ARB');
    glProgramUniformHandleui64vARB := gl_GetProc('glProgramUniformHandleui64vARB');
    glIsTextureHandleResidentARB := gl_GetProc('glIsTextureHandleResidentARB');
    glIsImageHandleResidentARB := gl_GetProc('glIsImageHandleResidentARB');
    glVertexAttribL1ui64ARB := gl_GetProc('glVertexAttribL1ui64ARB');
    glVertexAttribL1ui64vARB := gl_GetProc('glVertexAttribL1ui64vARB');
    glGetVertexAttribLui64vARB := gl_GetProc('glGetVertexAttribLui64vARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_cl_event}
  if GL_ARB_cl_event then
    glCreateSyncFromCLeventARB := gl_GetProc('glCreateSyncFromCLeventARB');
  {$EndIf}

  {$IfDef GL_ARB_color_buffer_float}
  if GL_ARB_color_buffer_float then
    glClampColorARB := gl_GetProc('glClampColorARB');
  {$EndIf}

  {$IfDef GL_ARB_compute_variable_group_size}
  if GL_ARB_compute_variable_group_size then
    glDispatchComputeGroupSizeARB := gl_GetProc('glDispatchComputeGroupSizeARB');
  {$EndIf}

  {$IfDef GL_ARB_debug_output}
  if GL_ARB_debug_output then
  begin
    glDebugMessageControlARB := gl_GetProc('glDebugMessageControlARB');
    glDebugMessageInsertARB := gl_GetProc('glDebugMessageInsertARB');
    glDebugMessageCallbackARB := gl_GetProc('glDebugMessageCallbackARB');
    glGetDebugMessageLogARB := gl_GetProc('glGetDebugMessageLogARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_draw_buffers}
  if GL_ARB_draw_buffers then
    glDrawBuffersARB := gl_GetProc('glDrawBuffersARB');
  {$EndIf}

  {$IfDef GL_ARB_draw_buffers_blend}
  if GL_ARB_draw_buffers_blend then
  begin
    glBlendEquationiARB := gl_GetProc('glBlendEquationiARB');
    glBlendEquationSeparateiARB := gl_GetProc('glBlendEquationSeparateiARB');
    glBlendFunciARB := gl_GetProc('glBlendFunciARB');
    glBlendFuncSeparateiARB := gl_GetProc('glBlendFuncSeparateiARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_draw_instanced}
  if GL_ARB_draw_instanced then
  begin
    glDrawArraysInstancedARB := gl_GetProc('glDrawArraysInstancedARB');
    glDrawElementsInstancedARB := gl_GetProc('glDrawElementsInstancedARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_fragment_program}
  if GL_ARB_fragment_program then
  begin
    glProgramStringARB := gl_GetProc('glProgramStringARB');
    glBindProgramARB := gl_GetProc('glBindProgramARB');
    glDeleteProgramsARB := gl_GetProc('glDeleteProgramsARB');
    glGenProgramsARB := gl_GetProc('glGenProgramsARB');
    glProgramEnvParameter4dARB := gl_GetProc('glProgramEnvParameter4dARB');
    glProgramEnvParameter4dvARB := gl_GetProc('glProgramEnvParameter4dvARB');
    glProgramEnvParameter4fARB := gl_GetProc('glProgramEnvParameter4fARB');
    glProgramEnvParameter4fvARB := gl_GetProc('glProgramEnvParameter4fvARB');
    glProgramLocalParameter4dARB := gl_GetProc('glProgramLocalParameter4dARB');
    glProgramLocalParameter4dvARB := gl_GetProc('glProgramLocalParameter4dvARB');
    glProgramLocalParameter4fARB := gl_GetProc('glProgramLocalParameter4fARB');
    glProgramLocalParameter4fvARB := gl_GetProc('glProgramLocalParameter4fvARB');
    glGetProgramEnvParameterdvARB := gl_GetProc('glGetProgramEnvParameterdvARB');
    glGetProgramEnvParameterfvARB := gl_GetProc('glGetProgramEnvParameterfvARB');
    glGetProgramLocalParameterdvARB := gl_GetProc('glGetProgramLocalParameterdvARB');
    glGetProgramLocalParameterfvARB := gl_GetProc('glGetProgramLocalParameterfvARB');
    glGetProgramivARB := gl_GetProc('glGetProgramivARB');
    glGetProgramStringARB := gl_GetProc('glGetProgramStringARB');
    glIsProgramARB := gl_GetProc('glIsProgramARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_geometry_shader4}
  if GL_ARB_geometry_shader4 then
  begin
    glProgramParameteriARB := gl_GetProc('glProgramParameteriARB');
    glFramebufferTextureARB := gl_GetProc('glFramebufferTextureARB');
    glFramebufferTextureLayerARB := gl_GetProc('glFramebufferTextureLayerARB');
    glFramebufferTextureFaceARB := gl_GetProc('glFramebufferTextureFaceARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_gl_spirv}
  if GL_ARB_gl_spirv then
    glSpecializeShaderARB := gl_GetProc('glSpecializeShaderARB');
  {$EndIf}

  {$IfDef GL_ARB_gpu_shader_int64}
  if GL_ARB_gpu_shader_int64 then
  begin
    glUniform1i64ARB := gl_GetProc('glUniform1i64ARB');
    glUniform2i64ARB := gl_GetProc('glUniform2i64ARB');
    glUniform3i64ARB := gl_GetProc('glUniform3i64ARB');
    glUniform4i64ARB := gl_GetProc('glUniform4i64ARB');
    glUniform1i64vARB := gl_GetProc('glUniform1i64vARB');
    glUniform2i64vARB := gl_GetProc('glUniform2i64vARB');
    glUniform3i64vARB := gl_GetProc('glUniform3i64vARB');
    glUniform4i64vARB := gl_GetProc('glUniform4i64vARB');
    glUniform1ui64ARB := gl_GetProc('glUniform1ui64ARB');
    glUniform2ui64ARB := gl_GetProc('glUniform2ui64ARB');
    glUniform3ui64ARB := gl_GetProc('glUniform3ui64ARB');
    glUniform4ui64ARB := gl_GetProc('glUniform4ui64ARB');
    glUniform1ui64vARB := gl_GetProc('glUniform1ui64vARB');
    glUniform2ui64vARB := gl_GetProc('glUniform2ui64vARB');
    glUniform3ui64vARB := gl_GetProc('glUniform3ui64vARB');
    glUniform4ui64vARB := gl_GetProc('glUniform4ui64vARB');
    glGetUniformi64vARB := gl_GetProc('glGetUniformi64vARB');
    glGetUniformui64vARB := gl_GetProc('glGetUniformui64vARB');
    glGetnUniformi64vARB := gl_GetProc('glGetnUniformi64vARB');
    glGetnUniformui64vARB := gl_GetProc('glGetnUniformui64vARB');
    glProgramUniform1i64ARB := gl_GetProc('glProgramUniform1i64ARB');
    glProgramUniform2i64ARB := gl_GetProc('glProgramUniform2i64ARB');
    glProgramUniform3i64ARB := gl_GetProc('glProgramUniform3i64ARB');
    glProgramUniform4i64ARB := gl_GetProc('glProgramUniform4i64ARB');
    glProgramUniform1i64vARB := gl_GetProc('glProgramUniform1i64vARB');
    glProgramUniform2i64vARB := gl_GetProc('glProgramUniform2i64vARB');
    glProgramUniform3i64vARB := gl_GetProc('glProgramUniform3i64vARB');
    glProgramUniform4i64vARB := gl_GetProc('glProgramUniform4i64vARB');
    glProgramUniform1ui64ARB := gl_GetProc('glProgramUniform1ui64ARB');
    glProgramUniform2ui64ARB := gl_GetProc('glProgramUniform2ui64ARB');
    glProgramUniform3ui64ARB := gl_GetProc('glProgramUniform3ui64ARB');
    glProgramUniform4ui64ARB := gl_GetProc('glProgramUniform4ui64ARB');
    glProgramUniform1ui64vARB := gl_GetProc('glProgramUniform1ui64vARB');
    glProgramUniform2ui64vARB := gl_GetProc('glProgramUniform2ui64vARB');
    glProgramUniform3ui64vARB := gl_GetProc('glProgramUniform3ui64vARB');
    glProgramUniform4ui64vARB := gl_GetProc('glProgramUniform4ui64vARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_imaging}
  if GL_ARB_imaging then
  begin
    glColorTable := gl_GetProc('glColorTable');
    glColorTableParameterfv := gl_GetProc('glColorTableParameterfv');
    glColorTableParameteriv := gl_GetProc('glColorTableParameteriv');
    glCopyColorTable := gl_GetProc('glCopyColorTable');
    glGetColorTable := gl_GetProc('glGetColorTable');
    glGetColorTableParameterfv := gl_GetProc('glGetColorTableParameterfv');
    glGetColorTableParameteriv := gl_GetProc('glGetColorTableParameteriv');
    glColorSubTable := gl_GetProc('glColorSubTable');
    glCopyColorSubTable := gl_GetProc('glCopyColorSubTable');
    glConvolutionFilter1D := gl_GetProc('glConvolutionFilter1D');
    glConvolutionFilter2D := gl_GetProc('glConvolutionFilter2D');
    glConvolutionParameterf := gl_GetProc('glConvolutionParameterf');
    glConvolutionParameterfv := gl_GetProc('glConvolutionParameterfv');
    glConvolutionParameteri := gl_GetProc('glConvolutionParameteri');
    glConvolutionParameteriv := gl_GetProc('glConvolutionParameteriv');
    glCopyConvolutionFilter1D := gl_GetProc('glCopyConvolutionFilter1D');
    glCopyConvolutionFilter2D := gl_GetProc('glCopyConvolutionFilter2D');
    glGetConvolutionFilter := gl_GetProc('glGetConvolutionFilter');
    glGetConvolutionParameterfv := gl_GetProc('glGetConvolutionParameterfv');
    glGetConvolutionParameteriv := gl_GetProc('glGetConvolutionParameteriv');
    glGetSeparableFilter := gl_GetProc('glGetSeparableFilter');
    glSeparableFilter2D := gl_GetProc('glSeparableFilter2D');
    glGetHistogram := gl_GetProc('glGetHistogram');
    glGetHistogramParameterfv := gl_GetProc('glGetHistogramParameterfv');
    glGetHistogramParameteriv := gl_GetProc('glGetHistogramParameteriv');
    glGetMinmax := gl_GetProc('glGetMinmax');
    glGetMinmaxParameterfv := gl_GetProc('glGetMinmaxParameterfv');
    glGetMinmaxParameteriv := gl_GetProc('glGetMinmaxParameteriv');
    glHistogram := gl_GetProc('glHistogram');
    glMinmax := gl_GetProc('glMinmax');
    glResetHistogram := gl_GetProc('glResetHistogram');
    glResetMinmax := gl_GetProc('glResetMinmax');
  end;
  {$EndIf}

  {$IfDef GL_ARB_indirect_parameters}
  if GL_ARB_indirect_parameters then
  begin
    glMultiDrawArraysIndirectCountARB := gl_GetProc('glMultiDrawArraysIndirectCountARB');
    glMultiDrawElementsIndirectCountARB := gl_GetProc('glMultiDrawElementsIndirectCountARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_instanced_arrays}
  if GL_ARB_instanced_arrays then
    glVertexAttribDivisorARB := gl_GetProc('glVertexAttribDivisorARB');
  {$EndIf}

  {$IfDef GL_ARB_matrix_palette}
  if GL_ARB_matrix_palette then
  begin
    glCurrentPaletteMatrixARB := gl_GetProc('glCurrentPaletteMatrixARB');
    glMatrixIndexubvARB := gl_GetProc('glMatrixIndexubvARB');
    glMatrixIndexusvARB := gl_GetProc('glMatrixIndexusvARB');
    glMatrixIndexuivARB := gl_GetProc('glMatrixIndexuivARB');
    glMatrixIndexPointerARB := gl_GetProc('glMatrixIndexPointerARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_multisample}
  if GL_ARB_multisample then
    glSampleCoverageARB := gl_GetProc('glSampleCoverageARB');
  {$EndIf}

  {$IfDef GL_ARB_multitexture}
  if GL_ARB_multitexture then
  begin
    glActiveTextureARB := gl_GetProc('glActiveTextureARB');
    glClientActiveTextureARB := gl_GetProc('glClientActiveTextureARB');
    glMultiTexCoord1dARB := gl_GetProc('glMultiTexCoord1dARB');
    glMultiTexCoord1dvARB := gl_GetProc('glMultiTexCoord1dvARB');
    glMultiTexCoord1fARB := gl_GetProc('glMultiTexCoord1fARB');
    glMultiTexCoord1fvARB := gl_GetProc('glMultiTexCoord1fvARB');
    glMultiTexCoord1iARB := gl_GetProc('glMultiTexCoord1iARB');
    glMultiTexCoord1ivARB := gl_GetProc('glMultiTexCoord1ivARB');
    glMultiTexCoord1sARB := gl_GetProc('glMultiTexCoord1sARB');
    glMultiTexCoord1svARB := gl_GetProc('glMultiTexCoord1svARB');
    glMultiTexCoord2dARB := gl_GetProc('glMultiTexCoord2dARB');
    glMultiTexCoord2dvARB := gl_GetProc('glMultiTexCoord2dvARB');
    glMultiTexCoord2fARB := gl_GetProc('glMultiTexCoord2fARB');
    glMultiTexCoord2fvARB := gl_GetProc('glMultiTexCoord2fvARB');
    glMultiTexCoord2iARB := gl_GetProc('glMultiTexCoord2iARB');
    glMultiTexCoord2ivARB := gl_GetProc('glMultiTexCoord2ivARB');
    glMultiTexCoord2sARB := gl_GetProc('glMultiTexCoord2sARB');
    glMultiTexCoord2svARB := gl_GetProc('glMultiTexCoord2svARB');
    glMultiTexCoord3dARB := gl_GetProc('glMultiTexCoord3dARB');
    glMultiTexCoord3dvARB := gl_GetProc('glMultiTexCoord3dvARB');
    glMultiTexCoord3fARB := gl_GetProc('glMultiTexCoord3fARB');
    glMultiTexCoord3fvARB := gl_GetProc('glMultiTexCoord3fvARB');
    glMultiTexCoord3iARB := gl_GetProc('glMultiTexCoord3iARB');
    glMultiTexCoord3ivARB := gl_GetProc('glMultiTexCoord3ivARB');
    glMultiTexCoord3sARB := gl_GetProc('glMultiTexCoord3sARB');
    glMultiTexCoord3svARB := gl_GetProc('glMultiTexCoord3svARB');
    glMultiTexCoord4dARB := gl_GetProc('glMultiTexCoord4dARB');
    glMultiTexCoord4dvARB := gl_GetProc('glMultiTexCoord4dvARB');
    glMultiTexCoord4fARB := gl_GetProc('glMultiTexCoord4fARB');
    glMultiTexCoord4fvARB := gl_GetProc('glMultiTexCoord4fvARB');
    glMultiTexCoord4iARB := gl_GetProc('glMultiTexCoord4iARB');
    glMultiTexCoord4ivARB := gl_GetProc('glMultiTexCoord4ivARB');
    glMultiTexCoord4sARB := gl_GetProc('glMultiTexCoord4sARB');
    glMultiTexCoord4svARB := gl_GetProc('glMultiTexCoord4svARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_occlusion_query}
  if GL_ARB_occlusion_query then
  begin
    glGenQueriesARB := gl_GetProc('glGenQueriesARB');
    glDeleteQueriesARB := gl_GetProc('glDeleteQueriesARB');
    glIsQueryARB := gl_GetProc('glIsQueryARB');
    glBeginQueryARB := gl_GetProc('glBeginQueryARB');
    glEndQueryARB := gl_GetProc('glEndQueryARB');
    glGetQueryivARB := gl_GetProc('glGetQueryivARB');
    glGetQueryObjectivARB := gl_GetProc('glGetQueryObjectivARB');
    glGetQueryObjectuivARB := gl_GetProc('glGetQueryObjectuivARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_parallel_shader_compile}
  if GL_ARB_parallel_shader_compile then
    glMaxShaderCompilerThreadsARB := gl_GetProc('glMaxShaderCompilerThreadsARB');
  {$EndIf}

  {$IfDef GL_ARB_point_parameters}
  if GL_ARB_point_parameters then
  begin
    glPointParameterfARB := gl_GetProc('glPointParameterfARB');
    glPointParameterfvARB := gl_GetProc('glPointParameterfvARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_robustness}
  if GL_ARB_robustness then
  begin
    glGetGraphicsResetStatusARB := gl_GetProc('glGetGraphicsResetStatusARB');
    glGetnTexImageARB := gl_GetProc('glGetnTexImageARB');
    glReadnPixelsARB := gl_GetProc('glReadnPixelsARB');
    glGetnCompressedTexImageARB := gl_GetProc('glGetnCompressedTexImageARB');
    glGetnUniformfvARB := gl_GetProc('glGetnUniformfvARB');
    glGetnUniformivARB := gl_GetProc('glGetnUniformivARB');
    glGetnUniformuivARB := gl_GetProc('glGetnUniformuivARB');
    glGetnUniformdvARB := gl_GetProc('glGetnUniformdvARB');
    {$IfNDef USE_GLCORE}
    glGetnMapdvARB := gl_GetProc('glGetnMapdvARB');
    glGetnMapfvARB := gl_GetProc('glGetnMapfvARB');
    glGetnMapivARB := gl_GetProc('glGetnMapivARB');
    glGetnPixelMapfvARB := gl_GetProc('glGetnPixelMapfvARB');
    glGetnPixelMapuivARB := gl_GetProc('glGetnPixelMapuivARB');
    glGetnPixelMapusvARB := gl_GetProc('glGetnPixelMapusvARB');
    glGetnPolygonStippleARB := gl_GetProc('glGetnPolygonStippleARB');
    glGetnColorTableARB := gl_GetProc('glGetnColorTableARB');
    glGetnConvolutionFilterARB := gl_GetProc('glGetnConvolutionFilterARB');
    glGetnSeparableFilterARB := gl_GetProc('glGetnSeparableFilterARB');
    glGetnHistogramARB := gl_GetProc('glGetnHistogramARB');
    glGetnMinmaxARB := gl_GetProc('glGetnMinmaxARB');
    {$EndIf}
  end;
  {$EndIf}

  {$IfDef GL_ARB_sample_locations}
  if GL_ARB_sample_locations then
  begin
    glFramebufferSampleLocationsfvARB := gl_GetProc('glFramebufferSampleLocationsfvARB');
    glNamedFramebufferSampleLocationsfvARB := gl_GetProc('glNamedFramebufferSampleLocationsfvARB');
    glEvaluateDepthValuesARB := gl_GetProc('glEvaluateDepthValuesARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_sample_shading}
  if GL_ARB_sample_shading then
    glMinSampleShadingARB := gl_GetProc('glMinSampleShadingARB');
  {$EndIf}

  {$IfDef GL_ARB_shader_objects}
  if GL_ARB_shader_objects then
  begin
    glDeleteObjectARB := gl_GetProc('glDeleteObjectARB');
    glGetHandleARB := gl_GetProc('glGetHandleARB');
    glDetachObjectARB := gl_GetProc('glDetachObjectARB');
    glCreateShaderObjectARB := gl_GetProc('glCreateShaderObjectARB');
    glShaderSourceARB := gl_GetProc('glShaderSourceARB');
    glCompileShaderARB := gl_GetProc('glCompileShaderARB');
    glCreateProgramObjectARB := gl_GetProc('glCreateProgramObjectARB');
    glAttachObjectARB := gl_GetProc('glAttachObjectARB');
    glLinkProgramARB := gl_GetProc('glLinkProgramARB');
    glUseProgramObjectARB := gl_GetProc('glUseProgramObjectARB');
    glValidateProgramARB := gl_GetProc('glValidateProgramARB');
    glUniform1fARB := gl_GetProc('glUniform1fARB');
    glUniform2fARB := gl_GetProc('glUniform2fARB');
    glUniform3fARB := gl_GetProc('glUniform3fARB');
    glUniform4fARB := gl_GetProc('glUniform4fARB');
    glUniform1iARB := gl_GetProc('glUniform1iARB');
    glUniform2iARB := gl_GetProc('glUniform2iARB');
    glUniform3iARB := gl_GetProc('glUniform3iARB');
    glUniform4iARB := gl_GetProc('glUniform4iARB');
    glUniform1fvARB := gl_GetProc('glUniform1fvARB');
    glUniform2fvARB := gl_GetProc('glUniform2fvARB');
    glUniform3fvARB := gl_GetProc('glUniform3fvARB');
    glUniform4fvARB := gl_GetProc('glUniform4fvARB');
    glUniform1ivARB := gl_GetProc('glUniform1ivARB');
    glUniform2ivARB := gl_GetProc('glUniform2ivARB');
    glUniform3ivARB := gl_GetProc('glUniform3ivARB');
    glUniform4ivARB := gl_GetProc('glUniform4ivARB');
    glUniformMatrix2fvARB := gl_GetProc('glUniformMatrix2fvARB');
    glUniformMatrix3fvARB := gl_GetProc('glUniformMatrix3fvARB');
    glUniformMatrix4fvARB := gl_GetProc('glUniformMatrix4fvARB');
    glGetObjectParameterfvARB := gl_GetProc('glGetObjectParameterfvARB');
    glGetObjectParameterivARB := gl_GetProc('glGetObjectParameterivARB');
    glGetInfoLogARB := gl_GetProc('glGetInfoLogARB');
    glGetAttachedObjectsARB := gl_GetProc('glGetAttachedObjectsARB');
    glGetUniformLocationARB := gl_GetProc('glGetUniformLocationARB');
    glGetActiveUniformARB := gl_GetProc('glGetActiveUniformARB');
    glGetUniformfvARB := gl_GetProc('glGetUniformfvARB');
    glGetUniformivARB := gl_GetProc('glGetUniformivARB');
    glGetShaderSourceARB := gl_GetProc('glGetShaderSourceARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_shading_language_include}
  if GL_ARB_shading_language_include then
  begin
    glNamedStringARB := gl_GetProc('glNamedStringARB');
    glDeleteNamedStringARB := gl_GetProc('glDeleteNamedStringARB');
    glCompileShaderIncludeARB := gl_GetProc('glCompileShaderIncludeARB');
    glIsNamedStringARB := gl_GetProc('glIsNamedStringARB');
    glGetNamedStringARB := gl_GetProc('glGetNamedStringARB');
    glGetNamedStringivARB := gl_GetProc('glGetNamedStringivARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_sparse_buffer}
  if GL_ARB_sparse_buffer then
  begin
    glBufferPageCommitmentARB := gl_GetProc('glBufferPageCommitmentARB');
    glNamedBufferPageCommitmentEXT := gl_GetProc('glNamedBufferPageCommitmentEXT');
    glNamedBufferPageCommitmentARB := gl_GetProc('glNamedBufferPageCommitmentARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_sparse_texture}
  if GL_ARB_sparse_texture then
    glTexPageCommitmentARB := gl_GetProc('glTexPageCommitmentARB');
  {$EndIf}

  {$IfDef GL_ARB_texture_buffer_object}
  if GL_ARB_texture_buffer_object then
    glTexBufferARB := gl_GetProc('glTexBufferARB');
  {$EndIf}

  {$IfDef GL_ARB_texture_compression}
  if GL_ARB_texture_compression then
  begin
    glCompressedTexImage3DARB := gl_GetProc('glCompressedTexImage3DARB');
    glCompressedTexImage2DARB := gl_GetProc('glCompressedTexImage2DARB');
    glCompressedTexImage1DARB := gl_GetProc('glCompressedTexImage1DARB');
    glCompressedTexSubImage3DARB := gl_GetProc('glCompressedTexSubImage3DARB');
    glCompressedTexSubImage2DARB := gl_GetProc('glCompressedTexSubImage2DARB');
    glCompressedTexSubImage1DARB := gl_GetProc('glCompressedTexSubImage1DARB');
    glGetCompressedTexImageARB := gl_GetProc('glGetCompressedTexImageARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_transpose_matrix}
  if GL_ARB_transpose_matrix then
  begin
    glLoadTransposeMatrixfARB := gl_GetProc('glLoadTransposeMatrixfARB');
    glLoadTransposeMatrixdARB := gl_GetProc('glLoadTransposeMatrixdARB');
    glMultTransposeMatrixfARB := gl_GetProc('glMultTransposeMatrixfARB');
    glMultTransposeMatrixdARB := gl_GetProc('glMultTransposeMatrixdARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_vertex_blend}
  if GL_ARB_vertex_blend then
  begin
    glWeightbvARB := gl_GetProc('glWeightbvARB');
    glWeightsvARB := gl_GetProc('glWeightsvARB');
    glWeightivARB := gl_GetProc('glWeightivARB');
    glWeightfvARB := gl_GetProc('glWeightfvARB');
    glWeightdvARB := gl_GetProc('glWeightdvARB');
    glWeightubvARB := gl_GetProc('glWeightubvARB');
    glWeightusvARB := gl_GetProc('glWeightusvARB');
    glWeightuivARB := gl_GetProc('glWeightuivARB');
    glWeightPointerARB := gl_GetProc('glWeightPointerARB');
    glVertexBlendARB := gl_GetProc('glVertexBlendARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_vertex_buffer_object}
  if GL_ARB_vertex_buffer_object then
  begin
    glBindBufferARB := gl_GetProc('glBindBufferARB');
    glDeleteBuffersARB := gl_GetProc('glDeleteBuffersARB');
    glGenBuffersARB := gl_GetProc('glGenBuffersARB');
    glIsBufferARB := gl_GetProc('glIsBufferARB');
    glBufferDataARB := gl_GetProc('glBufferDataARB');
    glBufferSubDataARB := gl_GetProc('glBufferSubDataARB');
    glGetBufferSubDataARB := gl_GetProc('glGetBufferSubDataARB');
    glMapBufferARB := gl_GetProc('glMapBufferARB');
    glUnmapBufferARB := gl_GetProc('glUnmapBufferARB');
    glGetBufferParameterivARB := gl_GetProc('glGetBufferParameterivARB');
    glGetBufferPointervARB := gl_GetProc('glGetBufferPointervARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_vertex_program}
  if GL_ARB_vertex_program then
  begin
    glVertexAttrib1dARB := gl_GetProc('glVertexAttrib1dARB');
    glVertexAttrib1dvARB := gl_GetProc('glVertexAttrib1dvARB');
    glVertexAttrib1fARB := gl_GetProc('glVertexAttrib1fARB');
    glVertexAttrib1fvARB := gl_GetProc('glVertexAttrib1fvARB');
    glVertexAttrib1sARB := gl_GetProc('glVertexAttrib1sARB');
    glVertexAttrib1svARB := gl_GetProc('glVertexAttrib1svARB');
    glVertexAttrib2dARB := gl_GetProc('glVertexAttrib2dARB');
    glVertexAttrib2dvARB := gl_GetProc('glVertexAttrib2dvARB');
    glVertexAttrib2fARB := gl_GetProc('glVertexAttrib2fARB');
    glVertexAttrib2fvARB := gl_GetProc('glVertexAttrib2fvARB');
    glVertexAttrib2sARB := gl_GetProc('glVertexAttrib2sARB');
    glVertexAttrib2svARB := gl_GetProc('glVertexAttrib2svARB');
    glVertexAttrib3dARB := gl_GetProc('glVertexAttrib3dARB');
    glVertexAttrib3dvARB := gl_GetProc('glVertexAttrib3dvARB');
    glVertexAttrib3fARB := gl_GetProc('glVertexAttrib3fARB');
    glVertexAttrib3fvARB := gl_GetProc('glVertexAttrib3fvARB');
    glVertexAttrib3sARB := gl_GetProc('glVertexAttrib3sARB');
    glVertexAttrib3svARB := gl_GetProc('glVertexAttrib3svARB');
    glVertexAttrib4NbvARB := gl_GetProc('glVertexAttrib4NbvARB');
    glVertexAttrib4NivARB := gl_GetProc('glVertexAttrib4NivARB');
    glVertexAttrib4NsvARB := gl_GetProc('glVertexAttrib4NsvARB');
    glVertexAttrib4NubARB := gl_GetProc('glVertexAttrib4NubARB');
    glVertexAttrib4NubvARB := gl_GetProc('glVertexAttrib4NubvARB');
    glVertexAttrib4NuivARB := gl_GetProc('glVertexAttrib4NuivARB');
    glVertexAttrib4NusvARB := gl_GetProc('glVertexAttrib4NusvARB');
    glVertexAttrib4bvARB := gl_GetProc('glVertexAttrib4bvARB');
    glVertexAttrib4dARB := gl_GetProc('glVertexAttrib4dARB');
    glVertexAttrib4dvARB := gl_GetProc('glVertexAttrib4dvARB');
    glVertexAttrib4fARB := gl_GetProc('glVertexAttrib4fARB');
    glVertexAttrib4fvARB := gl_GetProc('glVertexAttrib4fvARB');
    glVertexAttrib4ivARB := gl_GetProc('glVertexAttrib4ivARB');
    glVertexAttrib4sARB := gl_GetProc('glVertexAttrib4sARB');
    glVertexAttrib4svARB := gl_GetProc('glVertexAttrib4svARB');
    glVertexAttrib4ubvARB := gl_GetProc('glVertexAttrib4ubvARB');
    glVertexAttrib4uivARB := gl_GetProc('glVertexAttrib4uivARB');
    glVertexAttrib4usvARB := gl_GetProc('glVertexAttrib4usvARB');
    glVertexAttribPointerARB := gl_GetProc('glVertexAttribPointerARB');
    glEnableVertexAttribArrayARB := gl_GetProc('glEnableVertexAttribArrayARB');
    glDisableVertexAttribArrayARB := gl_GetProc('glDisableVertexAttribArrayARB');
    glGetVertexAttribdvARB := gl_GetProc('glGetVertexAttribdvARB');
    glGetVertexAttribfvARB := gl_GetProc('glGetVertexAttribfvARB');
    glGetVertexAttribivARB := gl_GetProc('glGetVertexAttribivARB');
    glGetVertexAttribPointervARB := gl_GetProc('glGetVertexAttribPointervARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_vertex_shader}
  if GL_ARB_vertex_shader then
  begin
    glBindAttribLocationARB := gl_GetProc('glBindAttribLocationARB');
    glGetActiveAttribARB := gl_GetProc('glGetActiveAttribARB');
    glGetAttribLocationARB := gl_GetProc('glGetAttribLocationARB');
  end;
  {$EndIf}

  {$IfDef GL_ARB_viewport_array}
  if GL_ARB_viewport_array then
  begin
    glDepthRangeArraydvNV := gl_GetProc('glDepthRangeArraydvNV');
    glDepthRangeIndexeddNV := gl_GetProc('glDepthRangeIndexeddNV');
  end;
  {$EndIf}

  {$IfDef GL_ARB_window_pos}
  if GL_ARB_window_pos then
  begin
    glWindowPos2dARB := gl_GetProc('glWindowPos2dARB');
    glWindowPos2dvARB := gl_GetProc('glWindowPos2dvARB');
    glWindowPos2fARB := gl_GetProc('glWindowPos2fARB');
    glWindowPos2fvARB := gl_GetProc('glWindowPos2fvARB');
    glWindowPos2iARB := gl_GetProc('glWindowPos2iARB');
    glWindowPos2ivARB := gl_GetProc('glWindowPos2ivARB');
    glWindowPos2sARB := gl_GetProc('glWindowPos2sARB');
    glWindowPos2svARB := gl_GetProc('glWindowPos2svARB');
    glWindowPos3dARB := gl_GetProc('glWindowPos3dARB');
    glWindowPos3dvARB := gl_GetProc('glWindowPos3dvARB');
    glWindowPos3fARB := gl_GetProc('glWindowPos3fARB');
    glWindowPos3fvARB := gl_GetProc('glWindowPos3fvARB');
    glWindowPos3iARB := gl_GetProc('glWindowPos3iARB');
    glWindowPos3ivARB := gl_GetProc('glWindowPos3ivARB');
    glWindowPos3sARB := gl_GetProc('glWindowPos3sARB');
    glWindowPos3svARB := gl_GetProc('glWindowPos3svARB');
  end;
  {$EndIf}

  {$IfDef GL_KHR_blend_equation_advanced}
  if GL_KHR_blend_equation_advanced then
    glBlendBarrierKHR := gl_GetProc('glBlendBarrierKHR');
  {$EndIf}

  {$IfDef GL_KHR_parallel_shader_compile}
  if GL_KHR_parallel_shader_compile then
    glMaxShaderCompilerThreadsKHR := gl_GetProc('glMaxShaderCompilerThreadsKHR');
  {$EndIf}

  {$IfDef GL_OES_byte_coordinates}
  if GL_OES_byte_coordinates then
  begin
    glMultiTexCoord1bOES := gl_GetProc('glMultiTexCoord1bOES');
    glMultiTexCoord1bvOES := gl_GetProc('glMultiTexCoord1bvOES');
    glMultiTexCoord2bOES := gl_GetProc('glMultiTexCoord2bOES');
    glMultiTexCoord2bvOES := gl_GetProc('glMultiTexCoord2bvOES');
    glMultiTexCoord3bOES := gl_GetProc('glMultiTexCoord3bOES');
    glMultiTexCoord3bvOES := gl_GetProc('glMultiTexCoord3bvOES');
    glMultiTexCoord4bOES := gl_GetProc('glMultiTexCoord4bOES');
    glMultiTexCoord4bvOES := gl_GetProc('glMultiTexCoord4bvOES');
    glTexCoord1bOES := gl_GetProc('glTexCoord1bOES');
    glTexCoord1bvOES := gl_GetProc('glTexCoord1bvOES');
    glTexCoord2bOES := gl_GetProc('glTexCoord2bOES');
    glTexCoord2bvOES := gl_GetProc('glTexCoord2bvOES');
    glTexCoord3bOES := gl_GetProc('glTexCoord3bOES');
    glTexCoord3bvOES := gl_GetProc('glTexCoord3bvOES');
    glTexCoord4bOES := gl_GetProc('glTexCoord4bOES');
    glTexCoord4bvOES := gl_GetProc('glTexCoord4bvOES');
    glVertex2bOES := gl_GetProc('glVertex2bOES');
    glVertex2bvOES := gl_GetProc('glVertex2bvOES');
    glVertex3bOES := gl_GetProc('glVertex3bOES');
    glVertex3bvOES := gl_GetProc('glVertex3bvOES');
    glVertex4bOES := gl_GetProc('glVertex4bOES');
    glVertex4bvOES := gl_GetProc('glVertex4bvOES');
  end;
  {$EndIf}

  {$IfDef GL_OES_fixed_point}
  if GL_OES_fixed_point then
  begin
    glAlphaFuncxOES := gl_GetProc('glAlphaFuncxOES');
    glClearColorxOES := gl_GetProc('glClearColorxOES');
    glClearDepthxOES := gl_GetProc('glClearDepthxOES');
    glClipPlanexOES := gl_GetProc('glClipPlanexOES');
    glColor4xOES := gl_GetProc('glColor4xOES');
    glDepthRangexOES := gl_GetProc('glDepthRangexOES');
    glFogxOES := gl_GetProc('glFogxOES');
    glFogxvOES := gl_GetProc('glFogxvOES');
    glFrustumxOES := gl_GetProc('glFrustumxOES');
    glGetClipPlanexOES := gl_GetProc('glGetClipPlanexOES');
    glGetFixedvOES := gl_GetProc('glGetFixedvOES');
    glGetTexEnvxvOES := gl_GetProc('glGetTexEnvxvOES');
    glGetTexParameterxvOES := gl_GetProc('glGetTexParameterxvOES');
    glLightModelxOES := gl_GetProc('glLightModelxOES');
    glLightModelxvOES := gl_GetProc('glLightModelxvOES');
    glLightxOES := gl_GetProc('glLightxOES');
    glLightxvOES := gl_GetProc('glLightxvOES');
    glLineWidthxOES := gl_GetProc('glLineWidthxOES');
    glLoadMatrixxOES := gl_GetProc('glLoadMatrixxOES');
    glMaterialxOES := gl_GetProc('glMaterialxOES');
    glMaterialxvOES := gl_GetProc('glMaterialxvOES');
    glMultMatrixxOES := gl_GetProc('glMultMatrixxOES');
    glMultiTexCoord4xOES := gl_GetProc('glMultiTexCoord4xOES');
    glNormal3xOES := gl_GetProc('glNormal3xOES');
    glOrthoxOES := gl_GetProc('glOrthoxOES');
    glPointParameterxvOES := gl_GetProc('glPointParameterxvOES');
    glPointSizexOES := gl_GetProc('glPointSizexOES');
    glPolygonOffsetxOES := gl_GetProc('glPolygonOffsetxOES');
    glRotatexOES := gl_GetProc('glRotatexOES');
    glScalexOES := gl_GetProc('glScalexOES');
    glTexEnvxOES := gl_GetProc('glTexEnvxOES');
    glTexEnvxvOES := gl_GetProc('glTexEnvxvOES');
    glTexParameterxOES := gl_GetProc('glTexParameterxOES');
    glTexParameterxvOES := gl_GetProc('glTexParameterxvOES');
    glTranslatexOES := gl_GetProc('glTranslatexOES');
    glAccumxOES := gl_GetProc('glAccumxOES');
    glBitmapxOES := gl_GetProc('glBitmapxOES');
    glBlendColorxOES := gl_GetProc('glBlendColorxOES');
    glClearAccumxOES := gl_GetProc('glClearAccumxOES');
    glColor3xOES := gl_GetProc('glColor3xOES');
    glColor3xvOES := gl_GetProc('glColor3xvOES');
    glColor4xvOES := gl_GetProc('glColor4xvOES');
    glConvolutionParameterxOES := gl_GetProc('glConvolutionParameterxOES');
    glConvolutionParameterxvOES := gl_GetProc('glConvolutionParameterxvOES');
    glEvalCoord1xOES := gl_GetProc('glEvalCoord1xOES');
    glEvalCoord1xvOES := gl_GetProc('glEvalCoord1xvOES');
    glEvalCoord2xOES := gl_GetProc('glEvalCoord2xOES');
    glEvalCoord2xvOES := gl_GetProc('glEvalCoord2xvOES');
    glFeedbackBufferxOES := gl_GetProc('glFeedbackBufferxOES');
    glGetConvolutionParameterxvOES := gl_GetProc('glGetConvolutionParameterxvOES');
    glGetHistogramParameterxvOES := gl_GetProc('glGetHistogramParameterxvOES');
    glGetLightxOES := gl_GetProc('glGetLightxOES');
    glGetMapxvOES := gl_GetProc('glGetMapxvOES');
    glGetMaterialxOES := gl_GetProc('glGetMaterialxOES');
    glGetPixelMapxv := gl_GetProc('glGetPixelMapxv');
    glGetTexGenxvOES := gl_GetProc('glGetTexGenxvOES');
    glGetTexLevelParameterxvOES := gl_GetProc('glGetTexLevelParameterxvOES');
    glIndexxOES := gl_GetProc('glIndexxOES');
    glIndexxvOES := gl_GetProc('glIndexxvOES');
    glLoadTransposeMatrixxOES := gl_GetProc('glLoadTransposeMatrixxOES');
    glMap1xOES := gl_GetProc('glMap1xOES');
    glMap2xOES := gl_GetProc('glMap2xOES');
    glMapGrid1xOES := gl_GetProc('glMapGrid1xOES');
    glMapGrid2xOES := gl_GetProc('glMapGrid2xOES');
    glMultTransposeMatrixxOES := gl_GetProc('glMultTransposeMatrixxOES');
    glMultiTexCoord1xOES := gl_GetProc('glMultiTexCoord1xOES');
    glMultiTexCoord1xvOES := gl_GetProc('glMultiTexCoord1xvOES');
    glMultiTexCoord2xOES := gl_GetProc('glMultiTexCoord2xOES');
    glMultiTexCoord2xvOES := gl_GetProc('glMultiTexCoord2xvOES');
    glMultiTexCoord3xOES := gl_GetProc('glMultiTexCoord3xOES');
    glMultiTexCoord3xvOES := gl_GetProc('glMultiTexCoord3xvOES');
    glMultiTexCoord4xvOES := gl_GetProc('glMultiTexCoord4xvOES');
    glNormal3xvOES := gl_GetProc('glNormal3xvOES');
    glPassThroughxOES := gl_GetProc('glPassThroughxOES');
    glPixelMapx := gl_GetProc('glPixelMapx');
    glPixelStorex := gl_GetProc('glPixelStorex');
    glPixelTransferxOES := gl_GetProc('glPixelTransferxOES');
    glPixelZoomxOES := gl_GetProc('glPixelZoomxOES');
    glPrioritizeTexturesxOES := gl_GetProc('glPrioritizeTexturesxOES');
    glRasterPos2xOES := gl_GetProc('glRasterPos2xOES');
    glRasterPos2xvOES := gl_GetProc('glRasterPos2xvOES');
    glRasterPos3xOES := gl_GetProc('glRasterPos3xOES');
    glRasterPos3xvOES := gl_GetProc('glRasterPos3xvOES');
    glRasterPos4xOES := gl_GetProc('glRasterPos4xOES');
    glRasterPos4xvOES := gl_GetProc('glRasterPos4xvOES');
    glRectxOES := gl_GetProc('glRectxOES');
    glRectxvOES := gl_GetProc('glRectxvOES');
    glTexCoord1xOES := gl_GetProc('glTexCoord1xOES');
    glTexCoord1xvOES := gl_GetProc('glTexCoord1xvOES');
    glTexCoord2xOES := gl_GetProc('glTexCoord2xOES');
    glTexCoord2xvOES := gl_GetProc('glTexCoord2xvOES');
    glTexCoord3xOES := gl_GetProc('glTexCoord3xOES');
    glTexCoord3xvOES := gl_GetProc('glTexCoord3xvOES');
    glTexCoord4xOES := gl_GetProc('glTexCoord4xOES');
    glTexCoord4xvOES := gl_GetProc('glTexCoord4xvOES');
    glTexGenxOES := gl_GetProc('glTexGenxOES');
    glTexGenxvOES := gl_GetProc('glTexGenxvOES');
    glVertex2xOES := gl_GetProc('glVertex2xOES');
    glVertex2xvOES := gl_GetProc('glVertex2xvOES');
    glVertex3xOES := gl_GetProc('glVertex3xOES');
    glVertex3xvOES := gl_GetProc('glVertex3xvOES');
    glVertex4xOES := gl_GetProc('glVertex4xOES');
    glVertex4xvOES := gl_GetProc('glVertex4xvOES');
  end;
  {$EndIf}

  {$IfDef GL_OES_query_matrix}
  if GL_OES_query_matrix then
    glQueryMatrixxOES := gl_GetProc('glQueryMatrixxOES');
  {$EndIf}

  {$IfDef GL_OES_single_precision}
  if GL_OES_single_precision then
  begin
    glClearDepthfOES := gl_GetProc('glClearDepthfOES');
    glClipPlanefOES := gl_GetProc('glClipPlanefOES');
    glDepthRangefOES := gl_GetProc('glDepthRangefOES');
    glFrustumfOES := gl_GetProc('glFrustumfOES');
    glGetClipPlanefOES := gl_GetProc('glGetClipPlanefOES');
    glOrthofOES := gl_GetProc('glOrthofOES');
  end;
  {$EndIf}

  {$IfDef GL_3DFX_tbuffer}
  if GL_3DFX_tbuffer then
    glTbufferMask3DFX := gl_GetProc('glTbufferMask3DFX');
  {$EndIf}

  {$IfDef GL_AMD_debug_output}
  if GL_AMD_debug_output then
  begin
    glDebugMessageEnableAMD := gl_GetProc('glDebugMessageEnableAMD');
    glDebugMessageInsertAMD := gl_GetProc('glDebugMessageInsertAMD');
    glDebugMessageCallbackAMD := gl_GetProc('glDebugMessageCallbackAMD');
    glGetDebugMessageLogAMD := gl_GetProc('glGetDebugMessageLogAMD');
  end;
  {$EndIf}

  {$IfDef GL_AMD_draw_buffers_blend}
  if GL_AMD_draw_buffers_blend then
  begin
    glBlendFuncIndexedAMD := gl_GetProc('glBlendFuncIndexedAMD');
    glBlendFuncSeparateIndexedAMD := gl_GetProc('glBlendFuncSeparateIndexedAMD');
    glBlendEquationIndexedAMD := gl_GetProc('glBlendEquationIndexedAMD');
    glBlendEquationSeparateIndexedAMD := gl_GetProc('glBlendEquationSeparateIndexedAMD');
  end;
  {$EndIf}

  {$IfDef GL_AMD_framebuffer_multisample_advanced}
  if GL_AMD_framebuffer_multisample_advanced then
  begin
    glRenderbufferStorageMultisampleAdvancedAMD := gl_GetProc('glRenderbufferStorageMultisampleAdvancedAMD');
    glNamedRenderbufferStorageMultisampleAdvancedAMD := gl_GetProc('glNamedRenderbufferStorageMultisampleAdvancedAMD');
  end;
  {$EndIf}

  {$IfDef GL_AMD_framebuffer_sample_positions}
  if GL_AMD_framebuffer_sample_positions then
  begin
    glFramebufferSamplePositionsfvAMD := gl_GetProc('glFramebufferSamplePositionsfvAMD');
    glNamedFramebufferSamplePositionsfvAMD := gl_GetProc('glNamedFramebufferSamplePositionsfvAMD');
    glGetFramebufferParameterfvAMD := gl_GetProc('glGetFramebufferParameterfvAMD');
    glGetNamedFramebufferParameterfvAMD := gl_GetProc('glGetNamedFramebufferParameterfvAMD');
  end;
  {$EndIf}

  {$If defined(GL_AMD_gpu_shader_int64) or defined(GL_NV_gpu_shader5)}
  if GL_AMD_gpu_shader_int64 or GL_NV_gpu_shader5 then
  begin
    glUniform1i64NV := gl_GetProc('glUniform1i64NV');
    glUniform2i64NV := gl_GetProc('glUniform2i64NV');
    glUniform3i64NV := gl_GetProc('glUniform3i64NV');
    glUniform4i64NV := gl_GetProc('glUniform4i64NV');
    glUniform1i64vNV := gl_GetProc('glUniform1i64vNV');
    glUniform2i64vNV := gl_GetProc('glUniform2i64vNV');
    glUniform3i64vNV := gl_GetProc('glUniform3i64vNV');
    glUniform4i64vNV := gl_GetProc('glUniform4i64vNV');
    glUniform1ui64NV := gl_GetProc('glUniform1ui64NV');
    glUniform2ui64NV := gl_GetProc('glUniform2ui64NV');
    glUniform3ui64NV := gl_GetProc('glUniform3ui64NV');
    glUniform4ui64NV := gl_GetProc('glUniform4ui64NV');
    glUniform1ui64vNV := gl_GetProc('glUniform1ui64vNV');
    glUniform2ui64vNV := gl_GetProc('glUniform2ui64vNV');
    glUniform3ui64vNV := gl_GetProc('glUniform3ui64vNV');
    glUniform4ui64vNV := gl_GetProc('glUniform4ui64vNV');
    glGetUniformi64vNV := gl_GetProc('glGetUniformi64vNV');
    glProgramUniform1i64NV := gl_GetProc('glProgramUniform1i64NV');
    glProgramUniform2i64NV := gl_GetProc('glProgramUniform2i64NV');
    glProgramUniform3i64NV := gl_GetProc('glProgramUniform3i64NV');
    glProgramUniform4i64NV := gl_GetProc('glProgramUniform4i64NV');
    glProgramUniform1i64vNV := gl_GetProc('glProgramUniform1i64vNV');
    glProgramUniform2i64vNV := gl_GetProc('glProgramUniform2i64vNV');
    glProgramUniform3i64vNV := gl_GetProc('glProgramUniform3i64vNV');
    glProgramUniform4i64vNV := gl_GetProc('glProgramUniform4i64vNV');
    glProgramUniform1ui64NV := gl_GetProc('glProgramUniform1ui64NV');
    glProgramUniform2ui64NV := gl_GetProc('glProgramUniform2ui64NV');
    glProgramUniform3ui64NV := gl_GetProc('glProgramUniform3ui64NV');
    glProgramUniform4ui64NV := gl_GetProc('glProgramUniform4ui64NV');
    glProgramUniform1ui64vNV := gl_GetProc('glProgramUniform1ui64vNV');
    glProgramUniform2ui64vNV := gl_GetProc('glProgramUniform2ui64vNV');
    glProgramUniform3ui64vNV := gl_GetProc('glProgramUniform3ui64vNV');
    glProgramUniform4ui64vNV := gl_GetProc('glProgramUniform4ui64vNV');
  end;
  {$IfEnd}

  {$If defined(GL_AMD_gpu_shader_int64) or defined(GL_NV_shader_buffer_load)}
  if GL_AMD_gpu_shader_int64 or GL_NV_shader_buffer_load then
    glGetUniformui64vNV := gl_GetProc('glGetUniformui64vNV');
  {$IfEnd}

  {$IfDef GL_AMD_interleaved_elements}
  if GL_AMD_interleaved_elements then
    glVertexAttribParameteriAMD := gl_GetProc('glVertexAttribParameteriAMD');
  {$EndIf}

  {$IfDef GL_AMD_multi_draw_indirect}
  if GL_AMD_multi_draw_indirect then
  begin
    glMultiDrawArraysIndirectAMD := gl_GetProc('glMultiDrawArraysIndirectAMD');
    glMultiDrawElementsIndirectAMD := gl_GetProc('glMultiDrawElementsIndirectAMD');
  end;
  {$EndIf}

  {$IfDef GL_AMD_name_gen_delete}
  if GL_AMD_name_gen_delete then
  begin
    glGenNamesAMD := gl_GetProc('glGenNamesAMD');
    glDeleteNamesAMD := gl_GetProc('glDeleteNamesAMD');
    glIsNameAMD := gl_GetProc('glIsNameAMD');
  end;
  {$EndIf}

  {$IfDef GL_AMD_occlusion_query_event}
  if GL_AMD_occlusion_query_event then
    glQueryObjectParameteruiAMD := gl_GetProc('glQueryObjectParameteruiAMD');
  {$EndIf}

  {$IfDef GL_AMD_performance_monitor}
  if GL_AMD_performance_monitor then
  begin
    glGetPerfMonitorGroupsAMD := gl_GetProc('glGetPerfMonitorGroupsAMD');
    glGetPerfMonitorCountersAMD := gl_GetProc('glGetPerfMonitorCountersAMD');
    glGetPerfMonitorGroupStringAMD := gl_GetProc('glGetPerfMonitorGroupStringAMD');
    glGetPerfMonitorCounterStringAMD := gl_GetProc('glGetPerfMonitorCounterStringAMD');
    glGetPerfMonitorCounterInfoAMD := gl_GetProc('glGetPerfMonitorCounterInfoAMD');
    glGenPerfMonitorsAMD := gl_GetProc('glGenPerfMonitorsAMD');
    glDeletePerfMonitorsAMD := gl_GetProc('glDeletePerfMonitorsAMD');
    glSelectPerfMonitorCountersAMD := gl_GetProc('glSelectPerfMonitorCountersAMD');
    glBeginPerfMonitorAMD := gl_GetProc('glBeginPerfMonitorAMD');
    glEndPerfMonitorAMD := gl_GetProc('glEndPerfMonitorAMD');
    glGetPerfMonitorCounterDataAMD := gl_GetProc('glGetPerfMonitorCounterDataAMD');
  end;
  {$EndIf}

  {$IfDef GL_AMD_sample_positions}
  if GL_AMD_sample_positions then
    glSetMultisamplefvAMD := gl_GetProc('glSetMultisamplefvAMD');
  {$EndIf}

  {$IfDef GL_AMD_sparse_texture}
  if GL_AMD_sparse_texture then
  begin
    glTexStorageSparseAMD := gl_GetProc('glTexStorageSparseAMD');
    glTextureStorageSparseAMD := gl_GetProc('glTextureStorageSparseAMD');
  end;
  {$EndIf}

  {$IfDef GL_AMD_stencil_operation_extended}
  if GL_AMD_stencil_operation_extended then
    glStencilOpValueAMD := gl_GetProc('glStencilOpValueAMD');
  {$EndIf}

  {$IfDef GL_AMD_vertex_shader_tessellator}
  if GL_AMD_vertex_shader_tessellator then
  begin
    glTessellationFactorAMD := gl_GetProc('glTessellationFactorAMD');
    glTessellationModeAMD := gl_GetProc('glTessellationModeAMD');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_element_array}
  if GL_APPLE_element_array then
  begin
    glElementPointerAPPLE := gl_GetProc('glElementPointerAPPLE');
    glDrawElementArrayAPPLE := gl_GetProc('glDrawElementArrayAPPLE');
    glDrawRangeElementArrayAPPLE := gl_GetProc('glDrawRangeElementArrayAPPLE');
    glMultiDrawElementArrayAPPLE := gl_GetProc('glMultiDrawElementArrayAPPLE');
    glMultiDrawRangeElementArrayAPPLE := gl_GetProc('glMultiDrawRangeElementArrayAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_fence}
  if GL_APPLE_fence then
  begin
    glGenFencesAPPLE := gl_GetProc('glGenFencesAPPLE');
    glDeleteFencesAPPLE := gl_GetProc('glDeleteFencesAPPLE');
    glSetFenceAPPLE := gl_GetProc('glSetFenceAPPLE');
    glIsFenceAPPLE := gl_GetProc('glIsFenceAPPLE');
    glTestFenceAPPLE := gl_GetProc('glTestFenceAPPLE');
    glFinishFenceAPPLE := gl_GetProc('glFinishFenceAPPLE');
    glTestObjectAPPLE := gl_GetProc('glTestObjectAPPLE');
    glFinishObjectAPPLE := gl_GetProc('glFinishObjectAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_flush_buffer_range}
  if GL_APPLE_flush_buffer_range then
  begin
    glBufferParameteriAPPLE := gl_GetProc('glBufferParameteriAPPLE');
    glFlushMappedBufferRangeAPPLE := gl_GetProc('glFlushMappedBufferRangeAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_object_purgeable}
  if GL_APPLE_object_purgeable then
  begin
    glObjectPurgeableAPPLE := gl_GetProc('glObjectPurgeableAPPLE');
    glObjectUnpurgeableAPPLE := gl_GetProc('glObjectUnpurgeableAPPLE');
    glGetObjectParameterivAPPLE := gl_GetProc('glGetObjectParameterivAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_texture_range}
  if GL_APPLE_texture_range then
  begin
    glTextureRangeAPPLE := gl_GetProc('glTextureRangeAPPLE');
    glGetTexParameterPointervAPPLE := gl_GetProc('glGetTexParameterPointervAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_vertex_array_object}
  if GL_APPLE_vertex_array_object then
  begin
    glBindVertexArrayAPPLE := gl_GetProc('glBindVertexArrayAPPLE');
    glDeleteVertexArraysAPPLE := gl_GetProc('glDeleteVertexArraysAPPLE');
    glGenVertexArraysAPPLE := gl_GetProc('glGenVertexArraysAPPLE');
    functionglIsVertexArrayAPPLE := gl_GetProc('functionglIsVertexArrayAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_vertex_array_range}
  if GL_APPLE_vertex_array_range then
  begin
    glVertexArrayRangeAPPLE := gl_GetProc('glVertexArrayRangeAPPLE');
    glFlushVertexArrayRangeAPPLE := gl_GetProc('glFlushVertexArrayRangeAPPLE');
    glVertexArrayParameteriAPPLE := gl_GetProc('glVertexArrayParameteriAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_APPLE_vertex_program_evaluators}
  if GL_APPLE_vertex_program_evaluators then
  begin
    glEnableVertexAttribAPPLE := gl_GetProc('glEnableVertexAttribAPPLE');
    glDisableVertexAttribAPPLE := gl_GetProc('glDisableVertexAttribAPPLE');
    glIsVertexAttribEnabledAPPLE := gl_GetProc('glIsVertexAttribEnabledAPPLE');
    glMapVertexAttrib1dAPPLE := gl_GetProc('glMapVertexAttrib1dAPPLE');
    glMapVertexAttrib1fAPPLE := gl_GetProc('glMapVertexAttrib1fAPPLE');
    glMapVertexAttrib2dAPPLE := gl_GetProc('glMapVertexAttrib2dAPPLE');
    glMapVertexAttrib2fAPPLE := gl_GetProc('glMapVertexAttrib2fAPPLE');
  end;
  {$EndIf}

  {$IfDef GL_ATI_draw_buffers}
  if GL_ATI_draw_buffers then
    glDrawBuffersATI := gl_GetProc('glDrawBuffersATI');
  {$EndIf}

  {$IfDef GL_ATI_element_array}
  if GL_ATI_element_array then
  begin
    glElementPointerATI := gl_GetProc('glElementPointerATI');
    glDrawElementArrayATI := gl_GetProc('glDrawElementArrayATI');
    glDrawRangeElementArrayATI := gl_GetProc('glDrawRangeElementArrayATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_envmap_bumpmap}
  if GL_ATI_envmap_bumpmap then
  begin
    glTexBumpParameterivATI := gl_GetProc('glTexBumpParameterivATI');
    glTexBumpParameterfvATI := gl_GetProc('glTexBumpParameterfvATI');
    glGetTexBumpParameterivATI := gl_GetProc('glGetTexBumpParameterivATI');
    glGetTexBumpParameterfvATI := gl_GetProc('glGetTexBumpParameterfvATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_fragment_shader}
  if GL_ATI_fragment_shader then
  begin
    glGenFragmentShadersATI := gl_GetProc('glGenFragmentShadersATI');
    glBindFragmentShaderATI := gl_GetProc('glBindFragmentShaderATI');
    glDeleteFragmentShaderATI := gl_GetProc('glDeleteFragmentShaderATI');
    glBeginFragmentShaderATI := gl_GetProc('glBeginFragmentShaderATI');
    glEndFragmentShaderATI := gl_GetProc('glEndFragmentShaderATI');
    glPassTexCoordATI := gl_GetProc('glPassTexCoordATI');
    glSampleMapATI := gl_GetProc('glSampleMapATI');
    glColorFragmentOp1ATI := gl_GetProc('glColorFragmentOp1ATI');
    glColorFragmentOp2ATI := gl_GetProc('glColorFragmentOp2ATI');
    glColorFragmentOp3ATI := gl_GetProc('glColorFragmentOp3ATI');
    glAlphaFragmentOp1ATI := gl_GetProc('glAlphaFragmentOp1ATI');
    glAlphaFragmentOp2ATI := gl_GetProc('glAlphaFragmentOp2ATI');
    glAlphaFragmentOp3ATI := gl_GetProc('glAlphaFragmentOp3ATI');
    glSetFragmentShaderConstantATI := gl_GetProc('glSetFragmentShaderConstantATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_map_object_buffer}
  if GL_ATI_map_object_buffer then
  begin
    glMapObjectBufferATI := gl_GetProc('glMapObjectBufferATI');
    glUnmapObjectBufferATI := gl_GetProc('glUnmapObjectBufferATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_pn_triangles}
  if GL_ATI_pn_triangles then
  begin
    glPNTrianglesiATI := gl_GetProc('glPNTrianglesiATI');
    glPNTrianglesfATI := gl_GetProc('glPNTrianglesfATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_separate_stencil}
  if GL_ATI_separate_stencil then
  begin
    glStencilOpSeparateATI := gl_GetProc('glStencilOpSeparateATI');
    glStencilFuncSeparateATI := gl_GetProc('glStencilFuncSeparateATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_vertex_array_object}
  if GL_ATI_vertex_array_object then
  begin
    glNewObjectBufferATI := gl_GetProc('glNewObjectBufferATI');
    glIsObjectBufferATI := gl_GetProc('glIsObjectBufferATI');
    glUpdateObjectBufferATI := gl_GetProc('glUpdateObjectBufferATI');
    glGetObjectBufferfvATI := gl_GetProc('glGetObjectBufferfvATI');
    glGetObjectBufferivATI := gl_GetProc('glGetObjectBufferivATI');
    glFreeObjectBufferATI := gl_GetProc('glFreeObjectBufferATI');
    glArrayObjectATI := gl_GetProc('glArrayObjectATI');
    glGetArrayObjectfvATI := gl_GetProc('glGetArrayObjectfvATI');
    glGetArrayObjectivATI := gl_GetProc('glGetArrayObjectivATI');
    glVariantArrayObjectATI := gl_GetProc('glVariantArrayObjectATI');
    glGetVariantArrayObjectfvATI := gl_GetProc('glGetVariantArrayObjectfvATI');
    glGetVariantArrayObjectivATI := gl_GetProc('glGetVariantArrayObjectivATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_vertex_attrib_array_object}
  if GL_ATI_vertex_attrib_array_object then
  begin
    glVertexAttribArrayObjectATI := gl_GetProc('glVertexAttribArrayObjectATI');
    glGetVertexAttribArrayObjectfvATI := gl_GetProc('glGetVertexAttribArrayObjectfvATI');
    glGetVertexAttribArrayObjectivATI := gl_GetProc('glGetVertexAttribArrayObjectivATI');
  end;
  {$EndIf}

  {$IfDef GL_ATI_vertex_streams}
  if GL_ATI_vertex_streams then
  begin
    glVertexStream1sATI := gl_GetProc('glVertexStream1sATI');
    glVertexStream1svATI := gl_GetProc('glVertexStream1svATI');
    glVertexStream1iATI := gl_GetProc('glVertexStream1iATI');
    glVertexStream1ivATI := gl_GetProc('glVertexStream1ivATI');
    glVertexStream1fATI := gl_GetProc('glVertexStream1fATI');
    glVertexStream1fvATI := gl_GetProc('glVertexStream1fvATI');
    glVertexStream1dATI := gl_GetProc('glVertexStream1dATI');
    glVertexStream1dvATI := gl_GetProc('glVertexStream1dvATI');
    glVertexStream2sATI := gl_GetProc('glVertexStream2sATI');
    glVertexStream2svATI := gl_GetProc('glVertexStream2svATI');
    glVertexStream2iATI := gl_GetProc('glVertexStream2iATI');
    glVertexStream2ivATI := gl_GetProc('glVertexStream2ivATI');
    glVertexStream2fATI := gl_GetProc('glVertexStream2fATI');
    glVertexStream2fvATI := gl_GetProc('glVertexStream2fvATI');
    glVertexStream2dATI := gl_GetProc('glVertexStream2dATI');
    glVertexStream2dvATI := gl_GetProc('glVertexStream2dvATI');
    glVertexStream3sATI := gl_GetProc('glVertexStream3sATI');
    glVertexStream3svATI := gl_GetProc('glVertexStream3svATI');
    glVertexStream3iATI := gl_GetProc('glVertexStream3iATI');
    glVertexStream3ivATI := gl_GetProc('glVertexStream3ivATI');
    glVertexStream3fATI := gl_GetProc('glVertexStream3fATI');
    glVertexStream3fvATI := gl_GetProc('glVertexStream3fvATI');
    glVertexStream3dATI := gl_GetProc('glVertexStream3dATI');
    glVertexStream3dvATI := gl_GetProc('glVertexStream3dvATI');
    glVertexStream4sATI := gl_GetProc('glVertexStream4sATI');
    glVertexStream4svATI := gl_GetProc('glVertexStream4svATI');
    glVertexStream4iATI := gl_GetProc('glVertexStream4iATI');
    glVertexStream4ivATI := gl_GetProc('glVertexStream4ivATI');
    glVertexStream4fATI := gl_GetProc('glVertexStream4fATI');
    glVertexStream4fvATI := gl_GetProc('glVertexStream4fvATI');
    glVertexStream4dATI := gl_GetProc('glVertexStream4dATI');
    glVertexStream4dvATI := gl_GetProc('glVertexStream4dvATI');
    glNormalStream3bATI := gl_GetProc('glNormalStream3bATI');
    glNormalStream3bvATI := gl_GetProc('glNormalStream3bvATI');
    glNormalStream3sATI := gl_GetProc('glNormalStream3sATI');
    glNormalStream3svATI := gl_GetProc('glNormalStream3svATI');
    glNormalStream3iATI := gl_GetProc('glNormalStream3iATI');
    glNormalStream3ivATI := gl_GetProc('glNormalStream3ivATI');
    glNormalStream3fATI := gl_GetProc('glNormalStream3fATI');
    glNormalStream3fvATI := gl_GetProc('glNormalStream3fvATI');
    glNormalStream3dATI := gl_GetProc('glNormalStream3dATI');
    glNormalStream3dvATI := gl_GetProc('glNormalStream3dvATI');
    glClientActiveVertexStreamATI := gl_GetProc('glClientActiveVertexStreamATI');
    glVertexBlendEnviATI := gl_GetProc('glVertexBlendEnviATI');
    glVertexBlendEnvfATI := gl_GetProc('glVertexBlendEnvfATI');
  end;
  {$EndIf}

  {$IfDef GL_EXT_EGL_image_storage}
  if GL_EXT_EGL_image_storage then
  begin
    glEGLImageTargetTexStorageEXT := gl_GetProc('glEGLImageTargetTexStorageEXT');
    glEGLImageTargetTextureStorageEXT := gl_GetProc('glEGLImageTargetTextureStorageEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_bindable_uniform}
  if GL_EXT_bindable_uniform then
  begin
    glUniformBufferEXT := gl_GetProc('glUniformBufferEXT');
    glGetUniformBufferSizeEXT := gl_GetProc('glGetUniformBufferSizeEXT');
    glGetUniformOffsetEXT := gl_GetProc('glGetUniformOffsetEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_blend_color}
  if GL_EXT_blend_color then
    glBlendColorEXT := gl_GetProc('glBlendColorEXT');
  {$EndIf}

  {$IfDef GL_EXT_blend_equation_separate}
  if GL_EXT_blend_equation_separate then
    glBlendEquationSeparateEXT := gl_GetProc('glBlendEquationSeparateEXT');
  {$EndIf}

(*  {$IfDef GL_EXT_blend_func_separate}
  glBlendFuncSeparateEXT := gl_GetProc('glBlendFuncSeparateEXT');
  {$EndIf}

  {$IfDef GL_EXT_blend_minmax}
  glBlendEquationEXT := gl_GetProc('glBlendEquationEXT');
  {$EndIf}  *)

  {$IfDef GL_EXT_color_subtable}
  if GL_EXT_color_subtable then
  begin
    glColorSubTableEXT := gl_GetProc('glColorSubTableEXT');
    glCopyColorSubTableEXT := gl_GetProc('glCopyColorSubTableEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_compiled_vertex_array}
  if GL_EXT_compiled_vertex_array then
  begin
    glLockArraysEXT := gl_GetProc('glLockArraysEXT');
    glUnlockArraysEXT := gl_GetProc('glUnlockArraysEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_convolution}
  if GL_EXT_convolution then
  begin
    glConvolutionFilter1DEXT := gl_GetProc('glConvolutionFilter1DEXT');
    glConvolutionFilter2DEXT := gl_GetProc('glConvolutionFilter2DEXT');
    glConvolutionParameterfEXT := gl_GetProc('glConvolutionParameterfEXT');
    glConvolutionParameterfvEXT := gl_GetProc('glConvolutionParameterfvEXT');
    glConvolutionParameteriEXT := gl_GetProc('glConvolutionParameteriEXT');
    glConvolutionParameterivEXT := gl_GetProc('glConvolutionParameterivEXT');
    glCopyConvolutionFilter1DEXT := gl_GetProc('glCopyConvolutionFilter1DEXT');
    glCopyConvolutionFilter2DEXT := gl_GetProc('glCopyConvolutionFilter2DEXT');
    glGetConvolutionFilterEXT := gl_GetProc('glGetConvolutionFilterEXT');
    glGetConvolutionParameterfvEXT := gl_GetProc('glGetConvolutionParameterfvEXT');
    glGetConvolutionParameterivEXT := gl_GetProc('glGetConvolutionParameterivEXT');
    glGetSeparableFilterEXT := gl_GetProc('glGetSeparableFilterEXT');
    glSeparableFilter2DEXT := gl_GetProc('glSeparableFilter2DEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_coordinate_frame}
  if GL_EXT_coordinate_frame then
  begin
    glTangent3bEXT := gl_GetProc('glTangent3bEXT');
    glTangent3bvEXT := gl_GetProc('glTangent3bvEXT');
    glTangent3dEXT := gl_GetProc('glTangent3dEXT');
    glTangent3dvEXT := gl_GetProc('glTangent3dvEXT');
    glTangent3fEXT := gl_GetProc('glTangent3fEXT');
    glTangent3fvEXT := gl_GetProc('glTangent3fvEXT');
    glTangent3iEXT := gl_GetProc('glTangent3iEXT');
    glTangent3ivEXT := gl_GetProc('glTangent3ivEXT');
    glTangent3sEXT := gl_GetProc('glTangent3sEXT');
    glTangent3svEXT := gl_GetProc('glTangent3svEXT');
    glBinormal3bEXT := gl_GetProc('glBinormal3bEXT');
    glBinormal3bvEXT := gl_GetProc('glBinormal3bvEXT');
    glBinormal3dEXT := gl_GetProc('glBinormal3dEXT');
    glBinormal3dvEXT := gl_GetProc('glBinormal3dvEXT');
    glBinormal3fEXT := gl_GetProc('glBinormal3fEXT');
    glBinormal3fvEXT := gl_GetProc('glBinormal3fvEXT');
    glBinormal3iEXT := gl_GetProc('glBinormal3iEXT');
    glBinormal3ivEXT := gl_GetProc('glBinormal3ivEXT');
    glBinormal3sEXT := gl_GetProc('glBinormal3sEXT');
    glBinormal3svEXT := gl_GetProc('glBinormal3svEXT');
    glTangentPointerEXT := gl_GetProc('glTangentPointerEXT');
    glBinormalPointerEXT := gl_GetProc('glBinormalPointerEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_copy_texture}
  if GL_EXT_copy_texture then
  begin
    glCopyTexImage1DEXT := gl_GetProc('glCopyTexImage1DEXT');
    glCopyTexImage2DEXT := gl_GetProc('glCopyTexImage2DEXT');
    glCopyTexSubImage1DEXT := gl_GetProc('glCopyTexSubImage1DEXT');
    glCopyTexSubImage2DEXT := gl_GetProc('glCopyTexSubImage2DEXT');
    glCopyTexSubImage3DEXT := gl_GetProc('glCopyTexSubImage3DEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_cull_vertex}
  if GL_EXT_cull_vertex then
  begin
    glCullParameterdvEXT := gl_GetProc('glCullParameterdvEXT');
    glCullParameterfvEXT := gl_GetProc('glCullParameterfvEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_debug_label}
  if GL_EXT_debug_label then
  begin
    glLabelObjectEXT := gl_GetProc('glLabelObjectEXT');
    glGetObjectLabelEXT := gl_GetProc('glGetObjectLabelEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_debug_marker}
  if GL_EXT_debug_marker then
  begin
    glInsertEventMarkerEXT := gl_GetProc('glInsertEventMarkerEXT');
    glPushGroupMarkerEXT := gl_GetProc('glPushGroupMarkerEXT');
    glPopGroupMarkerEXT := gl_GetProc('glPopGroupMarkerEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_depth_bounds_test}
  if GL_EXT_depth_bounds_test then
    glDepthBoundsEXT := gl_GetProc('glDepthBoundsEXT');
  {$EndIf}

  {$IfDef GL_EXT_direct_state_access}
  if GL_EXT_direct_state_access then
  begin
    glMatrixLoadfEXT := gl_GetProc('glMatrixLoadfEXT');
    glMatrixLoaddEXT := gl_GetProc('glMatrixLoaddEXT');
    glMatrixMultfEXT := gl_GetProc('glMatrixMultfEXT');
    glMatrixMultdEXT := gl_GetProc('glMatrixMultdEXT');
    glMatrixLoadIdentityEXT := gl_GetProc('glMatrixLoadIdentityEXT');
    glMatrixRotatefEXT := gl_GetProc('glMatrixRotatefEXT');
    glMatrixRotatedEXT := gl_GetProc('glMatrixRotatedEXT');
    glMatrixScalefEXT := gl_GetProc('glMatrixScalefEXT');
    glMatrixScaledEXT := gl_GetProc('glMatrixScaledEXT');
    glMatrixTranslatefEXT := gl_GetProc('glMatrixTranslatefEXT');
    glMatrixTranslatedEXT := gl_GetProc('glMatrixTranslatedEXT');
    glMatrixFrustumEXT := gl_GetProc('glMatrixFrustumEXT');
    glMatrixOrthoEXT := gl_GetProc('glMatrixOrthoEXT');
    glMatrixPopEXT := gl_GetProc('glMatrixPopEXT');
    glMatrixPushEXT := gl_GetProc('glMatrixPushEXT');
    glClientAttribDefaultEXT := gl_GetProc('glClientAttribDefaultEXT');
    glPushClientAttribDefaultEXT := gl_GetProc('glPushClientAttribDefaultEXT');
    glTextureParameterfEXT := gl_GetProc('glTextureParameterfEXT');
    glTextureParameterfvEXT := gl_GetProc('glTextureParameterfvEXT');
    glTextureParameteriEXT := gl_GetProc('glTextureParameteriEXT');
    glTextureParameterivEXT := gl_GetProc('glTextureParameterivEXT');
    glTextureImage1DEXT := gl_GetProc('glTextureImage1DEXT');
    glTextureImage2DEXT := gl_GetProc('glTextureImage2DEXT');
    glTextureSubImage1DEXT := gl_GetProc('glTextureSubImage1DEXT');
    glTextureSubImage2DEXT := gl_GetProc('glTextureSubImage2DEXT');
    glCopyTextureImage1DEXT := gl_GetProc('glCopyTextureImage1DEXT');
    glCopyTextureImage2DEXT := gl_GetProc('glCopyTextureImage2DEXT');
    glCopyTextureSubImage1DEXT := gl_GetProc('glCopyTextureSubImage1DEXT');
    glCopyTextureSubImage2DEXT := gl_GetProc('glCopyTextureSubImage2DEXT');
    glGetTextureImageEXT := gl_GetProc('glGetTextureImageEXT');
    glGetTextureParameterfvEXT := gl_GetProc('glGetTextureParameterfvEXT');
    glGetTextureParameterivEXT := gl_GetProc('glGetTextureParameterivEXT');
    glGetTextureLevelParameterfvEXT := gl_GetProc('glGetTextureLevelParameterfvEXT');
    glGetTextureLevelParameterivEXT := gl_GetProc('glGetTextureLevelParameterivEXT');
    glTextureImage3DEXT := gl_GetProc('glTextureImage3DEXT');
    glTextureSubImage3DEXT := gl_GetProc('glTextureSubImage3DEXT');
    glCopyTextureSubImage3DEXT := gl_GetProc('glCopyTextureSubImage3DEXT');
    glBindMultiTextureEXT := gl_GetProc('glBindMultiTextureEXT');
    glMultiTexCoordPointerEXT := gl_GetProc('glMultiTexCoordPointerEXT');
    glMultiTexEnvfEXT := gl_GetProc('glMultiTexEnvfEXT');
    glMultiTexEnvfvEXT := gl_GetProc('glMultiTexEnvfvEXT');
    glMultiTexEnviEXT := gl_GetProc('glMultiTexEnviEXT');
    glMultiTexEnvivEXT := gl_GetProc('glMultiTexEnvivEXT');
    glMultiTexGendEXT := gl_GetProc('glMultiTexGendEXT');
    glMultiTexGendvEXT := gl_GetProc('glMultiTexGendvEXT');
    glMultiTexGenfEXT := gl_GetProc('glMultiTexGenfEXT');
    glMultiTexGenfvEXT := gl_GetProc('glMultiTexGenfvEXT');
    glMultiTexGeniEXT := gl_GetProc('glMultiTexGeniEXT');
    glMultiTexGenivEXT := gl_GetProc('glMultiTexGenivEXT');
    glGetMultiTexEnvfvEXT := gl_GetProc('glGetMultiTexEnvfvEXT');
    glGetMultiTexEnvivEXT := gl_GetProc('glGetMultiTexEnvivEXT');
    glGetMultiTexGendvEXT := gl_GetProc('glGetMultiTexGendvEXT');
    glGetMultiTexGenfvEXT := gl_GetProc('glGetMultiTexGenfvEXT');
    glGetMultiTexGenivEXT := gl_GetProc('glGetMultiTexGenivEXT');
    glMultiTexParameteriEXT := gl_GetProc('glMultiTexParameteriEXT');
    glMultiTexParameterivEXT := gl_GetProc('glMultiTexParameterivEXT');
    glMultiTexParameterfEXT := gl_GetProc('glMultiTexParameterfEXT');
    glMultiTexParameterfvEXT := gl_GetProc('glMultiTexParameterfvEXT');
    glMultiTexImage1DEXT := gl_GetProc('glMultiTexImage1DEXT');
    glMultiTexImage2DEXT := gl_GetProc('glMultiTexImage2DEXT');
    glMultiTexSubImage1DEXT := gl_GetProc('glMultiTexSubImage1DEXT');
    glMultiTexSubImage2DEXT := gl_GetProc('glMultiTexSubImage2DEXT');
    glCopyMultiTexImage1DEXT := gl_GetProc('glCopyMultiTexImage1DEXT');
    glCopyMultiTexImage2DEXT := gl_GetProc('glCopyMultiTexImage2DEXT');
    glCopyMultiTexSubImage1DEXT := gl_GetProc('glCopyMultiTexSubImage1DEXT');
    glCopyMultiTexSubImage2DEXT := gl_GetProc('glCopyMultiTexSubImage2DEXT');
    glGetMultiTexImageEXT := gl_GetProc('glGetMultiTexImageEXT');
    glGetMultiTexParameterfvEXT := gl_GetProc('glGetMultiTexParameterfvEXT');
    glGetMultiTexParameterivEXT := gl_GetProc('glGetMultiTexParameterivEXT');
    glGetMultiTexLevelParameterfvEXT := gl_GetProc('glGetMultiTexLevelParameterfvEXT');
    glGetMultiTexLevelParameterivEXT := gl_GetProc('glGetMultiTexLevelParameterivEXT');
    glMultiTexImage3DEXT := gl_GetProc('glMultiTexImage3DEXT');
    glMultiTexSubImage3DEXT := gl_GetProc('glMultiTexSubImage3DEXT');
    glCopyMultiTexSubImage3DEXT := gl_GetProc('glCopyMultiTexSubImage3DEXT');
    glEnableClientStateIndexedEXT := gl_GetProc('glEnableClientStateIndexedEXT');
    glDisableClientStateIndexedEXT := gl_GetProc('glDisableClientStateIndexedEXT');
    glGetFloatIndexedvEXT := gl_GetProc('glGetFloatIndexedvEXT');
    glGetDoubleIndexedvEXT := gl_GetProc('glGetDoubleIndexedvEXT');
    glGetPointerIndexedvEXT := gl_GetProc('glGetPointerIndexedvEXT');
    glEnableIndexedEXT := gl_GetProc('glEnableIndexedEXT');
    glDisableIndexedEXT := gl_GetProc('glDisableIndexedEXT');
    glIsEnabledIndexedEXT := gl_GetProc('glIsEnabledIndexedEXT');
    glGetIntegerIndexedvEXT := gl_GetProc('glGetIntegerIndexedvEXT');
    glGetBooleanIndexedvEXT := gl_GetProc('glGetBooleanIndexedvEXT');
    glCompressedTextureImage3DEXT := gl_GetProc('glCompressedTextureImage3DEXT');
    glCompressedTextureImage2DEXT := gl_GetProc('glCompressedTextureImage2DEXT');
    glCompressedTextureImage1DEXT := gl_GetProc('glCompressedTextureImage1DEXT');
    glCompressedTextureSubImage3DEXT := gl_GetProc('glCompressedTextureSubImage3DEXT');
    glCompressedTextureSubImage2DEXT := gl_GetProc('glCompressedTextureSubImage2DEXT');
    glCompressedTextureSubImage1DEXT := gl_GetProc('glCompressedTextureSubImage1DEXT');
    glGetCompressedTextureImageEXT := gl_GetProc('glGetCompressedTextureImageEXT');
    glCompressedMultiTexImage3DEXT := gl_GetProc('glCompressedMultiTexImage3DEXT');
    glCompressedMultiTexImage2DEXT := gl_GetProc('glCompressedMultiTexImage2DEXT');
    glCompressedMultiTexImage1DEXT := gl_GetProc('glCompressedMultiTexImage1DEXT');
    glCompressedMultiTexSubImage3DEXT := gl_GetProc('glCompressedMultiTexSubImage3DEXT');
    glCompressedMultiTexSubImage2DEXT := gl_GetProc('glCompressedMultiTexSubImage2DEXT');
    glCompressedMultiTexSubImage1DEXT := gl_GetProc('glCompressedMultiTexSubImage1DEXT');
    glGetCompressedMultiTexImageEXT := gl_GetProc('glGetCompressedMultiTexImageEXT');
    glMatrixLoadTransposefEXT := gl_GetProc('glMatrixLoadTransposefEXT');
    glMatrixLoadTransposedEXT := gl_GetProc('glMatrixLoadTransposedEXT');
    glMatrixMultTransposefEXT := gl_GetProc('glMatrixMultTransposefEXT');
    glMatrixMultTransposedEXT := gl_GetProc('glMatrixMultTransposedEXT');
    glNamedBufferDataEXT := gl_GetProc('glNamedBufferDataEXT');
    glNamedBufferSubDataEXT := gl_GetProc('glNamedBufferSubDataEXT');
    glMapNamedBufferEXT := gl_GetProc('glMapNamedBufferEXT');
    glUnmapNamedBufferEXT := gl_GetProc('glUnmapNamedBufferEXT');
    glGetNamedBufferParameterivEXT := gl_GetProc('glGetNamedBufferParameterivEXT');
    glGetNamedBufferPointervEXT := gl_GetProc('glGetNamedBufferPointervEXT');
    glGetNamedBufferSubDataEXT := gl_GetProc('glGetNamedBufferSubDataEXT');
    glProgramUniform1fEXT := gl_GetProc('glProgramUniform1fEXT');
    glProgramUniform2fEXT := gl_GetProc('glProgramUniform2fEXT');
    glProgramUniform3fEXT := gl_GetProc('glProgramUniform3fEXT');
    glProgramUniform4fEXT := gl_GetProc('glProgramUniform4fEXT');
    glProgramUniform1iEXT := gl_GetProc('glProgramUniform1iEXT');
    glProgramUniform2iEXT := gl_GetProc('glProgramUniform2iEXT');
    glProgramUniform3iEXT := gl_GetProc('glProgramUniform3iEXT');
    glProgramUniform4iEXT := gl_GetProc('glProgramUniform4iEXT');
    glProgramUniform1fvEXT := gl_GetProc('glProgramUniform1fvEXT');
    glProgramUniform2fvEXT := gl_GetProc('glProgramUniform2fvEXT');
    glProgramUniform3fvEXT := gl_GetProc('glProgramUniform3fvEXT');
    glProgramUniform4fvEXT := gl_GetProc('glProgramUniform4fvEXT');
    glProgramUniform1ivEXT := gl_GetProc('glProgramUniform1ivEXT');
    glProgramUniform2ivEXT := gl_GetProc('glProgramUniform2ivEXT');
    glProgramUniform3ivEXT := gl_GetProc('glProgramUniform3ivEXT');
    glProgramUniform4ivEXT := gl_GetProc('glProgramUniform4ivEXT');
    glProgramUniformMatrix2fvEXT := gl_GetProc('glProgramUniformMatrix2fvEXT');
    glProgramUniformMatrix3fvEXT := gl_GetProc('glProgramUniformMatrix3fvEXT');
    glProgramUniformMatrix4fvEXT := gl_GetProc('glProgramUniformMatrix4fvEXT');
    glProgramUniformMatrix2x3fvEXT := gl_GetProc('glProgramUniformMatrix2x3fvEXT');
    glProgramUniformMatrix3x2fvEXT := gl_GetProc('glProgramUniformMatrix3x2fvEXT');
    glProgramUniformMatrix2x4fvEXT := gl_GetProc('glProgramUniformMatrix2x4fvEXT');
    glProgramUniformMatrix4x2fvEXT := gl_GetProc('glProgramUniformMatrix4x2fvEXT');
    glProgramUniformMatrix3x4fvEXT := gl_GetProc('glProgramUniformMatrix3x4fvEXT');
    glProgramUniformMatrix4x3fvEXT := gl_GetProc('glProgramUniformMatrix4x3fvEXT');
    glTextureBufferEXT := gl_GetProc('glTextureBufferEXT');
    glMultiTexBufferEXT := gl_GetProc('glMultiTexBufferEXT');
    glTextureParameterIivEXT := gl_GetProc('glTextureParameterIivEXT');
    glTextureParameterIuivEXT := gl_GetProc('glTextureParameterIuivEXT');
    glGetTextureParameterIivEXT := gl_GetProc('glGetTextureParameterIivEXT');
    glGetTextureParameterIuivEXT := gl_GetProc('glGetTextureParameterIuivEXT');
    glMultiTexParameterIivEXT := gl_GetProc('glMultiTexParameterIivEXT');
    glMultiTexParameterIuivEXT := gl_GetProc('glMultiTexParameterIuivEXT');
    glGetMultiTexParameterIivEXT := gl_GetProc('glGetMultiTexParameterIivEXT');
    glGetMultiTexParameterIuivEXT := gl_GetProc('glGetMultiTexParameterIuivEXT');
    glProgramUniform1uiEXT := gl_GetProc('glProgramUniform1uiEXT');
    glProgramUniform2uiEXT := gl_GetProc('glProgramUniform2uiEXT');
    glProgramUniform3uiEXT := gl_GetProc('glProgramUniform3uiEXT');
    glProgramUniform4uiEXT := gl_GetProc('glProgramUniform4uiEXT');
    glProgramUniform1uivEXT := gl_GetProc('glProgramUniform1uivEXT');
    glProgramUniform2uivEXT := gl_GetProc('glProgramUniform2uivEXT');
    glProgramUniform3uivEXT := gl_GetProc('glProgramUniform3uivEXT');
    glProgramUniform4uivEXT := gl_GetProc('glProgramUniform4uivEXT');
    glNamedProgramLocalParameters4fvEXT := gl_GetProc('glNamedProgramLocalParameters4fvEXT');
    glNamedProgramLocalParameterI4iEXT := gl_GetProc('glNamedProgramLocalParameterI4iEXT');
    glNamedProgramLocalParameterI4ivEXT := gl_GetProc('glNamedProgramLocalParameterI4ivEXT');
    glNamedProgramLocalParametersI4ivEXT := gl_GetProc('glNamedProgramLocalParametersI4ivEXT');
    glNamedProgramLocalParameterI4uiEXT := gl_GetProc('glNamedProgramLocalParameterI4uiEXT');
    glNamedProgramLocalParameterI4uivEXT := gl_GetProc('glNamedProgramLocalParameterI4uivEXT');
    glNamedProgramLocalParametersI4uivEXT := gl_GetProc('glNamedProgramLocalParametersI4uivEXT');
    glGetNamedProgramLocalParameterIivEXT := gl_GetProc('glGetNamedProgramLocalParameterIivEXT');
    glGetNamedProgramLocalParameterIuivEXT := gl_GetProc('glGetNamedProgramLocalParameterIuivEXT');
    glEnableClientStateiEXT := gl_GetProc('glEnableClientStateiEXT');
    glDisableClientStateiEXT := gl_GetProc('glDisableClientStateiEXT');
    glGetFloati_vEXT := gl_GetProc('glGetFloati_vEXT');
    glGetDoublei_vEXT := gl_GetProc('glGetDoublei_vEXT');
    glGetPointeri_vEXT := gl_GetProc('glGetPointeri_vEXT');
    glNamedProgramStringEXT := gl_GetProc('glNamedProgramStringEXT');
    glNamedProgramLocalParameter4dEXT := gl_GetProc('glNamedProgramLocalParameter4dEXT');
    glNamedProgramLocalParameter4dvEXT := gl_GetProc('glNamedProgramLocalParameter4dvEXT');
    glNamedProgramLocalParameter4fEXT := gl_GetProc('glNamedProgramLocalParameter4fEXT');
    glNamedProgramLocalParameter4fvEXT := gl_GetProc('glNamedProgramLocalParameter4fvEXT');
    glGetNamedProgramLocalParameterdvEXT := gl_GetProc('glGetNamedProgramLocalParameterdvEXT');
    glGetNamedProgramLocalParameterfvEXT := gl_GetProc('glGetNamedProgramLocalParameterfvEXT');
    glGetNamedProgramivEXT := gl_GetProc('glGetNamedProgramivEXT');
    glGetNamedProgramStringEXT := gl_GetProc('glGetNamedProgramStringEXT');
    glNamedRenderbufferStorageEXT := gl_GetProc('glNamedRenderbufferStorageEXT');
    glGetNamedRenderbufferParameterivEXT := gl_GetProc('glGetNamedRenderbufferParameterivEXT');
    glNamedRenderbufferStorageMultisampleEXT := gl_GetProc('glNamedRenderbufferStorageMultisampleEXT');
    glNamedRenderbufferStorageMultisampleCoverageEXT := gl_GetProc('glNamedRenderbufferStorageMultisampleCoverageEXT');
    glCheckNamedFramebufferStatusEXT := gl_GetProc('glCheckNamedFramebufferStatusEXT');
    glNamedFramebufferTexture1DEXT := gl_GetProc('glNamedFramebufferTexture1DEXT');
    glNamedFramebufferTexture2DEXT := gl_GetProc('glNamedFramebufferTexture2DEXT');
    glNamedFramebufferTexture3DEXT := gl_GetProc('glNamedFramebufferTexture3DEXT');
    glNamedFramebufferRenderbufferEXT := gl_GetProc('glNamedFramebufferRenderbufferEXT');
    glGetNamedFramebufferAttachmentParameterivEXT := gl_GetProc('glGetNamedFramebufferAttachmentParameterivEXT');
    glGenerateTextureMipmapEXT := gl_GetProc('glGenerateTextureMipmapEXT');
    glGenerateMultiTexMipmapEXT := gl_GetProc('glGenerateMultiTexMipmapEXT');
    glFramebufferDrawBufferEXT := gl_GetProc('glFramebufferDrawBufferEXT');
    glFramebufferDrawBuffersEXT := gl_GetProc('glFramebufferDrawBuffersEXT');
    glFramebufferReadBufferEXT := gl_GetProc('glFramebufferReadBufferEXT');
    glGetFramebufferParameterivEXT := gl_GetProc('glGetFramebufferParameterivEXT');
    glNamedCopyBufferSubDataEXT := gl_GetProc('glNamedCopyBufferSubDataEXT');
    glNamedFramebufferTextureEXT := gl_GetProc('glNamedFramebufferTextureEXT');
    glNamedFramebufferTextureLayerEXT := gl_GetProc('glNamedFramebufferTextureLayerEXT');
    glNamedFramebufferTextureFaceEXT := gl_GetProc('glNamedFramebufferTextureFaceEXT');
    glTextureRenderbufferEXT := gl_GetProc('glTextureRenderbufferEXT');
    glMultiTexRenderbufferEXT := gl_GetProc('glMultiTexRenderbufferEXT');
    glVertexArrayVertexOffsetEXT := gl_GetProc('glVertexArrayVertexOffsetEXT');
    glVertexArrayColorOffsetEXT := gl_GetProc('glVertexArrayColorOffsetEXT');
    glVertexArrayEdgeFlagOffsetEXT := gl_GetProc('glVertexArrayEdgeFlagOffsetEXT');
    glVertexArrayIndexOffsetEXT := gl_GetProc('glVertexArrayIndexOffsetEXT');
    glVertexArrayNormalOffsetEXT := gl_GetProc('glVertexArrayNormalOffsetEXT');
    glVertexArrayTexCoordOffsetEXT := gl_GetProc('glVertexArrayTexCoordOffsetEXT');
    glVertexArrayMultiTexCoordOffsetEXT := gl_GetProc('glVertexArrayMultiTexCoordOffsetEXT');
    glVertexArrayFogCoordOffsetEXT := gl_GetProc('glVertexArrayFogCoordOffsetEXT');
    glVertexArraySecondaryColorOffsetEXT := gl_GetProc('glVertexArraySecondaryColorOffsetEXT');
    glVertexArrayVertexAttribOffsetEXT := gl_GetProc('glVertexArrayVertexAttribOffsetEXT');
    glVertexArrayVertexAttribIOffsetEXT := gl_GetProc('glVertexArrayVertexAttribIOffsetEXT');
    glEnableVertexArrayEXT := gl_GetProc('glEnableVertexArrayEXT');
    glDisableVertexArrayEXT := gl_GetProc('glDisableVertexArrayEXT');
    glEnableVertexArrayAttribEXT := gl_GetProc('glEnableVertexArrayAttribEXT');
    glDisableVertexArrayAttribEXT := gl_GetProc('glDisableVertexArrayAttribEXT');
    glGetVertexArrayIntegervEXT := gl_GetProc('glGetVertexArrayIntegervEXT');
    glGetVertexArrayPointervEXT := gl_GetProc('glGetVertexArrayPointervEXT');
    glGetVertexArrayIntegeri_vEXT := gl_GetProc('glGetVertexArrayIntegeri_vEXT');
    glGetVertexArrayPointeri_vEXT := gl_GetProc('glGetVertexArrayPointeri_vEXT');
    glMapNamedBufferRangeEXT := gl_GetProc('glMapNamedBufferRangeEXT');
    glFlushMappedNamedBufferRangeEXT := gl_GetProc('glFlushMappedNamedBufferRangeEXT');
    glNamedBufferStorageEXT := gl_GetProc('glNamedBufferStorageEXT');
    glClearNamedBufferDataEXT := gl_GetProc('glClearNamedBufferDataEXT');
    glClearNamedBufferSubDataEXT := gl_GetProc('glClearNamedBufferSubDataEXT');
    glNamedFramebufferParameteriEXT := gl_GetProc('glNamedFramebufferParameteriEXT');
    glGetNamedFramebufferParameterivEXT := gl_GetProc('glGetNamedFramebufferParameterivEXT');
    glProgramUniform1dEXT := gl_GetProc('glProgramUniform1dEXT');
    glProgramUniform2dEXT := gl_GetProc('glProgramUniform2dEXT');
    glProgramUniform3dEXT := gl_GetProc('glProgramUniform3dEXT');
    glProgramUniform4dEXT := gl_GetProc('glProgramUniform4dEXT');
    glProgramUniform1dvEXT := gl_GetProc('glProgramUniform1dvEXT');
    glProgramUniform2dvEXT := gl_GetProc('glProgramUniform2dvEXT');
    glProgramUniform3dvEXT := gl_GetProc('glProgramUniform3dvEXT');
    glProgramUniform4dvEXT := gl_GetProc('glProgramUniform4dvEXT');
    glProgramUniformMatrix2dvEXT := gl_GetProc('glProgramUniformMatrix2dvEXT');
    glProgramUniformMatrix3dvEXT := gl_GetProc('glProgramUniformMatrix3dvEXT');
    glProgramUniformMatrix4dvEXT := gl_GetProc('glProgramUniformMatrix4dvEXT');
    glProgramUniformMatrix2x3dvEXT := gl_GetProc('glProgramUniformMatrix2x3dvEXT');
    glProgramUniformMatrix2x4dvEXT := gl_GetProc('glProgramUniformMatrix2x4dvEXT');
    glProgramUniformMatrix3x2dvEXT := gl_GetProc('glProgramUniformMatrix3x2dvEXT');
    glProgramUniformMatrix3x4dvEXT := gl_GetProc('glProgramUniformMatrix3x4dvEXT');
    glProgramUniformMatrix4x2dvEXT := gl_GetProc('glProgramUniformMatrix4x2dvEXT');
    glProgramUniformMatrix4x3dvEXT := gl_GetProc('glProgramUniformMatrix4x3dvEXT');
    glTextureBufferRangeEXT := gl_GetProc('glTextureBufferRangeEXT');
    glTextureStorage1DEXT := gl_GetProc('glTextureStorage1DEXT');
    glTextureStorage2DEXT := gl_GetProc('glTextureStorage2DEXT');
    glTextureStorage3DEXT := gl_GetProc('glTextureStorage3DEXT');
    glTextureStorage2DMultisampleEXT := gl_GetProc('glTextureStorage2DMultisampleEXT');
    glTextureStorage3DMultisampleEXT := gl_GetProc('glTextureStorage3DMultisampleEXT');
    glVertexArrayBindVertexBufferEXT := gl_GetProc('glVertexArrayBindVertexBufferEXT');
    glVertexArrayVertexAttribFormatEXT := gl_GetProc('glVertexArrayVertexAttribFormatEXT');
    glVertexArrayVertexAttribIFormatEXT := gl_GetProc('glVertexArrayVertexAttribIFormatEXT');
    glVertexArrayVertexAttribLFormatEXT := gl_GetProc('glVertexArrayVertexAttribLFormatEXT');
    glVertexArrayVertexAttribBindingEXT := gl_GetProc('glVertexArrayVertexAttribBindingEXT');
    glVertexArrayVertexBindingDivisorEXT := gl_GetProc('glVertexArrayVertexBindingDivisorEXT');
    glVertexArrayVertexAttribLOffsetEXT := gl_GetProc('glVertexArrayVertexAttribLOffsetEXT');
    glTexturePageCommitmentEXT := gl_GetProc('glTexturePageCommitmentEXT');
    glVertexArrayVertexAttribDivisorEXT := gl_GetProc('glVertexArrayVertexAttribDivisorEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_draw_buffers2}
  if GL_EXT_draw_buffers2 then
    glColorMaskIndexedEXT := gl_GetProc('glColorMaskIndexedEXT');
  {$EndIf}

  {$IfDef GL_EXT_draw_instanced}
  if GL_EXT_draw_instanced then
  begin
    glDrawArraysInstancedEXT := gl_GetProc('glDrawArraysInstancedEXT');
    glDrawElementsInstancedEXT := gl_GetProc('glDrawElementsInstancedEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_draw_range_elements}
  if GL_EXT_draw_range_elements then
    glDrawRangeElementsEXT := gl_GetProc('glDrawRangeElementsEXT');
  {$EndIf}

  {$IfDef GL_EXT_external_buffer}
  if GL_EXT_external_buffer then
  begin
    glBufferStorageExternalEXT := gl_GetProc('glBufferStorageExternalEXT');
    glNamedBufferStorageExternalEXT := gl_GetProc('glNamedBufferStorageExternalEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_fog_coord}
  if GL_EXT_fog_coord then
  begin
    glFogCoordfEXT := gl_GetProc('glFogCoordfEXT');
    glFogCoordfvEXT := gl_GetProc('glFogCoordfvEXT');
    glFogCoorddEXT := gl_GetProc('glFogCoorddEXT');
    glFogCoorddvEXT := gl_GetProc('glFogCoorddvEXT');
    glFogCoordPointerEXT := gl_GetProc('glFogCoordPointerEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_framebuffer_blit}
  if GL_EXT_framebuffer_blit then
    glBlitFramebufferEXT := gl_GetProc('glBlitFramebufferEXT');
  {$EndIf}

  {$IfDef GL_EXT_framebuffer_multisample}
  if GL_EXT_framebuffer_multisample then
    glRenderbufferStorageMultisampleEXT := gl_GetProc('glRenderbufferStorageMultisampleEXT');
  {$EndIf}

  {$IfDef GL_EXT_framebuffer_object}
  if GL_EXT_framebuffer_object then
  begin
//    glIsRenderbufferEXT := gl_GetProc('glIsRenderbufferEXT');
//    glBindRenderbufferEXT := gl_GetProc('glBindRenderbufferEXT');
//    glDeleteRenderbuffersEXT := gl_GetProc('glDeleteRenderbuffersEXT');
//    glGenRenderbuffersEXT := gl_GetProc('glGenRenderbuffersEXT');
//    glRenderbufferStorageEXT := gl_GetProc('glRenderbufferStorageEXT');
    glGetRenderbufferParameterivEXT := gl_GetProc('glGetRenderbufferParameterivEXT');
//    glIsFramebufferEXT := gl_GetProc('glIsFramebufferEXT');
//    glBindFramebufferEXT := gl_GetProc('glBindFramebufferEXT');
//    glDeleteFramebuffersEXT := gl_GetProc('glDeleteFramebuffersEXT');
//    glGenFramebuffersEXT := gl_GetProc('glGenFramebuffersEXT');
//    glCheckFramebufferStatusEXT := gl_GetProc('glCheckFramebufferStatusEXT');
    glFramebufferTexture1DEXT := gl_GetProc('glFramebufferTexture1DEXT');
//    glFramebufferTexture2DEXT := gl_GetProc('glFramebufferTexture2DEXT');
    glFramebufferTexture3DEXT := gl_GetProc('glFramebufferTexture3DEXT');
//    glFramebufferRenderbufferEXT := gl_GetProc('glFramebufferRenderbufferEXT');
    glGetFramebufferAttachmentParameterivEXT := gl_GetProc('glGetFramebufferAttachmentParameterivEXT');
    glGenerateMipmapEXT := gl_GetProc('glGenerateMipmapEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_geometry_shader4}
  if GL_EXT_geometry_shader4 then
    glProgramParameteriEXT := gl_GetProc('glProgramParameteriEXT');
  {$EndIf}

  {$IfDef GL_EXT_gpu_program_parameters}
  if GL_EXT_gpu_program_parameters then
  begin
    glProgramEnvParameters4fvEXT := gl_GetProc('glProgramEnvParameters4fvEXT');
    glProgramLocalParameters4fvEXT := gl_GetProc('glProgramLocalParameters4fvEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_gpu_shader4}
  if GL_EXT_gpu_shader4 then
  begin
    glGetUniformuivEXT := gl_GetProc('glGetUniformuivEXT');
    glBindFragDataLocationEXT := gl_GetProc('glBindFragDataLocationEXT');
    glGetFragDataLocationEXT := gl_GetProc('glGetFragDataLocationEXT');
    glUniform1uiEXT := gl_GetProc('glUniform1uiEXT');
    glUniform2uiEXT := gl_GetProc('glUniform2uiEXT');
    glUniform3uiEXT := gl_GetProc('glUniform3uiEXT');
    glUniform4uiEXT := gl_GetProc('glUniform4uiEXT');
    glUniform1uivEXT := gl_GetProc('glUniform1uivEXT');
    glUniform2uivEXT := gl_GetProc('glUniform2uivEXT');
    glUniform3uivEXT := gl_GetProc('glUniform3uivEXT');
    glUniform4uivEXT := gl_GetProc('glUniform4uivEXT');
    glVertexAttribI1iEXT := gl_GetProc('glVertexAttribI1iEXT');
    glVertexAttribI2iEXT := gl_GetProc('glVertexAttribI2iEXT');
    glVertexAttribI3iEXT := gl_GetProc('glVertexAttribI3iEXT');
    glVertexAttribI4iEXT := gl_GetProc('glVertexAttribI4iEXT');
    glVertexAttribI1uiEXT := gl_GetProc('glVertexAttribI1uiEXT');
    glVertexAttribI2uiEXT := gl_GetProc('glVertexAttribI2uiEXT');
    glVertexAttribI3uiEXT := gl_GetProc('glVertexAttribI3uiEXT');
    glVertexAttribI4uiEXT := gl_GetProc('glVertexAttribI4uiEXT');
    glVertexAttribI1ivEXT := gl_GetProc('glVertexAttribI1ivEXT');
    glVertexAttribI2ivEXT := gl_GetProc('glVertexAttribI2ivEXT');
    glVertexAttribI3ivEXT := gl_GetProc('glVertexAttribI3ivEXT');
    glVertexAttribI4ivEXT := gl_GetProc('glVertexAttribI4ivEXT');
    glVertexAttribI1uivEXT := gl_GetProc('glVertexAttribI1uivEXT');
    glVertexAttribI2uivEXT := gl_GetProc('glVertexAttribI2uivEXT');
    glVertexAttribI3uivEXT := gl_GetProc('glVertexAttribI3uivEXT');
    glVertexAttribI4uivEXT := gl_GetProc('glVertexAttribI4uivEXT');
    glVertexAttribI4bvEXT := gl_GetProc('glVertexAttribI4bvEXT');
    glVertexAttribI4svEXT := gl_GetProc('glVertexAttribI4svEXT');
    glVertexAttribI4ubvEXT := gl_GetProc('glVertexAttribI4ubvEXT');
    glVertexAttribI4usvEXT := gl_GetProc('glVertexAttribI4usvEXT');
    glVertexAttribIPointerEXT := gl_GetProc('glVertexAttribIPointerEXT');
    glGetVertexAttribIivEXT := gl_GetProc('glGetVertexAttribIivEXT');
    glGetVertexAttribIuivEXT := gl_GetProc('glGetVertexAttribIuivEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_histogram}
  if GL_EXT_histogram then
  begin
    glGetHistogramEXT := gl_GetProc('glGetHistogramEXT');
    glGetHistogramParameterfvEXT := gl_GetProc('glGetHistogramParameterfvEXT');
    glGetHistogramParameterivEXT := gl_GetProc('glGetHistogramParameterivEXT');
    glGetMinmaxEXT := gl_GetProc('glGetMinmaxEXT');
    glGetMinmaxParameterfvEXT := gl_GetProc('glGetMinmaxParameterfvEXT');
    glGetMinmaxParameterivEXT := gl_GetProc('glGetMinmaxParameterivEXT');
    glHistogramEXT := gl_GetProc('glHistogramEXT');
    glMinmaxEXT := gl_GetProc('glMinmaxEXT');
    glResetHistogramEXT := gl_GetProc('glResetHistogramEXT');
    glResetMinmaxEXT := gl_GetProc('glResetMinmaxEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_index_func}
  if GL_EXT_index_func then
    glIndexFuncEXT := gl_GetProc('glIndexFuncEXT');
  {$EndIf}

  {$IfDef GL_EXT_index_material}
  if GL_EXT_index_material then
    glIndexMaterialEXT := gl_GetProc('glIndexMaterialEXT');
  {$EndIf}

  {$IfDef GL_EXT_light_texture}
  if GL_EXT_light_texture then
  begin
    glApplyTextureEXT := gl_GetProc('glApplyTextureEXT');
    glTextureLightEXT := gl_GetProc('glTextureLightEXT');
    glTextureMaterialEXT := gl_GetProc('glTextureMaterialEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_memory_object}
  if GL_EXT_memory_object then
  begin
    glGetUnsignedBytevEXT := gl_GetProc('glGetUnsignedBytevEXT');
    glGetUnsignedBytei_vEXT := gl_GetProc('glGetUnsignedBytei_vEXT');
    glDeleteMemoryObjectsEXT := gl_GetProc('glDeleteMemoryObjectsEXT');
    glIsMemoryObjectEXT := gl_GetProc('glIsMemoryObjectEXT');
    glCreateMemoryObjectsEXT := gl_GetProc('glCreateMemoryObjectsEXT');
    glMemoryObjectParameterivEXT := gl_GetProc('glMemoryObjectParameterivEXT');
    glGetMemoryObjectParameterivEXT := gl_GetProc('glGetMemoryObjectParameterivEXT');
    glTexStorageMem2DEXT := gl_GetProc('glTexStorageMem2DEXT');
    glTexStorageMem2DMultisampleEXT := gl_GetProc('glTexStorageMem2DMultisampleEXT');
    glTexStorageMem3DEXT := gl_GetProc('glTexStorageMem3DEXT');
    glTexStorageMem3DMultisampleEXT := gl_GetProc('glTexStorageMem3DMultisampleEXT');
    glBufferStorageMemEXT := gl_GetProc('glBufferStorageMemEXT');
    glTextureStorageMem2DEXT := gl_GetProc('glTextureStorageMem2DEXT');
    glTextureStorageMem2DMultisampleEXT := gl_GetProc('glTextureStorageMem2DMultisampleEXT');
    glTextureStorageMem3DEXT := gl_GetProc('glTextureStorageMem3DEXT');
    glTextureStorageMem3DMultisampleEXT := gl_GetProc('glTextureStorageMem3DMultisampleEXT');
    glNamedBufferStorageMemEXT := gl_GetProc('glNamedBufferStorageMemEXT');
    glTexStorageMem1DEXT := gl_GetProc('glTexStorageMem1DEXT');
    glTextureStorageMem1DEXT := gl_GetProc('glTextureStorageMem1DEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_memory_object_fd}
  if GL_EXT_memory_object_fd then
    glImportMemoryFdEXT := gl_GetProc('glImportMemoryFdEXT');
  {$EndIf}

  {$IfDef GL_EXT_memory_object_win32}
  if GL_EXT_memory_object_win32 then
  begin
    glImportMemoryWin32HandleEXT := gl_GetProc('glImportMemoryWin32HandleEXT');
    glImportMemoryWin32NameEXT := gl_GetProc('glImportMemoryWin32NameEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_multi_draw_arrays}
  if GL_EXT_multi_draw_arrays then
  begin
    glMultiDrawArraysEXT := gl_GetProc('glMultiDrawArraysEXT');
    glMultiDrawElementsEXT := gl_GetProc('glMultiDrawElementsEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_multisample}
  if GL_EXT_multisample then
  begin
    glSampleMaskEXT := gl_GetProc('glSampleMaskEXT');
    glSamplePatternEXT := gl_GetProc('glSamplePatternEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_paletted_texture}
  if GL_EXT_paletted_texture then
  begin
    glColorTableEXT := gl_GetProc('glColorTableEXT');
    glGetColorTableEXT := gl_GetProc('glGetColorTableEXT');
    glGetColorTableParameterivEXT := gl_GetProc('glGetColorTableParameterivEXT');
    glGetColorTableParameterfvEXT := gl_GetProc('glGetColorTableParameterfvEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_pixel_transform}
  if GL_EXT_pixel_transform then
  begin
    glPixelTransformParameteriEXT := gl_GetProc('glPixelTransformParameteriEXT');
    glPixelTransformParameterfEXT := gl_GetProc('glPixelTransformParameterfEXT');
    glPixelTransformParameterivEXT := gl_GetProc('glPixelTransformParameterivEXT');
    glPixelTransformParameterfvEXT := gl_GetProc('glPixelTransformParameterfvEXT');
    glGetPixelTransformParameterivEXT := gl_GetProc('glGetPixelTransformParameterivEXT');
    glGetPixelTransformParameterfvEXT := gl_GetProc('glGetPixelTransformParameterfvEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_point_parameters}
  if GL_EXT_point_parameters then
  begin
    glPointParameterfEXT := gl_GetProc('glPointParameterfEXT');
    glPointParameterfvEXT := gl_GetProc('glPointParameterfvEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_polygon_offset}
  if GL_EXT_polygon_offset then
    glPolygonOffsetEXT := gl_GetProc('glPolygonOffsetEXT');
  {$EndIf}

  {$IfDef GL_EXT_polygon_offset_clamp}
  if GL_EXT_polygon_offset_clamp then
    glPolygonOffsetClampEXT := gl_GetProc('glPolygonOffsetClampEXT');
  {$EndIf}

  {$IfDef GL_EXT_provoking_vertex}
  if GL_EXT_provoking_vertex then
    glProvokingVertexEXT := gl_GetProc('glProvokingVertexEXT');
  {$EndIf}

  {$IfDef GL_EXT_raster_multisample}
  if GL_EXT_raster_multisample then
    glRasterSamplesEXT := gl_GetProc('glRasterSamplesEXT');
  {$EndIf}

  {$IfDef GL_EXT_secondary_color}
  if GL_EXT_secondary_color then
  begin
    glSecondaryColor3bEXT := gl_GetProc('glSecondaryColor3bEXT');
    glSecondaryColor3bvEXT := gl_GetProc('glSecondaryColor3bvEXT');
    glSecondaryColor3dEXT := gl_GetProc('glSecondaryColor3dEXT');
    glSecondaryColor3dvEXT := gl_GetProc('glSecondaryColor3dvEXT');
    glSecondaryColor3fEXT := gl_GetProc('glSecondaryColor3fEXT');
    glSecondaryColor3fvEXT := gl_GetProc('glSecondaryColor3fvEXT');
    glSecondaryColor3iEXT := gl_GetProc('glSecondaryColor3iEXT');
    glSecondaryColor3ivEXT := gl_GetProc('glSecondaryColor3ivEXT');
    glSecondaryColor3sEXT := gl_GetProc('glSecondaryColor3sEXT');
    glSecondaryColor3svEXT := gl_GetProc('glSecondaryColor3svEXT');
    glSecondaryColor3ubEXT := gl_GetProc('glSecondaryColor3ubEXT');
    glSecondaryColor3ubvEXT := gl_GetProc('glSecondaryColor3ubvEXT');
    glSecondaryColor3uiEXT := gl_GetProc('glSecondaryColor3uiEXT');
    glSecondaryColor3uivEXT := gl_GetProc('glSecondaryColor3uivEXT');
    glSecondaryColor3usEXT := gl_GetProc('glSecondaryColor3usEXT');
    glSecondaryColor3usvEXT := gl_GetProc('glSecondaryColor3usvEXT');
    glSecondaryColorPointerEXT := gl_GetProc('glSecondaryColorPointerEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_semaphore}
  if GL_EXT_semaphore then
  begin
    glGenSemaphoresEXT := gl_GetProc('glGenSemaphoresEXT');
    glDeleteSemaphoresEXT := gl_GetProc('glDeleteSemaphoresEXT');
    glGetSemaphoreParameterui64vEXT := gl_GetProc('glGetSemaphoreParameterui64vEXT');
    glIsSemaphoreEXT := gl_GetProc('glIsSemaphoreEXT');
    glSemaphoreParameterui64vEXT := gl_GetProc('glSemaphoreParameterui64vEXT');
    glWaitSemaphoreEXT := gl_GetProc('glWaitSemaphoreEXT');
    glSignalSemaphoreEXT := gl_GetProc('glSignalSemaphoreEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_semaphore_fd}
  if GL_EXT_semaphore_fd then
    glImportSemaphoreFdEXT := gl_GetProc('glImportSemaphoreFdEXT');
  {$EndIf}

  {$IfDef GL_EXT_semaphore_win32}
  if GL_EXT_semaphore_win32 then
  begin
    glImportSemaphoreWin32HandleEXT := gl_GetProc('glImportSemaphoreWin32HandleEXT');
    glImportSemaphoreWin32NameEXT := gl_GetProc('glImportSemaphoreWin32NameEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_separate_shader_objects}
  if GL_EXT_separate_shader_objects then
  begin
    glUseShaderProgramEXT := gl_GetProc('glUseShaderProgramEXT');
    glActiveProgramEXT := gl_GetProc('glActiveProgramEXT');
    glCreateShaderProgramEXT := gl_GetProc('glCreateShaderProgramEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_shader_framebuffer_fetch_non_coherent}
  if GL_EXT_shader_framebuffer_fetch_non_coherent then
    glFramebufferFetchBarrierEXT := gl_GetProc('glFramebufferFetchBarrierEXT');
  {$EndIf}

  {$IfDef GL_EXT_shader_image_load_store}
  if GL_EXT_shader_image_load_store then
  begin
    glBindImageTextureEXT := gl_GetProc('glBindImageTextureEXT');
    glMemoryBarrierEXT := gl_GetProc('glMemoryBarrierEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_stencil_clear_tag}
  if GL_EXT_stencil_clear_tag then
    glStencilClearTagEXT := gl_GetProc('glStencilClearTagEXT');
  {$EndIf}

  {$IfDef GL_EXT_stencil_two_side}
  if GL_EXT_stencil_two_side then
    glActiveStencilFaceEXT := gl_GetProc('glActiveStencilFaceEXT');
  {$EndIf}

  {$IfDef GL_EXT_subtexture}
  if GL_EXT_subtexture then
  begin
    glTexSubImage1DEXT := gl_GetProc('glTexSubImage1DEXT');
    glTexSubImage2DEXT := gl_GetProc('glTexSubImage2DEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_texture3D}
  if GL_EXT_texture3D then
  begin
    glTexImage3DEXT := gl_GetProc('glTexImage3DEXT');
    glTexSubImage3DEXT := gl_GetProc('glTexSubImage3DEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_texture_array}
  if GL_EXT_texture_array then
    glFramebufferTextureLayerEXT := gl_GetProc('glFramebufferTextureLayerEXT');
  {$EndIf}

  {$IfDef GL_EXT_texture_buffer_object}
  if GL_EXT_texture_buffer_object then
    glTexBufferEXT := gl_GetProc('glTexBufferEXT');
  {$EndIf}

  {$IfDef GL_EXT_texture_integer}
  if GL_EXT_texture_integer then
  begin
    glTexParameterIivEXT := gl_GetProc('glTexParameterIivEXT');
    glTexParameterIuivEXT := gl_GetProc('glTexParameterIuivEXT');
    glGetTexParameterIivEXT := gl_GetProc('glGetTexParameterIivEXT');
    glGetTexParameterIuivEXT := gl_GetProc('glGetTexParameterIuivEXT');
    glClearColorIiEXT := gl_GetProc('glClearColorIiEXT');
    glClearColorIuiEXT := gl_GetProc('glClearColorIuiEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_texture_object}
  if GL_EXT_texture_object then
  begin
    glAreTexturesResidentEXT := gl_GetProc('glAreTexturesResidentEXT');
    glBindTextureEXT := gl_GetProc('glBindTextureEXT');
    glDeleteTexturesEXT := gl_GetProc('glDeleteTexturesEXT');
    glGenTexturesEXT := gl_GetProc('glGenTexturesEXT');
    glIsTextureEXT := gl_GetProc('glIsTextureEXT');
    glPrioritizeTexturesEXT := gl_GetProc('glPrioritizeTexturesEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_texture_perturb_normal}
  if GL_EXT_texture_perturb_normal then
    glTextureNormalEXT := gl_GetProc('glTextureNormalEXT');
  {$EndIf}

  {$IfDef GL_EXT_texture_storage}
  if GL_EXT_texture_storage then
  begin
    glTexStorage1DEXT := gl_GetProc('glTexStorage1DEXT');
    glTexStorage2DEXT := gl_GetProc('glTexStorage2DEXT');
    glTexStorage3DEXT := gl_GetProc('glTexStorage3DEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_timer_query}
  if GL_EXT_timer_query then
  begin
    glGetQueryObjecti64vEXT := gl_GetProc('glGetQueryObjecti64vEXT');
    glGetQueryObjectui64vEXT := gl_GetProc('glGetQueryObjectui64vEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_transform_feedback}
  if GL_EXT_transform_feedback then
  begin
    glBeginTransformFeedbackEXT := gl_GetProc('glBeginTransformFeedbackEXT');
    glEndTransformFeedbackEXT := gl_GetProc('glEndTransformFeedbackEXT');
    glBindBufferRangeEXT := gl_GetProc('glBindBufferRangeEXT');
    glBindBufferOffsetEXT := gl_GetProc('glBindBufferOffsetEXT');
    glBindBufferBaseEXT := gl_GetProc('glBindBufferBaseEXT');
    glTransformFeedbackVaryingsEXT := gl_GetProc('glTransformFeedbackVaryingsEXT');
    glGetTransformFeedbackVaryingEXT := gl_GetProc('glGetTransformFeedbackVaryingEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_vertex_array}
  if GL_EXT_vertex_array then
  begin
    glArrayElementEXT := gl_GetProc('glArrayElementEXT');
    glColorPointerEXT := gl_GetProc('glColorPointerEXT');
    glDrawArraysEXT := gl_GetProc('glDrawArraysEXT');
    glEdgeFlagPointerEXT := gl_GetProc('glEdgeFlagPointerEXT');
    glGetPointervEXT := gl_GetProc('glGetPointervEXT');
    glIndexPointerEXT := gl_GetProc('glIndexPointerEXT');
    glNormalPointerEXT := gl_GetProc('glNormalPointerEXT');
    glTexCoordPointerEXT := gl_GetProc('glTexCoordPointerEXT');
    glVertexPointerEXT := gl_GetProc('glVertexPointerEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_vertex_attrib_64bit}
  if GL_EXT_vertex_attrib_64bit then
  begin
    glVertexAttribL1dEXT := gl_GetProc('glVertexAttribL1dEXT');
    glVertexAttribL2dEXT := gl_GetProc('glVertexAttribL2dEXT');
    glVertexAttribL3dEXT := gl_GetProc('glVertexAttribL3dEXT');
    glVertexAttribL4dEXT := gl_GetProc('glVertexAttribL4dEXT');
    glVertexAttribL1dvEXT := gl_GetProc('glVertexAttribL1dvEXT');
    glVertexAttribL2dvEXT := gl_GetProc('glVertexAttribL2dvEXT');
    glVertexAttribL3dvEXT := gl_GetProc('glVertexAttribL3dvEXT');
    glVertexAttribL4dvEXT := gl_GetProc('glVertexAttribL4dvEXT');
    glVertexAttribLPointerEXT := gl_GetProc('glVertexAttribLPointerEXT');
    glGetVertexAttribLdvEXT := gl_GetProc('glGetVertexAttribLdvEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_vertex_shader}
  if GL_EXT_vertex_shader then
  begin
    glBeginVertexShaderEXT := gl_GetProc('glBeginVertexShaderEXT');
    glEndVertexShaderEXT := gl_GetProc('glEndVertexShaderEXT');
    glBindVertexShaderEXT := gl_GetProc('glBindVertexShaderEXT');
    glGenVertexShadersEXT := gl_GetProc('glGenVertexShadersEXT');
    glDeleteVertexShaderEXT := gl_GetProc('glDeleteVertexShaderEXT');
    glShaderOp1EXT := gl_GetProc('glShaderOp1EXT');
    glShaderOp2EXT := gl_GetProc('glShaderOp2EXT');
    glShaderOp3EXT := gl_GetProc('glShaderOp3EXT');
    glSwizzleEXT := gl_GetProc('glSwizzleEXT');
    glWriteMaskEXT := gl_GetProc('glWriteMaskEXT');
    glInsertComponentEXT := gl_GetProc('glInsertComponentEXT');
    glExtractComponentEXT := gl_GetProc('glExtractComponentEXT');
    glGenSymbolsEXT := gl_GetProc('glGenSymbolsEXT');
    glSetInvariantEXT := gl_GetProc('glSetInvariantEXT');
    glSetLocalConstantEXT := gl_GetProc('glSetLocalConstantEXT');
    glVariantbvEXT := gl_GetProc('glVariantbvEXT');
    glVariantsvEXT := gl_GetProc('glVariantsvEXT');
    glVariantivEXT := gl_GetProc('glVariantivEXT');
    glVariantfvEXT := gl_GetProc('glVariantfvEXT');
    glVariantdvEXT := gl_GetProc('glVariantdvEXT');
    glVariantubvEXT := gl_GetProc('glVariantubvEXT');
    glVariantusvEXT := gl_GetProc('glVariantusvEXT');
    glVariantuivEXT := gl_GetProc('glVariantuivEXT');
    glVariantPointerEXT := gl_GetProc('glVariantPointerEXT');
    glEnableVariantClientStateEXT := gl_GetProc('glEnableVariantClientStateEXT');
    glDisableVariantClientStateEXT := gl_GetProc('glDisableVariantClientStateEXT');
    glBindLightParameterEXT := gl_GetProc('glBindLightParameterEXT');
    glBindMaterialParameterEXT := gl_GetProc('glBindMaterialParameterEXT');
    glBindTexGenParameterEXT := gl_GetProc('glBindTexGenParameterEXT');
    glBindTextureUnitParameterEXT := gl_GetProc('glBindTextureUnitParameterEXT');
    glBindParameterEXT := gl_GetProc('glBindParameterEXT');
    glIsVariantEnabledEXT := gl_GetProc('glIsVariantEnabledEXT');
    glGetVariantBooleanvEXT := gl_GetProc('glGetVariantBooleanvEXT');
    glGetVariantIntegervEXT := gl_GetProc('glGetVariantIntegervEXT');
    glGetVariantFloatvEXT := gl_GetProc('glGetVariantFloatvEXT');
    glGetVariantPointervEXT := gl_GetProc('glGetVariantPointervEXT');
    glGetInvariantBooleanvEXT := gl_GetProc('glGetInvariantBooleanvEXT');
    glGetInvariantIntegervEXT := gl_GetProc('glGetInvariantIntegervEXT');
    glGetInvariantFloatvEXT := gl_GetProc('glGetInvariantFloatvEXT');
    glGetLocalConstantBooleanvEXT := gl_GetProc('glGetLocalConstantBooleanvEXT');
    glGetLocalConstantIntegervEXT := gl_GetProc('glGetLocalConstantIntegervEXT');
    glGetLocalConstantFloatvEXT := gl_GetProc('glGetLocalConstantFloatvEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_vertex_weighting}
  if GL_EXT_vertex_weighting then
  begin
    glVertexWeightfEXT := gl_GetProc('glVertexWeightfEXT');
    glVertexWeightfvEXT := gl_GetProc('glVertexWeightfvEXT');
    glVertexWeightPointerEXT := gl_GetProc('glVertexWeightPointerEXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_win32_keyed_mutex}
  if GL_EXT_win32_keyed_mutex then
  begin
    glAcquireKeyedMutexWin32EXT := gl_GetProc('glAcquireKeyedMutexWin32EXT');
    glReleaseKeyedMutexWin32EXT := gl_GetProc('glReleaseKeyedMutexWin32EXT');
  end;
  {$EndIf}

  {$IfDef GL_EXT_window_rectangles}
  if GL_EXT_window_rectangles then
    glWindowRectanglesEXT := gl_GetProc('glWindowRectanglesEXT');
  {$EndIf}

  {$IfDef GL_EXT_x11_sync_object}
  if GL_EXT_x11_sync_object then
    glImportSyncEXT := gl_GetProc('glImportSyncEXT');
  {$EndIf}

  {$IfDef GL_GREMEDY_frame_terminator}
  if GL_GREMEDY_frame_terminator then
    glFrameTerminatorGREMEDY := gl_GetProc('glFrameTerminatorGREMEDY');
  {$EndIf}

  {$IfDef GL_GREMEDY_string_marker}
  if GL_GREMEDY_string_marker then
    glStringMarkerGREMEDY := gl_GetProc('glStringMarkerGREMEDY');
  {$EndIf}

  {$IfDef GL_HP_image_transform}
  if GL_HP_image_transform then
  begin
    glImageTransformParameteriHP := gl_GetProc('glImageTransformParameteriHP');
    glImageTransformParameterfHP := gl_GetProc('glImageTransformParameterfHP');
    glImageTransformParameterivHP := gl_GetProc('glImageTransformParameterivHP');
    glImageTransformParameterfvHP := gl_GetProc('glImageTransformParameterfvHP');
    glGetImageTransformParameterivHP := gl_GetProc('glGetImageTransformParameterivHP');
    glGetImageTransformParameterfvHP := gl_GetProc('glGetImageTransformParameterfvHP');
  end;
  {$EndIf}

  {$IfDef GL_IBM_multimode_draw_arrays}
  if GL_IBM_multimode_draw_arrays then
  begin
    glMultiModeDrawArraysIBM := gl_GetProc('glMultiModeDrawArraysIBM');
    glMultiModeDrawElementsIBM := gl_GetProc('glMultiModeDrawElementsIBM');
  end;
  {$EndIf}

  {$IfDef GL_IBM_static_data}
  if GL_IBM_static_data then
    glFlushStaticDataIBM := gl_GetProc('glFlushStaticDataIBM');
  {$EndIf}

  {$IfDef GL_IBM_vertex_array_lists}
  if GL_IBM_vertex_array_lists then
  begin
    glColorPointerListIBM := gl_GetProc('glColorPointerListIBM');
    glSecondaryColorPointerListIBM := gl_GetProc('glSecondaryColorPointerListIBM');
    glEdgeFlagPointerListIBM := gl_GetProc('glEdgeFlagPointerListIBM');
    glFogCoordPointerListIBM := gl_GetProc('glFogCoordPointerListIBM');
    glIndexPointerListIBM := gl_GetProc('glIndexPointerListIBM');
    glNormalPointerListIBM := gl_GetProc('glNormalPointerListIBM');
    glTexCoordPointerListIBM := gl_GetProc('glTexCoordPointerListIBM');
    glVertexPointerListIBM := gl_GetProc('glVertexPointerListIBM');
  end;
  {$EndIf}

  {$IfDef GL_INGR_blend_func_separate}
  if GL_INGR_blend_func_separate then
    glBlendFuncSeparateINGR := gl_GetProc('glBlendFuncSeparateINGR');
  {$EndIf}

  {$IfDef GL_INTEL_framebuffer_CMAA}
  if GL_INTEL_framebuffer_CMAA then
    glApplyFramebufferAttachmentCMAAINTEL := gl_GetProc('glApplyFramebufferAttachmentCMAAINTEL');
  {$EndIf}

  {$IfDef GL_INTEL_map_texture}
  if GL_INTEL_map_texture then
  begin
    glSyncTextureINTEL := gl_GetProc('glSyncTextureINTEL');
    glUnmapTexture2DINTEL := gl_GetProc('glUnmapTexture2DINTEL');
    glMapTexture2DINTEL := gl_GetProc('glMapTexture2DINTEL');
  end;
  {$EndIf}

  {$IfDef GL_INTEL_parallel_arrays}
  if GL_INTEL_parallel_arrays then
  begin
    glVertexPointervINTEL := gl_GetProc('glVertexPointervINTEL');
    glNormalPointervINTEL := gl_GetProc('glNormalPointervINTEL');
    glColorPointervINTEL := gl_GetProc('glColorPointervINTEL');
    glTexCoordPointervINTEL := gl_GetProc('glTexCoordPointervINTEL');
  end;
  {$EndIf}

  {$IfDef GL_INTEL_performance_query}
  if GL_INTEL_performance_query then
  begin
    glBeginPerfQueryINTEL := gl_GetProc('glBeginPerfQueryINTEL');
    glCreatePerfQueryINTEL := gl_GetProc('glCreatePerfQueryINTEL');
    glDeletePerfQueryINTEL := gl_GetProc('glDeletePerfQueryINTEL');
    glEndPerfQueryINTEL := gl_GetProc('glEndPerfQueryINTEL');
    glGetFirstPerfQueryIdINTEL := gl_GetProc('glGetFirstPerfQueryIdINTEL');
    glGetNextPerfQueryIdINTEL := gl_GetProc('glGetNextPerfQueryIdINTEL');
    glGetPerfCounterInfoINTEL := gl_GetProc('glGetPerfCounterInfoINTEL');
    glGetPerfQueryDataINTEL := gl_GetProc('glGetPerfQueryDataINTEL');
    glGetPerfQueryIdByNameINTEL := gl_GetProc('glGetPerfQueryIdByNameINTEL');
    glGetPerfQueryInfoINTEL := gl_GetProc('glGetPerfQueryInfoINTEL');
  end;
  {$EndIf}

  {$IfDef GL_MESA_framebuffer_flip_y}
  if GL_MESA_framebuffer_flip_y then
  begin
    glFramebufferParameteriMESA := gl_GetProc('glFramebufferParameteriMESA');
    glGetFramebufferParameterivMESA := gl_GetProc('glGetFramebufferParameterivMESA');
  end;
  {$EndIf}

  {$IfDef GL_MESA_resize_buffers}
  if GL_MESA_resize_buffers then
    glResizeBuffersMESA := gl_GetProc('glResizeBuffersMESA');
  {$EndIf}

  {$IfDef GL_MESA_window_pos}
  if GL_MESA_window_pos then
  begin
    glWindowPos2dMESA := gl_GetProc('glWindowPos2dMESA');
    glWindowPos2dvMESA := gl_GetProc('glWindowPos2dvMESA');
    glWindowPos2fMESA := gl_GetProc('glWindowPos2fMESA');
    glWindowPos2fvMESA := gl_GetProc('glWindowPos2fvMESA');
    glWindowPos2iMESA := gl_GetProc('glWindowPos2iMESA');
    glWindowPos2ivMESA := gl_GetProc('glWindowPos2ivMESA');
    glWindowPos2sMESA := gl_GetProc('glWindowPos2sMESA');
    glWindowPos2svMESA := gl_GetProc('glWindowPos2svMESA');
    glWindowPos3dMESA := gl_GetProc('glWindowPos3dMESA');
    glWindowPos3dvMESA := gl_GetProc('glWindowPos3dvMESA');
    glWindowPos3fMESA := gl_GetProc('glWindowPos3fMESA');
    glWindowPos3fvMESA := gl_GetProc('glWindowPos3fvMESA');
    glWindowPos3iMESA := gl_GetProc('glWindowPos3iMESA');
    glWindowPos3ivMESA := gl_GetProc('glWindowPos3ivMESA');
    glWindowPos3sMESA := gl_GetProc('glWindowPos3sMESA');
    glWindowPos3svMESA := gl_GetProc('glWindowPos3svMESA');
    glWindowPos4dMESA := gl_GetProc('glWindowPos4dMESA');
    glWindowPos4dvMESA := gl_GetProc('glWindowPos4dvMESA');
    glWindowPos4fMESA := gl_GetProc('glWindowPos4fMESA');
    glWindowPos4fvMESA := gl_GetProc('glWindowPos4fvMESA');
    glWindowPos4iMESA := gl_GetProc('glWindowPos4iMESA');
    glWindowPos4ivMESA := gl_GetProc('glWindowPos4ivMESA');
    glWindowPos4sMESA := gl_GetProc('glWindowPos4sMESA');
    glWindowPos4svMESA := gl_GetProc('glWindowPos4svMESA');
  end;
  {$EndIf}

  {$IfDef GL_NVX_conditional_render}
  if GL_NVX_conditional_render then
  begin
    glBeginConditionalRenderNVX := gl_GetProc('glBeginConditionalRenderNVX');
    glEndConditionalRenderNVX := gl_GetProc('glEndConditionalRenderNVX');
  end;
  {$EndIf}

  {$IfDef GL_NVX_gpu_multicast2}
  if GL_NVX_gpu_multicast2 then
  begin
    glUploadGpuMaskNVX := gl_GetProc('glUploadGpuMaskNVX');
    glMulticastViewportArrayvNVX := gl_GetProc('glMulticastViewportArrayvNVX');
    glMulticastViewportPositionWScaleNVX := gl_GetProc('glMulticastViewportPositionWScaleNVX');
    glMulticastScissorArrayvNVX := gl_GetProc('glMulticastScissorArrayvNVX');
    glAsyncCopyBufferSubDataNVX := gl_GetProc('glAsyncCopyBufferSubDataNVX');
    glAsyncCopyImageSubDataNVX := gl_GetProc('glAsyncCopyImageSubDataNVX');
  end;
  {$EndIf}

  {$IfDef GL_NVX_linked_gpu_multicast}
  if GL_NVX_linked_gpu_multicast then
  begin
    glLGPUNamedBufferSubDataNVX := gl_GetProc('glLGPUNamedBufferSubDataNVX');
    glLGPUCopyImageSubDataNVX := gl_GetProc('glLGPUCopyImageSubDataNVX');
    glLGPUInterlockNVX := gl_GetProc('glLGPUInterlockNVX');
  end;
  {$EndIf}

  {$IfDef GL_NVX_progress_fence}
  if GL_NVX_progress_fence then
  begin
    glCreateProgressFenceNVX := gl_GetProc('glCreateProgressFenceNVX');
    glSignalSemaphoreui64NVX := gl_GetProc('glSignalSemaphoreui64NVX');
    glWaitSemaphoreui64NVX := gl_GetProc('glWaitSemaphoreui64NVX');
    glClientWaitSemaphoreui64NVX := gl_GetProc('glClientWaitSemaphoreui64NVX');
  end;
  {$EndIf}

  {$IfDef GL_NV_alpha_to_coverage_dither_control}
  if GL_NV_alpha_to_coverage_dither_control then
    glAlphaToCoverageDitherControlNV := gl_GetProc('glAlphaToCoverageDitherControlNV');
  {$EndIf}

  {$IfDef GL_NV_bindless_multi_draw_indirect}
  if GL_NV_bindless_multi_draw_indirect then
  begin
    glMultiDrawArraysIndirectBindlessNV := gl_GetProc('glMultiDrawArraysIndirectBindlessNV');
    glMultiDrawElementsIndirectBindlessNV := gl_GetProc('glMultiDrawElementsIndirectBindlessNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_bindless_multi_draw_indirect_count}
  if GL_NV_bindless_multi_draw_indirect_count then
  begin
    glMultiDrawArraysIndirectBindlessCountNV := gl_GetProc('glMultiDrawArraysIndirectBindlessCountNV');
    glMultiDrawElementsIndirectBindlessCountNV := gl_GetProc('glMultiDrawElementsIndirectBindlessCountNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_bindless_texture}
  if GL_NV_bindless_texture then
  begin
    glGetTextureHandleNV := gl_GetProc('glGetTextureHandleNV');
    glGetTextureSamplerHandleNV := gl_GetProc('glGetTextureSamplerHandleNV');
    glMakeTextureHandleResidentNV := gl_GetProc('glMakeTextureHandleResidentNV');
    glMakeTextureHandleNonResidentNV := gl_GetProc('glMakeTextureHandleNonResidentNV');
    glGetImageHandleNV := gl_GetProc('glGetImageHandleNV');
    glMakeImageHandleResidentNV := gl_GetProc('glMakeImageHandleResidentNV');
    glMakeImageHandleNonResidentNV := gl_GetProc('glMakeImageHandleNonResidentNV');
    glUniformHandleui64NV := gl_GetProc('glUniformHandleui64NV');
    glUniformHandleui64vNV := gl_GetProc('glUniformHandleui64vNV');
    glProgramUniformHandleui64NV := gl_GetProc('glProgramUniformHandleui64NV');
    glProgramUniformHandleui64vNV := gl_GetProc('glProgramUniformHandleui64vNV');
    glIsTextureHandleResidentNV := gl_GetProc('glIsTextureHandleResidentNV');
    glIsImageHandleResidentNV := gl_GetProc('glIsImageHandleResidentNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_blend_equation_advanced}
  if GL_NV_blend_equation_advanced then
  begin
    glBlendParameteriNV := gl_GetProc('glBlendParameteriNV');
    glBlendBarrierNV := gl_GetProc('glBlendBarrierNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_clip_space_w_scaling}
  if GL_NV_clip_space_w_scaling then
    glViewportPositionWScaleNV := gl_GetProc('glViewportPositionWScaleNV');
  {$EndIf}

  {$IfDef GL_NV_command_list}
  if GL_NV_command_list then
  begin
    glCreateStatesNV := gl_GetProc('glCreateStatesNV');
    glDeleteStatesNV := gl_GetProc('glDeleteStatesNV');
    glIsStateNV := gl_GetProc('glIsStateNV');
    glStateCaptureNV := gl_GetProc('glStateCaptureNV');
    glGetCommandHeaderNV := gl_GetProc('glGetCommandHeaderNV');
    glGetStageIndexNV := gl_GetProc('glGetStageIndexNV');
    glDrawCommandsNV := gl_GetProc('glDrawCommandsNV');
    glDrawCommandsAddressNV := gl_GetProc('glDrawCommandsAddressNV');
    glDrawCommandsStatesNV := gl_GetProc('glDrawCommandsStatesNV');
    glDrawCommandsStatesAddressNV := gl_GetProc('glDrawCommandsStatesAddressNV');
    glCreateCommandListsNV := gl_GetProc('glCreateCommandListsNV');
    glDeleteCommandListsNV := gl_GetProc('glDeleteCommandListsNV');
    glIsCommandListNV := gl_GetProc('glIsCommandListNV');
    glListDrawCommandsStatesClientNV := gl_GetProc('glListDrawCommandsStatesClientNV');
    glCommandListSegmentsNV := gl_GetProc('glCommandListSegmentsNV');
    glCompileCommandListNV := gl_GetProc('glCompileCommandListNV');
    glCallCommandListNV := gl_GetProc('glCallCommandListNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_conditional_render}
  if GL_NV_conditional_render then
  begin
    glBeginConditionalRenderNV := gl_GetProc('glBeginConditionalRenderNV');
    glEndConditionalRenderNV := gl_GetProc('glEndConditionalRenderNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_conservative_raster}
  if GL_NV_conservative_raster then
    glSubpixelPrecisionBiasNV := gl_GetProc('glSubpixelPrecisionBiasNV');
  {$EndIf}

  {$IfDef GL_NV_conservative_raster_dilate}
  if GL_NV_conservative_raster_dilate then
    glConservativeRasterParameterfNV := gl_GetProc('glConservativeRasterParameterfNV');
  {$EndIf}

  {$IfDef GL_NV_conservative_raster_pre_snap_triangles}
  if GL_NV_conservative_raster_pre_snap_triangles then
    glConservativeRasterParameteriNV := gl_GetProc('glConservativeRasterParameteriNV');
  {$EndIf}

  {$IfDef GL_NV_copy_image}
  if GL_NV_copy_image then
    glCopyImageSubDataNV := gl_GetProc('glCopyImageSubDataNV');
  {$EndIf}

  {$IfDef GL_NV_depth_buffer_float}
  if GL_NV_depth_buffer_float then
  begin
    glDepthRangedNV := gl_GetProc('glDepthRangedNV');
    glClearDepthdNV := gl_GetProc('glClearDepthdNV');
    glDepthBoundsdNV := gl_GetProc('glDepthBoundsdNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_draw_texture}
  if GL_NV_draw_texture then
    glDrawTextureNV := gl_GetProc('glDrawTextureNV');
  {$EndIf}

  {$IfDef GL_NV_draw_vulkan_image}
  if GL_NV_draw_vulkan_image then
  begin
    glDrawVkImageNV := gl_GetProc('glDrawVkImageNV');
    glGetVkProcAddrNV := gl_GetProc('glGetVkProcAddrNV');
    glWaitVkSemaphoreNV := gl_GetProc('glWaitVkSemaphoreNV');
    glSignalVkSemaphoreNV := gl_GetProc('glSignalVkSemaphoreNV');
    glSignalVkFenceNV := gl_GetProc('glSignalVkFenceNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_evaluators}
  if GL_NV_evaluators then
  begin
    glMapControlPointsNV := gl_GetProc('glMapControlPointsNV');
    glMapParameterivNV := gl_GetProc('glMapParameterivNV');
    glMapParameterfvNV := gl_GetProc('glMapParameterfvNV');
    glGetMapControlPointsNV := gl_GetProc('glGetMapControlPointsNV');
    glGetMapParameterivNV := gl_GetProc('glGetMapParameterivNV');
    glGetMapParameterfvNV := gl_GetProc('glGetMapParameterfvNV');
    glGetMapAttribParameterivNV := gl_GetProc('glGetMapAttribParameterivNV');
    glGetMapAttribParameterfvNV := gl_GetProc('glGetMapAttribParameterfvNV');
    glEvalMapsNV := gl_GetProc('glEvalMapsNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_explicit_multisample}
  if GL_NV_explicit_multisample then
  begin
    glGetMultisamplefvNV := gl_GetProc('glGetMultisamplefvNV');
    glSampleMaskIndexedNV := gl_GetProc('glSampleMaskIndexedNV');
    glTexRenderbufferNV := gl_GetProc('glTexRenderbufferNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_fence}
  if GL_NV_fence then
  begin
    glDeleteFencesNV := gl_GetProc('glDeleteFencesNV');
    glGenFencesNV := gl_GetProc('glGenFencesNV');
    glIsFenceNV := gl_GetProc('glIsFenceNV');
    glTestFenceNV := gl_GetProc('glTestFenceNV');
    glGetFenceivNV := gl_GetProc('glGetFenceivNV');
    glFinishFenceNV := gl_GetProc('glFinishFenceNV');
    glSetFenceNV := gl_GetProc('glSetFenceNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_fragment_coverage_to_color}
  if GL_NV_fragment_coverage_to_color then
    glFragmentCoverageColorNV := gl_GetProc('glFragmentCoverageColorNV');
  {$EndIf}

  {$IfDef GL_NV_fragment_program}
  if GL_NV_fragment_program then
  begin
    glProgramNamedParameter4fNV := gl_GetProc('glProgramNamedParameter4fNV');
    glProgramNamedParameter4fvNV := gl_GetProc('glProgramNamedParameter4fvNV');
    glProgramNamedParameter4dNV := gl_GetProc('glProgramNamedParameter4dNV');
    glProgramNamedParameter4dvNV := gl_GetProc('glProgramNamedParameter4dvNV');
    glGetProgramNamedParameterfvNV := gl_GetProc('glGetProgramNamedParameterfvNV');
    glGetProgramNamedParameterdvNV := gl_GetProc('glGetProgramNamedParameterdvNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_framebuffer_mixed_samples}
  if GL_NV_framebuffer_mixed_samples then
  begin
    glCoverageModulationTableNV := gl_GetProc('glCoverageModulationTableNV');
    glGetCoverageModulationTableNV := gl_GetProc('glGetCoverageModulationTableNV');
    glCoverageModulationNV := gl_GetProc('glCoverageModulationNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_framebuffer_multisample_coverage}
  if GL_NV_framebuffer_multisample_coverage then
    glRenderbufferStorageMultisampleCoverageNV := gl_GetProc('glRenderbufferStorageMultisampleCoverageNV');
  {$EndIf}

  {$IfDef GL_NV_geometry_program4}
  if GL_NV_geometry_program4 then
  begin
    glProgramVertexLimitNV := gl_GetProc('glProgramVertexLimitNV');
    glFramebufferTextureEXT := gl_GetProc('glFramebufferTextureEXT');
    glFramebufferTextureFaceEXT := gl_GetProc('glFramebufferTextureFaceEXT');
  end;
  {$EndIf}

  {$IfDef GL_NV_gpu_multicast}
  if GL_NV_gpu_multicast then
  begin
    glRenderGpuMaskNV := gl_GetProc('glRenderGpuMaskNV');
    glMulticastBufferSubDataNV := gl_GetProc('glMulticastBufferSubDataNV');
    glMulticastCopyBufferSubDataNV := gl_GetProc('glMulticastCopyBufferSubDataNV');
    glMulticastCopyImageSubDataNV := gl_GetProc('glMulticastCopyImageSubDataNV');
    glMulticastBlitFramebufferNV := gl_GetProc('glMulticastBlitFramebufferNV');
    glMulticastFramebufferSampleLocationsfvNV := gl_GetProc('glMulticastFramebufferSampleLocationsfvNV');
    glMulticastBarrierNV := gl_GetProc('glMulticastBarrierNV');
    glMulticastWaitSyncNV := gl_GetProc('glMulticastWaitSyncNV');
    glMulticastGetQueryObjectivNV := gl_GetProc('glMulticastGetQueryObjectivNV');
    glMulticastGetQueryObjectuivNV := gl_GetProc('glMulticastGetQueryObjectuivNV');
    glMulticastGetQueryObjecti64vNV := gl_GetProc('glMulticastGetQueryObjecti64vNV');
    glMulticastGetQueryObjectui64vNV := gl_GetProc('glMulticastGetQueryObjectui64vNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_gpu_program4}
  if GL_NV_gpu_program4 then
  begin
    glProgramLocalParameterI4iNV := gl_GetProc('glProgramLocalParameterI4iNV');
    glProgramLocalParameterI4ivNV := gl_GetProc('glProgramLocalParameterI4ivNV');
    glProgramLocalParametersI4ivNV := gl_GetProc('glProgramLocalParametersI4ivNV');
    glProgramLocalParameterI4uiNV := gl_GetProc('glProgramLocalParameterI4uiNV');
    glProgramLocalParameterI4uivNV := gl_GetProc('glProgramLocalParameterI4uivNV');
    glProgramLocalParametersI4uivNV := gl_GetProc('glProgramLocalParametersI4uivNV');
    glProgramEnvParameterI4iNV := gl_GetProc('glProgramEnvParameterI4iNV');
    glProgramEnvParameterI4ivNV := gl_GetProc('glProgramEnvParameterI4ivNV');
    glProgramEnvParametersI4ivNV := gl_GetProc('glProgramEnvParametersI4ivNV');
    glProgramEnvParameterI4uiNV := gl_GetProc('glProgramEnvParameterI4uiNV');
    glProgramEnvParameterI4uivNV := gl_GetProc('glProgramEnvParameterI4uivNV');
    glProgramEnvParametersI4uivNV := gl_GetProc('glProgramEnvParametersI4uivNV');
    glGetProgramLocalParameterIivNV := gl_GetProc('glGetProgramLocalParameterIivNV');
    glGetProgramLocalParameterIuivNV := gl_GetProc('glGetProgramLocalParameterIuivNV');
    glGetProgramEnvParameterIivNV := gl_GetProc('glGetProgramEnvParameterIivNV');
    glGetProgramEnvParameterIuivNV := gl_GetProc('glGetProgramEnvParameterIuivNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_gpu_program5}
  if GL_NV_gpu_program5 then
  begin
    glProgramSubroutineParametersuivNV := gl_GetProc('glProgramSubroutineParametersuivNV');
    glGetProgramSubroutineParameteruivNV := gl_GetProc('glGetProgramSubroutineParameteruivNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_half_float}
  if GL_NV_half_float then
  begin
    glVertex2hNV := gl_GetProc('glVertex2hNV');
    glVertex2hvNV := gl_GetProc('glVertex2hvNV');
    glVertex3hNV := gl_GetProc('glVertex3hNV');
    glVertex3hvNV := gl_GetProc('glVertex3hvNV');
    glVertex4hNV := gl_GetProc('glVertex4hNV');
    glVertex4hvNV := gl_GetProc('glVertex4hvNV');
    glNormal3hNV := gl_GetProc('glNormal3hNV');
    glNormal3hvNV := gl_GetProc('glNormal3hvNV');
    glColor3hNV := gl_GetProc('glColor3hNV');
    glColor3hvNV := gl_GetProc('glColor3hvNV');
    glColor4hNV := gl_GetProc('glColor4hNV');
    glColor4hvNV := gl_GetProc('glColor4hvNV');
    glTexCoord1hNV := gl_GetProc('glTexCoord1hNV');
    glTexCoord1hvNV := gl_GetProc('glTexCoord1hvNV');
    glTexCoord2hNV := gl_GetProc('glTexCoord2hNV');
    glTexCoord2hvNV := gl_GetProc('glTexCoord2hvNV');
    glTexCoord3hNV := gl_GetProc('glTexCoord3hNV');
    glTexCoord3hvNV := gl_GetProc('glTexCoord3hvNV');
    glTexCoord4hNV := gl_GetProc('glTexCoord4hNV');
    glTexCoord4hvNV := gl_GetProc('glTexCoord4hvNV');
    glMultiTexCoord1hNV := gl_GetProc('glMultiTexCoord1hNV');
    glMultiTexCoord1hvNV := gl_GetProc('glMultiTexCoord1hvNV');
    glMultiTexCoord2hNV := gl_GetProc('glMultiTexCoord2hNV');
    glMultiTexCoord2hvNV := gl_GetProc('glMultiTexCoord2hvNV');
    glMultiTexCoord3hNV := gl_GetProc('glMultiTexCoord3hNV');
    glMultiTexCoord3hvNV := gl_GetProc('glMultiTexCoord3hvNV');
    glMultiTexCoord4hNV := gl_GetProc('glMultiTexCoord4hNV');
    glMultiTexCoord4hvNV := gl_GetProc('glMultiTexCoord4hvNV');
    glFogCoordhNV := gl_GetProc('glFogCoordhNV');
    glFogCoordhvNV := gl_GetProc('glFogCoordhvNV');
    glSecondaryColor3hNV := gl_GetProc('glSecondaryColor3hNV');
    glSecondaryColor3hvNV := gl_GetProc('glSecondaryColor3hvNV');
    glVertexWeighthNV := gl_GetProc('glVertexWeighthNV');
    glVertexWeighthvNV := gl_GetProc('glVertexWeighthvNV');
    glVertexAttrib1hNV := gl_GetProc('glVertexAttrib1hNV');
    glVertexAttrib1hvNV := gl_GetProc('glVertexAttrib1hvNV');
    glVertexAttrib2hNV := gl_GetProc('glVertexAttrib2hNV');
    glVertexAttrib2hvNV := gl_GetProc('glVertexAttrib2hvNV');
    glVertexAttrib3hNV := gl_GetProc('glVertexAttrib3hNV');
    glVertexAttrib3hvNV := gl_GetProc('glVertexAttrib3hvNV');
    glVertexAttrib4hNV := gl_GetProc('glVertexAttrib4hNV');
    glVertexAttrib4hvNV := gl_GetProc('glVertexAttrib4hvNV');
    glVertexAttribs1hvNV := gl_GetProc('glVertexAttribs1hvNV');
    glVertexAttribs2hvNV := gl_GetProc('glVertexAttribs2hvNV');
    glVertexAttribs3hvNV := gl_GetProc('glVertexAttribs3hvNV');
    glVertexAttribs4hvNV := gl_GetProc('glVertexAttribs4hvNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_internalformat_sample_query}
  if GL_NV_internalformat_sample_query then
    glGetInternalformatSampleivNV := gl_GetProc('glGetInternalformatSampleivNV');
  {$EndIf}

  {$IfDef GL_NV_memory_attachment}
  if GL_NV_memory_attachment then
  begin
    glGetMemoryObjectDetachedResourcesuivNV := gl_GetProc('glGetMemoryObjectDetachedResourcesuivNV');
    glResetMemoryObjectParameterNV := gl_GetProc('glResetMemoryObjectParameterNV');
    glTexAttachMemoryNV := gl_GetProc('glTexAttachMemoryNV');
    glBufferAttachMemoryNV := gl_GetProc('glBufferAttachMemoryNV');
    glTextureAttachMemoryNV := gl_GetProc('glTextureAttachMemoryNV');
    glNamedBufferAttachMemoryNV := gl_GetProc('glNamedBufferAttachMemoryNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_memory_object_sparse}
  if GL_NV_memory_object_sparse then
  begin
    glBufferPageCommitmentMemNV := gl_GetProc('glBufferPageCommitmentMemNV');
    glTexPageCommitmentMemNV := gl_GetProc('glTexPageCommitmentMemNV');
    glNamedBufferPageCommitmentMemNV := gl_GetProc('glNamedBufferPageCommitmentMemNV');
    glTexturePageCommitmentMemNV := gl_GetProc('glTexturePageCommitmentMemNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_mesh_shader}
  if GL_NV_mesh_shader then
  begin
    glDrawMeshTasksNV := gl_GetProc('glDrawMeshTasksNV');
    glDrawMeshTasksIndirectNV := gl_GetProc('glDrawMeshTasksIndirectNV');
    glMultiDrawMeshTasksIndirectNV := gl_GetProc('glMultiDrawMeshTasksIndirectNV');
    glMultiDrawMeshTasksIndirectCountNV := gl_GetProc('glMultiDrawMeshTasksIndirectCountNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_occlusion_query}
  if GL_NV_occlusion_query then
  begin
    glGenOcclusionQueriesNV := gl_GetProc('glGenOcclusionQueriesNV');
    glDeleteOcclusionQueriesNV := gl_GetProc('glDeleteOcclusionQueriesNV');
    glIsOcclusionQueryNV := gl_GetProc('glIsOcclusionQueryNV');
    glBeginOcclusionQueryNV := gl_GetProc('glBeginOcclusionQueryNV');
    glEndOcclusionQueryNV := gl_GetProc('glEndOcclusionQueryNV');
    glGetOcclusionQueryivNV := gl_GetProc('glGetOcclusionQueryivNV');
    glGetOcclusionQueryuivNV := gl_GetProc('glGetOcclusionQueryuivNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_parameter_buffer_object}
  if GL_NV_parameter_buffer_object then
  begin
    glProgramBufferParametersfvNV := gl_GetProc('glProgramBufferParametersfvNV');
    glProgramBufferParametersIivNV := gl_GetProc('glProgramBufferParametersIivNV');
    glProgramBufferParametersIuivNV := gl_GetProc('glProgramBufferParametersIuivNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_path_rendering}
  if GL_NV_path_rendering then
  begin
    glGenPathsNV := gl_GetProc('glGenPathsNV');
    glDeletePathsNV := gl_GetProc('glDeletePathsNV');
    glIsPathNV := gl_GetProc('glIsPathNV');
    glPathCommandsNV := gl_GetProc('glPathCommandsNV');
    glPathCoordsNV := gl_GetProc('glPathCoordsNV');
    glPathSubCommandsNV := gl_GetProc('glPathSubCommandsNV');
    glPathSubCoordsNV := gl_GetProc('glPathSubCoordsNV');
    glPathStringNV := gl_GetProc('glPathStringNV');
    glPathGlyphsNV := gl_GetProc('glPathGlyphsNV');
    glPathGlyphRangeNV := gl_GetProc('glPathGlyphRangeNV');
    glWeightPathsNV := gl_GetProc('glWeightPathsNV');
    glCopyPathNV := gl_GetProc('glCopyPathNV');
    glInterpolatePathsNV := gl_GetProc('glInterpolatePathsNV');
    glTransformPathNV := gl_GetProc('glTransformPathNV');
    glPathParameterivNV := gl_GetProc('glPathParameterivNV');
    glPathParameteriNV := gl_GetProc('glPathParameteriNV');
    glPathParameterfvNV := gl_GetProc('glPathParameterfvNV');
    glPathParameterfNV := gl_GetProc('glPathParameterfNV');
    glPathDashArrayNV := gl_GetProc('glPathDashArrayNV');
    glPathStencilFuncNV := gl_GetProc('glPathStencilFuncNV');
    glPathStencilDepthOffsetNV := gl_GetProc('glPathStencilDepthOffsetNV');
    glStencilFillPathNV := gl_GetProc('glStencilFillPathNV');
    glStencilStrokePathNV := gl_GetProc('glStencilStrokePathNV');
    glStencilFillPathInstancedNV := gl_GetProc('glStencilFillPathInstancedNV');
    glStencilStrokePathInstancedNV := gl_GetProc('glStencilStrokePathInstancedNV');
    glPathCoverDepthFuncNV := gl_GetProc('glPathCoverDepthFuncNV');
    glCoverFillPathNV := gl_GetProc('glCoverFillPathNV');
    glCoverStrokePathNV := gl_GetProc('glCoverStrokePathNV');
    glCoverFillPathInstancedNV := gl_GetProc('glCoverFillPathInstancedNV');
    glCoverStrokePathInstancedNV := gl_GetProc('glCoverStrokePathInstancedNV');
    glGetPathParameterivNV := gl_GetProc('glGetPathParameterivNV');
    glGetPathParameterfvNV := gl_GetProc('glGetPathParameterfvNV');
    glGetPathCommandsNV := gl_GetProc('glGetPathCommandsNV');
    glGetPathCoordsNV := gl_GetProc('glGetPathCoordsNV');
    glGetPathDashArrayNV := gl_GetProc('glGetPathDashArrayNV');
    glGetPathMetricsNV := gl_GetProc('glGetPathMetricsNV');
    glGetPathMetricRangeNV := gl_GetProc('glGetPathMetricRangeNV');
    glGetPathSpacingNV := gl_GetProc('glGetPathSpacingNV');
    glIsPointInFillPathNV := gl_GetProc('glIsPointInFillPathNV');
    glIsPointInStrokePathNV := gl_GetProc('glIsPointInStrokePathNV');
    glGetPathLengthNV := gl_GetProc('glGetPathLengthNV');
    glPointAlongPathNV := gl_GetProc('glPointAlongPathNV');
    glMatrixLoad3x2fNV := gl_GetProc('glMatrixLoad3x2fNV');
    glMatrixLoad3x3fNV := gl_GetProc('glMatrixLoad3x3fNV');
    glMatrixLoadTranspose3x3fNV := gl_GetProc('glMatrixLoadTranspose3x3fNV');
    glMatrixMult3x2fNV := gl_GetProc('glMatrixMult3x2fNV');
    glMatrixMult3x3fNV := gl_GetProc('glMatrixMult3x3fNV');
    glMatrixMultTranspose3x3fNV := gl_GetProc('glMatrixMultTranspose3x3fNV');
    glStencilThenCoverFillPathNV := gl_GetProc('glStencilThenCoverFillPathNV');
    glStencilThenCoverStrokePathNV := gl_GetProc('glStencilThenCoverStrokePathNV');
    glStencilThenCoverFillPathInstancedNV := gl_GetProc('glStencilThenCoverFillPathInstancedNV');
    glStencilThenCoverStrokePathInstancedNV := gl_GetProc('glStencilThenCoverStrokePathInstancedNV');
    glPathGlyphIndexRangeNV := gl_GetProc('glPathGlyphIndexRangeNV');
    glPathGlyphIndexArrayNV := gl_GetProc('glPathGlyphIndexArrayNV');
    glPathMemoryGlyphIndexArrayNV := gl_GetProc('glPathMemoryGlyphIndexArrayNV');
    glProgramPathFragmentInputGenNV := gl_GetProc('glProgramPathFragmentInputGenNV');
    glGetProgramResourcefvNV := gl_GetProc('glGetProgramResourcefvNV');
    {$IfNDef USE_GLCORE}
    glPathColorGenNV := gl_GetProc('glPathColorGenNV');
    glPathTexGenNV := gl_GetProc('glPathTexGenNV');
    glPathFogGenNV := gl_GetProc('glPathFogGenNV');
    glGetPathColorGenivNV := gl_GetProc('glGetPathColorGenivNV');
    glGetPathColorGenfvNV := gl_GetProc('glGetPathColorGenfvNV');
    glGetPathTexGenivNV := gl_GetProc('glGetPathTexGenivNV');
    glGetPathTexGenfvNV := gl_GetProc('glGetPathTexGenfvNV');
    {$EndIf}
  end;
  {$EndIf}

  {$IfDef GL_NV_pixel_data_range}
  if GL_NV_pixel_data_range then
  begin
    glPixelDataRangeNV := gl_GetProc('glPixelDataRangeNV');
    glFlushPixelDataRangeNV := gl_GetProc('glFlushPixelDataRangeNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_point_sprite}
  if GL_NV_point_sprite then
  begin
    glPointParameteriNV := gl_GetProc('glPointParameteriNV');
    glPointParameterivNV := gl_GetProc('glPointParameterivNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_present_video}
  if GL_NV_present_video then
  begin
    glPresentFrameKeyedNV := gl_GetProc('glPresentFrameKeyedNV');
    glPresentFrameDualFillNV := gl_GetProc('glPresentFrameDualFillNV');
    glGetVideoivNV := gl_GetProc('glGetVideoivNV');
    glGetVideouivNV := gl_GetProc('glGetVideouivNV');
    glGetVideoi64vNV := gl_GetProc('glGetVideoi64vNV');
    glGetVideoui64vNV := gl_GetProc('glGetVideoui64vNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_primitive_restart}
  if GL_NV_primitive_restart then
  begin
    glPrimitiveRestartNV := gl_GetProc('glPrimitiveRestartNV');
    glPrimitiveRestartIndexNV := gl_GetProc('glPrimitiveRestartIndexNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_query_resource}
  if GL_NV_query_resource then
    glQueryResourceNV := gl_GetProc('glQueryResourceNV');
  {$EndIf}

  {$IfDef GL_NV_query_resource_tag}
  if GL_NV_query_resource_tag then
  begin
    glGenQueryResourceTagNV := gl_GetProc('glGenQueryResourceTagNV');
    glDeleteQueryResourceTagNV := gl_GetProc('glDeleteQueryResourceTagNV');
    glQueryResourceTagNV := gl_GetProc('glQueryResourceTagNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_register_combiners}
  if GL_NV_register_combiners then
  begin
    glCombinerParameterfvNV := gl_GetProc('glCombinerParameterfvNV');
    glCombinerParameterfNV := gl_GetProc('glCombinerParameterfNV');
    glCombinerParameterivNV := gl_GetProc('glCombinerParameterivNV');
    glCombinerParameteriNV := gl_GetProc('glCombinerParameteriNV');
    glCombinerInputNV := gl_GetProc('glCombinerInputNV');
    glCombinerOutputNV := gl_GetProc('glCombinerOutputNV');
    glFinalCombinerInputNV := gl_GetProc('glFinalCombinerInputNV');
    glGetCombinerInputParameterfvNV := gl_GetProc('glGetCombinerInputParameterfvNV');
    glGetCombinerInputParameterivNV := gl_GetProc('glGetCombinerInputParameterivNV');
    glGetCombinerOutputParameterfvNV := gl_GetProc('glGetCombinerOutputParameterfvNV');
    glGetCombinerOutputParameterivNV := gl_GetProc('glGetCombinerOutputParameterivNV');
    glGetFinalCombinerInputParameterfvNV := gl_GetProc('glGetFinalCombinerInputParameterfvNV');
    glGetFinalCombinerInputParameterivNV := gl_GetProc('glGetFinalCombinerInputParameterivNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_register_combiners2}
  if GL_NV_register_combiners2 then
  begin
    glCombinerStageParameterfvNV := gl_GetProc('glCombinerStageParameterfvNV');
    glGetCombinerStageParameterfvNV := gl_GetProc('glGetCombinerStageParameterfvNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_sample_locations}
  if GL_NV_sample_locations then
  begin
    glFramebufferSampleLocationsfvNV := gl_GetProc('glFramebufferSampleLocationsfvNV');
    glNamedFramebufferSampleLocationsfvNV := gl_GetProc('glNamedFramebufferSampleLocationsfvNV');
    glResolveDepthValuesNV := gl_GetProc('glResolveDepthValuesNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_scissor_exclusive}
  if GL_NV_scissor_exclusive then
  begin
    glScissorExclusiveNV := gl_GetProc('glScissorExclusiveNV');
    glScissorExclusiveArrayvNV := gl_GetProc('glScissorExclusiveArrayvNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_shader_buffer_load}
  if GL_NV_shader_buffer_load then
  begin
    glMakeBufferResidentNV := gl_GetProc('glMakeBufferResidentNV');
    glMakeBufferNonResidentNV := gl_GetProc('glMakeBufferNonResidentNV');
    glIsBufferResidentNV := gl_GetProc('glIsBufferResidentNV');
    glMakeNamedBufferResidentNV := gl_GetProc('glMakeNamedBufferResidentNV');
    glMakeNamedBufferNonResidentNV := gl_GetProc('glMakeNamedBufferNonResidentNV');
    glIsNamedBufferResidentNV := gl_GetProc('glIsNamedBufferResidentNV');
    glGetBufferParameterui64vNV := gl_GetProc('glGetBufferParameterui64vNV');
    glGetNamedBufferParameterui64vNV := gl_GetProc('glGetNamedBufferParameterui64vNV');
    glGetIntegerui64vNV := gl_GetProc('glGetIntegerui64vNV');
    glUniformui64NV := gl_GetProc('glUniformui64NV');
    glUniformui64vNV := gl_GetProc('glUniformui64vNV');
    glProgramUniformui64NV := gl_GetProc('glProgramUniformui64NV');
    glProgramUniformui64vNV := gl_GetProc('glProgramUniformui64vNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_shading_rate_image}
  if GL_NV_shading_rate_image then
  begin
    glBindShadingRateImageNV := gl_GetProc('glBindShadingRateImageNV');
    glGetShadingRateImagePaletteNV := gl_GetProc('glGetShadingRateImagePaletteNV');
    glGetShadingRateSampleLocationivNV := gl_GetProc('glGetShadingRateSampleLocationivNV');
    glShadingRateImageBarrierNV := gl_GetProc('glShadingRateImageBarrierNV');
    glShadingRateImagePaletteNV := gl_GetProc('glShadingRateImagePaletteNV');
    glShadingRateSampleOrderNV := gl_GetProc('glShadingRateSampleOrderNV');
    glShadingRateSampleOrderCustomNV := gl_GetProc('glShadingRateSampleOrderCustomNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_texture_barrier}
  if GL_NV_texture_barrier then
    glTextureBarrierNV := gl_GetProc('glTextureBarrierNV');
  {$EndIf}

  {$IfDef GL_NV_texture_multisample}
  if GL_NV_texture_multisample then
  begin
    glTexImage2DMultisampleCoverageNV := gl_GetProc('glTexImage2DMultisampleCoverageNV');
    glTexImage3DMultisampleCoverageNV := gl_GetProc('glTexImage3DMultisampleCoverageNV');
    glTextureImage2DMultisampleNV := gl_GetProc('glTextureImage2DMultisampleNV');
    glTextureImage3DMultisampleNV := gl_GetProc('glTextureImage3DMultisampleNV');
    glTextureImage2DMultisampleCoverageNV := gl_GetProc('glTextureImage2DMultisampleCoverageNV');
    glTextureImage3DMultisampleCoverageNV := gl_GetProc('glTextureImage3DMultisampleCoverageNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_timeline_semaphore}
  if GL_NV_timeline_semaphore then
  begin
    glCreateSemaphoresNV := gl_GetProc('glCreateSemaphoresNV');
    glSemaphoreParameterivNV := gl_GetProc('glSemaphoreParameterivNV');
    glGetSemaphoreParameterivNV := gl_GetProc('glGetSemaphoreParameterivNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_transform_feedback}
  if GL_NV_transform_feedback then
  begin
    glBeginTransformFeedbackNV := gl_GetProc('glBeginTransformFeedbackNV');
    glEndTransformFeedbackNV := gl_GetProc('glEndTransformFeedbackNV');
    glTransformFeedbackAttribsNV := gl_GetProc('glTransformFeedbackAttribsNV');
    glBindBufferRangeNV := gl_GetProc('glBindBufferRangeNV');
    glBindBufferOffsetNV := gl_GetProc('glBindBufferOffsetNV');
    glBindBufferBaseNV := gl_GetProc('glBindBufferBaseNV');
    glTransformFeedbackVaryingsNV := gl_GetProc('glTransformFeedbackVaryingsNV');
    glActiveVaryingNV := gl_GetProc('glActiveVaryingNV');
    glGetVaryingLocationNV := gl_GetProc('glGetVaryingLocationNV');
    glGetActiveVaryingNV := gl_GetProc('glGetActiveVaryingNV');
    glGetTransformFeedbackVaryingNV := gl_GetProc('glGetTransformFeedbackVaryingNV');
    glTransformFeedbackStreamAttribsNV := gl_GetProc('glTransformFeedbackStreamAttribsNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_transform_feedback2}
  if GL_NV_transform_feedback2 then
  begin
    glBindTransformFeedbackNV := gl_GetProc('glBindTransformFeedbackNV');
    glDeleteTransformFeedbacksNV := gl_GetProc('glDeleteTransformFeedbacksNV');
    glGenTransformFeedbacksNV := gl_GetProc('glGenTransformFeedbacksNV');
    glIsTransformFeedbackNV := gl_GetProc('glIsTransformFeedbackNV');
    glPauseTransformFeedbackNV := gl_GetProc('glPauseTransformFeedbackNV');
    glResumeTransformFeedbackNV := gl_GetProc('glResumeTransformFeedbackNV');
    glDrawTransformFeedbackNV := gl_GetProc('glDrawTransformFeedbackNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_vdpau_interop}
  if GL_NV_vdpau_interop then
  begin
    glVDPAUInitNV := gl_GetProc('glVDPAUInitNV');
    glVDPAUFiniNV := gl_GetProc('glVDPAUFiniNV');
    glVDPAURegisterVideoSurfaceNV := gl_GetProc('glVDPAURegisterVideoSurfaceNV');
    glVDPAURegisterOutputSurfaceNV := gl_GetProc('glVDPAURegisterOutputSurfaceNV');
    glVDPAUIsSurfaceNV := gl_GetProc('glVDPAUIsSurfaceNV');
    glVDPAUUnregisterSurfaceNV := gl_GetProc('glVDPAUUnregisterSurfaceNV');
    glVDPAUGetSurfaceivNV := gl_GetProc('glVDPAUGetSurfaceivNV');
    glVDPAUSurfaceAccessNV := gl_GetProc('glVDPAUSurfaceAccessNV');
    glVDPAUMapSurfacesNV := gl_GetProc('glVDPAUMapSurfacesNV');
    glVDPAUUnmapSurfacesNV := gl_GetProc('glVDPAUUnmapSurfacesNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_vdpau_interop2}
  if GL_NV_vdpau_interop2 then
    glVDPAURegisterVideoSurfaceWithPictureStructureNV := gl_GetProc('glVDPAURegisterVideoSurfaceWithPictureStructureNV');
  {$EndIf}

  {$IfDef GL_NV_vertex_array_range}
  if GL_NV_vertex_array_range then
  begin
    glFlushVertexArrayRangeNV := gl_GetProc('glFlushVertexArrayRangeNV');
    glVertexArrayRangeNV := gl_GetProc('glVertexArrayRangeNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_vertex_attrib_integer_64bit}
  if GL_NV_vertex_attrib_integer_64bit then
  begin
    glVertexAttribL1i64NV := gl_GetProc('glVertexAttribL1i64NV');
    glVertexAttribL2i64NV := gl_GetProc('glVertexAttribL2i64NV');
    glVertexAttribL3i64NV := gl_GetProc('glVertexAttribL3i64NV');
    glVertexAttribL4i64NV := gl_GetProc('glVertexAttribL4i64NV');
    glVertexAttribL1i64vNV := gl_GetProc('glVertexAttribL1i64vNV');
    glVertexAttribL2i64vNV := gl_GetProc('glVertexAttribL2i64vNV');
    glVertexAttribL3i64vNV := gl_GetProc('glVertexAttribL3i64vNV');
    glVertexAttribL4i64vNV := gl_GetProc('glVertexAttribL4i64vNV');
    glVertexAttribL1ui64NV := gl_GetProc('glVertexAttribL1ui64NV');
    glVertexAttribL2ui64NV := gl_GetProc('glVertexAttribL2ui64NV');
    glVertexAttribL3ui64NV := gl_GetProc('glVertexAttribL3ui64NV');
    glVertexAttribL4ui64NV := gl_GetProc('glVertexAttribL4ui64NV');
    glVertexAttribL1ui64vNV := gl_GetProc('glVertexAttribL1ui64vNV');
    glVertexAttribL2ui64vNV := gl_GetProc('glVertexAttribL2ui64vNV');
    glVertexAttribL3ui64vNV := gl_GetProc('glVertexAttribL3ui64vNV');
    glVertexAttribL4ui64vNV := gl_GetProc('glVertexAttribL4ui64vNV');
    glGetVertexAttribLi64vNV := gl_GetProc('glGetVertexAttribLi64vNV');
    glGetVertexAttribLui64vNV := gl_GetProc('glGetVertexAttribLui64vNV');
    glVertexAttribLFormatNV := gl_GetProc('glVertexAttribLFormatNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_vertex_buffer_unified_memory}
  if GL_NV_vertex_buffer_unified_memory then
  begin
    glBufferAddressRangeNV := gl_GetProc('glBufferAddressRangeNV');
    glVertexFormatNV := gl_GetProc('glVertexFormatNV');
    glNormalFormatNV := gl_GetProc('glNormalFormatNV');
    glColorFormatNV := gl_GetProc('glColorFormatNV');
    glIndexFormatNV := gl_GetProc('glIndexFormatNV');
    glTexCoordFormatNV := gl_GetProc('glTexCoordFormatNV');
    glEdgeFlagFormatNV := gl_GetProc('glEdgeFlagFormatNV');
    glSecondaryColorFormatNV := gl_GetProc('glSecondaryColorFormatNV');
    glFogCoordFormatNV := gl_GetProc('glFogCoordFormatNV');
    glVertexAttribFormatNV := gl_GetProc('glVertexAttribFormatNV');
    glVertexAttribIFormatNV := gl_GetProc('glVertexAttribIFormatNV');
    glGetIntegerui64i_vNV := gl_GetProc('glGetIntegerui64i_vNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_vertex_program}
  if GL_NV_vertex_program then
  begin
    glAreProgramsResidentNV := gl_GetProc('glAreProgramsResidentNV');
    glBindProgramNV := gl_GetProc('glBindProgramNV');
    glDeleteProgramsNV := gl_GetProc('glDeleteProgramsNV');
    glExecuteProgramNV := gl_GetProc('glExecuteProgramNV');
    glGenProgramsNV := gl_GetProc('glGenProgramsNV');
    glGetProgramParameterdvNV := gl_GetProc('glGetProgramParameterdvNV');
    glGetProgramParameterfvNV := gl_GetProc('glGetProgramParameterfvNV');
    glGetProgramivNV := gl_GetProc('glGetProgramivNV');
    glGetProgramStringNV := gl_GetProc('glGetProgramStringNV');
    glGetTrackMatrixivNV := gl_GetProc('glGetTrackMatrixivNV');
    glGetVertexAttribdvNV := gl_GetProc('glGetVertexAttribdvNV');
    glGetVertexAttribfvNV := gl_GetProc('glGetVertexAttribfvNV');
    glGetVertexAttribivNV := gl_GetProc('glGetVertexAttribivNV');
    glGetVertexAttribPointervNV := gl_GetProc('glGetVertexAttribPointervNV');
    glIsProgramNV := gl_GetProc('glIsProgramNV');
    glLoadProgramNV := gl_GetProc('glLoadProgramNV');
    glProgramParameter4dNV := gl_GetProc('glProgramParameter4dNV');
    glProgramParameter4dvNV := gl_GetProc('glProgramParameter4dvNV');
    glProgramParameter4fNV := gl_GetProc('glProgramParameter4fNV');
    glProgramParameter4fvNV := gl_GetProc('glProgramParameter4fvNV');
    glProgramParameters4dvNV := gl_GetProc('glProgramParameters4dvNV');
    glProgramParameters4fvNV := gl_GetProc('glProgramParameters4fvNV');
    glRequestResidentProgramsNV := gl_GetProc('glRequestResidentProgramsNV');
    glTrackMatrixNV := gl_GetProc('glTrackMatrixNV');
    glVertexAttribPointerNV := gl_GetProc('glVertexAttribPointerNV');
    glVertexAttrib1dNV := gl_GetProc('glVertexAttrib1dNV');
    glVertexAttrib1dvNV := gl_GetProc('glVertexAttrib1dvNV');
    glVertexAttrib1fNV := gl_GetProc('glVertexAttrib1fNV');
    glVertexAttrib1fvNV := gl_GetProc('glVertexAttrib1fvNV');
    glVertexAttrib1sNV := gl_GetProc('glVertexAttrib1sNV');
    glVertexAttrib1svNV := gl_GetProc('glVertexAttrib1svNV');
    glVertexAttrib2dNV := gl_GetProc('glVertexAttrib2dNV');
    glVertexAttrib2dvNV := gl_GetProc('glVertexAttrib2dvNV');
    glVertexAttrib2fNV := gl_GetProc('glVertexAttrib2fNV');
    glVertexAttrib2fvNV := gl_GetProc('glVertexAttrib2fvNV');
    glVertexAttrib2sNV := gl_GetProc('glVertexAttrib2sNV');
    glVertexAttrib2svNV := gl_GetProc('glVertexAttrib2svNV');
    glVertexAttrib3dNV := gl_GetProc('glVertexAttrib3dNV');
    glVertexAttrib3dvNV := gl_GetProc('glVertexAttrib3dvNV');
    glVertexAttrib3fNV := gl_GetProc('glVertexAttrib3fNV');
    glVertexAttrib3fvNV := gl_GetProc('glVertexAttrib3fvNV');
    glVertexAttrib3sNV := gl_GetProc('glVertexAttrib3sNV');
    glVertexAttrib3svNV := gl_GetProc('glVertexAttrib3svNV');
    glVertexAttrib4dNV := gl_GetProc('glVertexAttrib4dNV');
    glVertexAttrib4dvNV := gl_GetProc('glVertexAttrib4dvNV');
    glVertexAttrib4fNV := gl_GetProc('glVertexAttrib4fNV');
    glVertexAttrib4fvNV := gl_GetProc('glVertexAttrib4fvNV');
    glVertexAttrib4sNV := gl_GetProc('glVertexAttrib4sNV');
    glVertexAttrib4svNV := gl_GetProc('glVertexAttrib4svNV');
    glVertexAttrib4ubNV := gl_GetProc('glVertexAttrib4ubNV');
    glVertexAttrib4ubvNV := gl_GetProc('glVertexAttrib4ubvNV');
    glVertexAttribs1dvNV := gl_GetProc('glVertexAttribs1dvNV');
    glVertexAttribs1fvNV := gl_GetProc('glVertexAttribs1fvNV');
    glVertexAttribs1svNV := gl_GetProc('glVertexAttribs1svNV');
    glVertexAttribs2dvNV := gl_GetProc('glVertexAttribs2dvNV');
    glVertexAttribs2fvNV := gl_GetProc('glVertexAttribs2fvNV');
    glVertexAttribs2svNV := gl_GetProc('glVertexAttribs2svNV');
    glVertexAttribs3dvNV := gl_GetProc('glVertexAttribs3dvNV');
    glVertexAttribs3fvNV := gl_GetProc('glVertexAttribs3fvNV');
    glVertexAttribs3svNV := gl_GetProc('glVertexAttribs3svNV');
    glVertexAttribs4dvNV := gl_GetProc('glVertexAttribs4dvNV');
    glVertexAttribs4fvNV := gl_GetProc('glVertexAttribs4fvNV');
    glVertexAttribs4svNV := gl_GetProc('glVertexAttribs4svNV');
    glVertexAttribs4ubvNV := gl_GetProc('glVertexAttribs4ubvNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_video_capture}
  if GL_NV_video_capture then
  begin
    glBeginVideoCaptureNV := gl_GetProc('glBeginVideoCaptureNV');
    glBindVideoCaptureStreamBufferNV := gl_GetProc('glBindVideoCaptureStreamBufferNV');
    glBindVideoCaptureStreamTextureNV := gl_GetProc('glBindVideoCaptureStreamTextureNV');
    glEndVideoCaptureNV := gl_GetProc('glEndVideoCaptureNV');
    glGetVideoCaptureivNV := gl_GetProc('glGetVideoCaptureivNV');
    glGetVideoCaptureStreamivNV := gl_GetProc('glGetVideoCaptureStreamivNV');
    glGetVideoCaptureStreamfvNV := gl_GetProc('glGetVideoCaptureStreamfvNV');
    glGetVideoCaptureStreamdvNV := gl_GetProc('glGetVideoCaptureStreamdvNV');
    glVideoCaptureNV := gl_GetProc('glVideoCaptureNV');
    glVideoCaptureStreamParameterivNV := gl_GetProc('glVideoCaptureStreamParameterivNV');
    glVideoCaptureStreamParameterfvNV := gl_GetProc('glVideoCaptureStreamParameterfvNV');
    glVideoCaptureStreamParameterdvNV := gl_GetProc('glVideoCaptureStreamParameterdvNV');
  end;
  {$EndIf}

  {$IfDef GL_NV_viewport_swizzle}
  if GL_NV_viewport_swizzle then
    glViewportSwizzleNV := gl_GetProc('glViewportSwizzleNV');
  {$EndIf}

  {$IfDef GL_OVR_multiview}
  if GL_OVR_multiview  then
    glFramebufferTextureMultiviewOVR := gl_GetProc('glFramebufferTextureMultiviewOVR');
  {$EndIf}

  {$IfDef GL_PGI_misc_hints}
  if GL_PGI_misc_hints then
    glHintPGI := gl_GetProc('glHintPGI');
  {$EndIf}

  {$IfDef GL_SGIS_detail_texture}
  if GL_SGIS_detail_texture then
  begin
    glDetailTexFuncSGIS := gl_GetProc('glDetailTexFuncSGIS');
    glGetDetailTexFuncSGIS := gl_GetProc('glGetDetailTexFuncSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIS_fog_function}
  if GL_SGIS_fog_function then
  begin
    glFogFuncSGIS := gl_GetProc('glFogFuncSGIS');
    glGetFogFuncSGIS := gl_GetProc('glGetFogFuncSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIS_multisample}
  if GL_SGIS_multisample then
  begin
    glSampleMaskSGIS := gl_GetProc('glSampleMaskSGIS');
    glSamplePatternSGIS := gl_GetProc('glSamplePatternSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIS_pixel_texture}
  if GL_SGIS_pixel_texture then
  begin
    glPixelTexGenParameteriSGIS := gl_GetProc('glPixelTexGenParameteriSGIS');
    glPixelTexGenParameterivSGIS := gl_GetProc('glPixelTexGenParameterivSGIS');
    glPixelTexGenParameterfSGIS := gl_GetProc('glPixelTexGenParameterfSGIS');
    glPixelTexGenParameterfvSGIS := gl_GetProc('glPixelTexGenParameterfvSGIS');
    glGetPixelTexGenParameterivSGIS := gl_GetProc('glGetPixelTexGenParameterivSGIS');
    glGetPixelTexGenParameterfvSGIS := gl_GetProc('glGetPixelTexGenParameterfvSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIS_point_parameters}
  if GL_SGIS_point_parameters then
  begin
    glPointParameterfSGIS := gl_GetProc('glPointParameterfSGIS');
    glPointParameterfvSGIS := gl_GetProc('glPointParameterfvSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIS_sharpen_texture}
  if GL_SGIS_sharpen_texture then
  begin
    glSharpenTexFuncSGIS := gl_GetProc('glSharpenTexFuncSGIS');
    glGetSharpenTexFuncSGIS := gl_GetProc('glGetSharpenTexFuncSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIS_texture4D}
  if GL_SGIS_texture4D then
  begin
    glTexImage4DSGIS := gl_GetProc('glTexImage4DSGIS');
    glTexSubImage4DSGIS := gl_GetProc('glTexSubImage4DSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIS_texture_color_mask}
  if GL_SGIS_texture_color_mask then
    glTextureColorMaskSGIS := gl_GetProc('glTextureColorMaskSGIS');
  {$EndIf}

  {$IfDef GL_SGIS_texture_filter4}
  if GL_SGIS_texture_filter4 then
  begin
    glGetTexFilterFuncSGIS := gl_GetProc('glGetTexFilterFuncSGIS');
    glTexFilterFuncSGIS := gl_GetProc('glTexFilterFuncSGIS');
  end;
  {$EndIf}

  {$IfDef GL_SGIX_async}
  if GL_SGIX_async then
  begin
    glAsyncMarkerSGIX := gl_GetProc('glAsyncMarkerSGIX');
    glFinishAsyncSGIX := gl_GetProc('glFinishAsyncSGIX');
    glPollAsyncSGIX := gl_GetProc('glPollAsyncSGIX');
    glGenAsyncMarkersSGIX := gl_GetProc('glGenAsyncMarkersSGIX');
    glDeleteAsyncMarkersSGIX := gl_GetProc('glDeleteAsyncMarkersSGIX');
    glIsAsyncMarkerSGIX := gl_GetProc('glIsAsyncMarkerSGIX');
  end;
  {$EndIf}

  {$IfDef GL_SGIX_flush_raster}
  if GL_SGIX_flush_raster then
    glFlushRasterSGIX := gl_GetProc('glFlushRasterSGIX');
  {$EndIf}

  {$IfDef GL_SGIX_fragment_lighting}
  if GL_SGIX_fragment_lighting then
  begin
    glFragmentColorMaterialSGIX := gl_GetProc('glFragmentColorMaterialSGIX');
    glFragmentLightfSGIX := gl_GetProc('glFragmentLightfSGIX');
    glFragmentLightfvSGIX := gl_GetProc('glFragmentLightfvSGIX');
    glFragmentLightiSGIX := gl_GetProc('glFragmentLightiSGIX');
    glFragmentLightivSGIX := gl_GetProc('glFragmentLightivSGIX');
    glFragmentLightModelfSGIX := gl_GetProc('glFragmentLightModelfSGIX');
    glFragmentLightModelfvSGIX := gl_GetProc('glFragmentLightModelfvSGIX');
    glFragmentLightModeliSGIX := gl_GetProc('glFragmentLightModeliSGIX');
    glFragmentLightModelivSGIX := gl_GetProc('glFragmentLightModelivSGIX');
    glFragmentMaterialfSGIX := gl_GetProc('glFragmentMaterialfSGIX');
    glFragmentMaterialfvSGIX := gl_GetProc('glFragmentMaterialfvSGIX');
    glFragmentMaterialiSGIX := gl_GetProc('glFragmentMaterialiSGIX');
    glFragmentMaterialivSGIX := gl_GetProc('glFragmentMaterialivSGIX');
    glGetFragmentLightfvSGIX := gl_GetProc('glGetFragmentLightfvSGIX');
    glGetFragmentLightivSGIX := gl_GetProc('glGetFragmentLightivSGIX');
    glGetFragmentMaterialfvSGIX := gl_GetProc('glGetFragmentMaterialfvSGIX');
    glGetFragmentMaterialivSGIX := gl_GetProc('glGetFragmentMaterialivSGIX');
    glLightEnviSGIX := gl_GetProc('glLightEnviSGIX');
  end;
  {$EndIf}

  {$IfDef GL_SGIX_framezoom}
  if GL_SGIX_framezoom then
    glFrameZoomSGIX := gl_GetProc('glFrameZoomSGIX');
  {$EndIf}

  {$IfDef GL_SGIX_igloo_interface}
  if GL_SGIX_igloo_interface then
    glIglooInterfaceSGIX := gl_GetProc('glIglooInterfaceSGIX');
  {$EndIf}

  {$IfDef GL_SGIX_instruments}
  if GL_SGIX_instruments then
  begin
    glGetInstrumentsSGIX := gl_GetProc('glGetInstrumentsSGIX');
    glInstrumentsBufferSGIX := gl_GetProc('glInstrumentsBufferSGIX');
    glPollInstrumentsSGIX := gl_GetProc('glPollInstrumentsSGIX');
    glReadInstrumentsSGIX := gl_GetProc('glReadInstrumentsSGIX');
    glStartInstrumentsSGIX := gl_GetProc('glStartInstrumentsSGIX');
    glStopInstrumentsSGIX := gl_GetProc('glStopInstrumentsSGIX');
  end;
  {$EndIf}

  {$IfDef GL_SGIX_list_priority}
  if GL_SGIX_list_priority then
  begin
    glGetListParameterfvSGIX := gl_GetProc('glGetListParameterfvSGIX');
    glGetListParameterivSGIX := gl_GetProc('glGetListParameterivSGIX');
    glListParameterfSGIX := gl_GetProc('glListParameterfSGIX');
    glListParameterfvSGIX := gl_GetProc('glListParameterfvSGIX');
    glListParameteriSGIX := gl_GetProc('glListParameteriSGIX');
    glListParameterivSGIX := gl_GetProc('glListParameterivSGIX');
  end;
  {$EndIf}

  {$IfDef GL_SGIX_pixel_texture}
  if GL_SGIX_pixel_texture then
    glPixelTexGenSGIX := gl_GetProc('glPixelTexGenSGIX');
  {$EndIf}

  {$IfDef GL_SGIX_polynomial_ffd}
  if GL_SGIX_polynomial_ffd then
  begin
    glDeformationMap3dSGIX := gl_GetProc('glDeformationMap3dSGIX');
    glDeformationMap3fSGIX := gl_GetProc('glDeformationMap3fSGIX');
    glDeformSGIX := gl_GetProc('glDeformSGIX');
    glLoadIdentityDeformationMapSGIX := gl_GetProc('glLoadIdentityDeformationMapSGIX');
  end;
  {$EndIf}

  {$IfDef GL_SGIX_reference_plane}
  if GL_SGIX_reference_plane then
    glReferencePlaneSGIX := gl_GetProc('glReferencePlaneSGIX');
  {$EndIf}

  {$IfDef GL_SGIX_sprite}
  if GL_SGIX_sprite then
  begin
    glSpriteParameterfSGIX := gl_GetProc('glSpriteParameterfSGIX');
    glSpriteParameterfvSGIX := gl_GetProc('glSpriteParameterfvSGIX');
    glSpriteParameteriSGIX := gl_GetProc('glSpriteParameteriSGIX');
    glSpriteParameterivSGIX := gl_GetProc('glSpriteParameterivSGIX');
  end;
  {$EndIf}

  {$IfDef GL_SGIX_tag_sample_buffer}
  if GL_SGIX_tag_sample_buffer then
    glTagSampleBufferSGIX := gl_GetProc('glTagSampleBufferSGIX');
  {$EndIf}

  {$IfDef GL_SGI_color_table}
  if GL_SGI_color_table then
  begin
    glColorTableSGI := gl_GetProc('glColorTableSGI');
    glColorTableParameterfvSGI := gl_GetProc('glColorTableParameterfvSGI');
    glColorTableParameterivSGI := gl_GetProc('glColorTableParameterivSGI');
    glCopyColorTableSGI := gl_GetProc('glCopyColorTableSGI');
    glGetColorTableSGI := gl_GetProc('glGetColorTableSGI');
    glGetColorTableParameterfvSGI := gl_GetProc('glGetColorTableParameterfvSGI');
    glGetColorTableParameterivSGI := gl_GetProc('glGetColorTableParameterivSGI');
  end;
  {$EndIf}

  {$IfDef GL_SUNX_constant_data}
  if GL_SUNX_constant_data then
    glFinishTextureSUNX := gl_GetProc('glFinishTextureSUNX');
  {$EndIf}

  {$IfDef GL_SUN_global_alpha}
  if GL_SUN_global_alpha then
  begin
    glGlobalAlphaFactorbSUN := gl_GetProc('glGlobalAlphaFactorbSUN');
    glGlobalAlphaFactorsSUN := gl_GetProc('glGlobalAlphaFactorsSUN');
    glGlobalAlphaFactoriSUN := gl_GetProc('glGlobalAlphaFactoriSUN');
    glGlobalAlphaFactorfSUN := gl_GetProc('glGlobalAlphaFactorfSUN');
    glGlobalAlphaFactordSUN := gl_GetProc('glGlobalAlphaFactordSUN');
    glGlobalAlphaFactorubSUN := gl_GetProc('glGlobalAlphaFactorubSUN');
    glGlobalAlphaFactorusSUN := gl_GetProc('glGlobalAlphaFactorusSUN');
    glGlobalAlphaFactoruiSUN := gl_GetProc('glGlobalAlphaFactoruiSUN');
  end;
  {$EndIf}

  {$IfDef GL_SUN_mesh_array}
  if GL_SUN_mesh_array then
    glDrawMeshArraysSUN := gl_GetProc('glDrawMeshArraysSUN');
  {$EndIf}

  {$IfDef GL_SUN_triangle_list}
  if GL_SUN_triangle_list then
  begin
    glReplacementCodeuiSUN := gl_GetProc('glReplacementCodeuiSUN');
    glReplacementCodeusSUN := gl_GetProc('glReplacementCodeusSUN');
    glReplacementCodeubSUN := gl_GetProc('glReplacementCodeubSUN');
    glReplacementCodeuivSUN := gl_GetProc('glReplacementCodeuivSUN');
    glReplacementCodeusvSUN := gl_GetProc('glReplacementCodeusvSUN');
    glReplacementCodeubvSUN := gl_GetProc('glReplacementCodeubvSUN');
    glReplacementCodePointerSUN := gl_GetProc('glReplacementCodePointerSUN');
  end;
  {$EndIf}

  {$IfDef GL_SUN_vertex}
  if GL_SUN_vertex then
  begin
    glColor4ubVertex2fSUN := gl_GetProc('glColor4ubVertex2fSUN');
    glColor4ubVertex2fvSUN := gl_GetProc('glColor4ubVertex2fvSUN');
    glColor4ubVertex3fSUN := gl_GetProc('glColor4ubVertex3fSUN');
    glColor4ubVertex3fvSUN := gl_GetProc('glColor4ubVertex3fvSUN');
    glColor3fVertex3fSUN := gl_GetProc('glColor3fVertex3fSUN');
    glColor3fVertex3fvSUN := gl_GetProc('glColor3fVertex3fvSUN');
    glNormal3fVertex3fSUN := gl_GetProc('glNormal3fVertex3fSUN');
    glNormal3fVertex3fvSUN := gl_GetProc('glNormal3fVertex3fvSUN');
    glColor4fNormal3fVertex3fSUN := gl_GetProc('glColor4fNormal3fVertex3fSUN');
    glColor4fNormal3fVertex3fvSUN := gl_GetProc('glColor4fNormal3fVertex3fvSUN');
    glTexCoord2fVertex3fSUN := gl_GetProc('glTexCoord2fVertex3fSUN');
    glTexCoord2fVertex3fvSUN := gl_GetProc('glTexCoord2fVertex3fvSUN');
    glTexCoord4fVertex4fSUN := gl_GetProc('glTexCoord4fVertex4fSUN');
    glTexCoord4fVertex4fvSUN := gl_GetProc('glTexCoord4fVertex4fvSUN');
    glTexCoord2fColor4ubVertex3fSUN := gl_GetProc('glTexCoord2fColor4ubVertex3fSUN');
    glTexCoord2fColor4ubVertex3fvSUN := gl_GetProc('glTexCoord2fColor4ubVertex3fvSUN');
    glTexCoord2fColor3fVertex3fSUN := gl_GetProc('glTexCoord2fColor3fVertex3fSUN');
    glTexCoord2fColor3fVertex3fvSUN := gl_GetProc('glTexCoord2fColor3fVertex3fvSUN');
    glTexCoord2fNormal3fVertex3fSUN := gl_GetProc('glTexCoord2fNormal3fVertex3fSUN');
    glTexCoord2fNormal3fVertex3fvSUN := gl_GetProc('glTexCoord2fNormal3fVertex3fvSUN');
    glTexCoord2fColor4fNormal3fVertex3fSUN := gl_GetProc('glTexCoord2fColor4fNormal3fVertex3fSUN');
    glTexCoord2fColor4fNormal3fVertex3fvSUN := gl_GetProc('glTexCoord2fColor4fNormal3fVertex3fvSUN');
    glTexCoord4fColor4fNormal3fVertex4fSUN := gl_GetProc('glTexCoord4fColor4fNormal3fVertex4fSUN');
    glTexCoord4fColor4fNormal3fVertex4fvSUN := gl_GetProc('glTexCoord4fColor4fNormal3fVertex4fvSUN');
    glReplacementCodeuiVertex3fSUN := gl_GetProc('glReplacementCodeuiVertex3fSUN');
    glReplacementCodeuiVertex3fvSUN := gl_GetProc('glReplacementCodeuiVertex3fvSUN');
    glReplacementCodeuiColor4ubVertex3fSUN := gl_GetProc('glReplacementCodeuiColor4ubVertex3fSUN');
    glReplacementCodeuiColor4ubVertex3fvSUN := gl_GetProc('glReplacementCodeuiColor4ubVertex3fvSUN');
    glReplacementCodeuiColor3fVertex3fSUN := gl_GetProc('glReplacementCodeuiColor3fVertex3fSUN');
    glReplacementCodeuiColor3fVertex3fvSUN := gl_GetProc('glReplacementCodeuiColor3fVertex3fvSUN');
    glReplacementCodeuiNormal3fVertex3fSUN := gl_GetProc('glReplacementCodeuiNormal3fVertex3fSUN');
    glReplacementCodeuiNormal3fVertex3fvSUN := gl_GetProc('glReplacementCodeuiNormal3fVertex3fvSUN');
    glReplacementCodeuiColor4fNormal3fVertex3fSUN := gl_GetProc('glReplacementCodeuiColor4fNormal3fVertex3fSUN');
    glReplacementCodeuiColor4fNormal3fVertex3fvSUN := gl_GetProc('glReplacementCodeuiColor4fNormal3fVertex3fvSUN');
    glReplacementCodeuiTexCoord2fVertex3fSUN := gl_GetProc('glReplacementCodeuiTexCoord2fVertex3fSUN');
    glReplacementCodeuiTexCoord2fVertex3fvSUN := gl_GetProc('glReplacementCodeuiTexCoord2fVertex3fvSUN');
    glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN := gl_GetProc('glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN');
    glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN := gl_GetProc('glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN');
    glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN := gl_GetProc('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN');
    glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN := gl_GetProc('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN');
  end;
  {$EndIf}
end;

initialization

(*{$IFDEF FPC}
  {$IF DEFINED(cpui386) or DEFINED(cpux86_64)}
  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
  {$IFEND}
{$ELSE}
  Set8087CW($133F);
{$ENDIF}
*)

end.

