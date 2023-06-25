{
 *  Copyright (c) 2012 Andrey Kemka
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
}
library ZenGL;

{$I zgl_config.cfg}

uses
  zgl_application,

  zgl_screen,
  zgl_window,

  zgl_timers,

  zgl_ini,
  zgl_log,

  zgl_mouse,
  zgl_keyboard,
  {$IFDEF ANDROID}
  zgl_touch,
  {$ENDIF}
  {$IFDEF USE_JOYSTICK}
  zgl_joystick,
  {$ENDIF}

  zgl_resources,

  zgl_textures,
  {$IFDEF USE_JPG}
  zgl_textures_jpg,
  {$ENDIF}
  {$IFDEF USE_PNG}
  zgl_textures_png,
  {$ENDIF}
  {$IFDEF USE_TGA}
  zgl_textures_tga,
  {$ENDIF}

  zgl_render_target,

  {$IFDEF USE_SOUND}
  zgl_sound,
  {$IFDEF USE_OGG}
  zgl_sound_ogg,
  {$ENDIF}
  {$IFDEF USE_WAV}
  zgl_sound_wav,
  {$ENDIF}
  {$ENDIF}

  {$IFDEF USE_VIDEO}
  zgl_video,
  {$IFDEF USE_THEORA}
  zgl_video_theora,
  {$ENDIF}
  {$ENDIF}

  zgl_render,
  zgl_render_2d,

  zgl_fx,
  zgl_camera_2d,

  zgl_font,
  zgl_text,

  zgl_primitives_2d,
  {$IFDEF USE_SENGINE}
  zgl_sengine_2d,
  {$ENDIF}
  {$IFDEF USE_PARTICLES}
  zgl_particles_2d,
  {$ENDIF}
  zgl_sprite_2d,
  zgl_tiles_2d,
  zgl_grid_2d,

  zgl_file,
  zgl_memory,

  zgl_math_2d,

  zgl_collision_2d,

  zgl_utils
  ;

const
// I hate Apple! :)
  {$IFDEF MAC_COCOA}
  prefix = '_';
  {$ELSE}
  prefix = '';
  {$ENDIF}

exports
  // Main
  zgl_Init                 name prefix + 'zgl_Init',
  zgl_InitToHandle         name prefix + 'zgl_InitToHandle',

  zgl_Exit                 name prefix + 'zgl_Exit',
  zgl_Reg                  name prefix + 'zgl_Reg',
  zgl_Get                  name prefix + 'zgl_Get',
  zgl_GetMem               name prefix + 'zgl_GetMem',
  zgl_FreeMem              name prefix + 'zgl_FreeMem',
  zgl_FreeStrList          name prefix + 'zgl_FreeStrList',
  zgl_Enable               name prefix + 'zgl_Enable',
  zgl_Disable              name prefix + 'zgl_Disable',
  log_Add                  name prefix + 'log_Add',

  // Window
  wnd_SetCaption           name prefix + 'wnd_SetCaption',
  wnd_SetSize              name prefix + 'wnd_SetSize',
  wnd_SetPos               name prefix + 'wnd_SetPos',
  wnd_ShowCursor           name prefix + 'wnd_ShowCursor',

  // Screen
  scr_Clear                name prefix + 'scr_Clear',
  scr_Flush                name prefix + 'scr_Flush',
  scr_SetVSync             name prefix + 'scr_SetVSync',
  scr_SetFSAA              name prefix + 'scr_SetFSAA',
  scr_SetOptions           name prefix + 'scr_SetOptions',
  scr_CorrectResolution    name prefix + 'scr_CorrectResolution',
  scr_ReadPixels           name prefix + 'scr_ReadPixels',

  // INI
  ini_LoadFromFile         name prefix + 'ini_LoadFromFile',
  ini_SaveToFile           name prefix + 'ini_SaveToFile',
  ini_Free                 name prefix + 'ini_Free',
  ini_Add                  name prefix + 'ini_Add',
  ini_Del                  name prefix + 'ini_Del',
  ini_Clear                name prefix + 'ini_Clear',
  ini_IsSection            name prefix + 'ini_IsSection',
  ini_IsKey                name prefix + 'ini_IsKey',
  _ini_ReadKeyStr          name prefix + 'ini_ReadKeyStr',
  ini_ReadKeyInt           name prefix + 'ini_ReadKeyInt',
  ini_ReadKeyFloat         name prefix + 'ini_ReadKeyFloat',
  ini_ReadKeyBool          name prefix + 'ini_ReadKeyBool',
  ini_WriteKeyStr          name prefix + 'ini_WriteKeyStr',
  ini_WriteKeyInt          name prefix + 'ini_WriteKeyInt',
  ini_WriteKeyFloat        name prefix + 'ini_WriteKeyFloat',
  ini_WriteKeyBool         name prefix + 'ini_WriteKeyBool',

  // Timers
  timer_Add                name prefix + 'timer_Add',
  timer_Del                name prefix + 'timer_Del',
  timer_GetTicks           name prefix + 'timer_GetTicks',
  timer_Reset              name prefix + 'timer_Reset',

  // Mouse
  mouse_X                  name prefix + 'mouse_X',
  mouse_Y                  name prefix + 'mouse_Y',
  mouse_DX                 name prefix + 'mouse_DX',
  mouse_DY                 name prefix + 'mouse_DY',
  mouse_Down               name prefix + 'mouse_Down',
  mouse_Up                 name prefix + 'mouse_Up',
  mouse_Click              name prefix + 'mouse_Click',
  mouse_DblClick           name prefix + 'mouse_DblClick',
  mouse_Wheel              name prefix + 'mouse_Wheel',
  mouse_ClearState         name prefix + 'mouse_ClearState',
  mouse_Lock               name prefix + 'mouse_Lock',

  // Keyboard
  key_Down                 name prefix + 'key_Down',
  key_Up                   name prefix + 'key_Up',
  key_Press                name prefix + 'key_Press',
  key_Last                 name prefix + 'key_Last',
  key_BeginReadText        name prefix + 'key_BeginReadText',
  key_UpdateReadText       name prefix + 'key_UpdateReadText',
  _key_GetText             name prefix + 'key_GetText',
  key_EndReadText          name prefix + 'key_EndReadText',
  key_ClearState           name prefix + 'key_ClearState',

  // Touch
  {$IFDEF ANDROID}
  touch_X                   name prefix + 'touch_X',
  touch_Y                   name prefix + 'touch_Y',
  touch_Down                name prefix + 'touch_Down',
  touch_Up                  name prefix + 'touch_Up',
  touch_Tap                 name prefix + 'touch_Tap',
  touch_DblTap              name prefix + 'touch_DblTap',
  touch_ClearState          name prefix + 'touch_ClearState',
  {$ENDIF}

  // Joystick
  {$IFDEF USE_JOYSTICK}
  joy_Init                 name prefix + 'joy_Init',
  joy_GetInfo              name prefix + 'joy_GetInfo',
  joy_AxisPos              name prefix + 'joy_AxisPos',
  joy_Down                 name prefix + 'joy_Down',
  joy_Up                   name prefix + 'joy_Up',
  joy_Press                name prefix + 'joy_Press',
  joy_ClearState           name prefix + 'joy_ClearState',
  {$ENDIF}

  res_BeginQueue           name prefix + 'res_BeginQueue',
  res_EndQueue             name prefix + 'res_EndQueue',
  res_GetPercentage        name prefix + 'res_GetPercentage',
  res_GetCompleted         name prefix + 'res_GetCompleted',
  res_Proc                 name prefix + 'res_Proc',

  // Textures
  tex_Add                  name prefix + 'tex_Add',
  tex_Del                  name prefix + 'tex_Del',
  tex_Create               name prefix + 'tex_Create',
  tex_CreateZero           name prefix + 'tex_CreateZero',
  tex_LoadFromFile         name prefix + 'tex_LoadFromFile',
  tex_LoadFromMemory       name prefix + 'tex_LoadFromMemory',
  tex_SetFrameSize         name prefix + 'tex_SetFrameSize',
  tex_SetMask              name prefix + 'tex_SetMask',
  tex_SetData              name prefix + 'tex_SetData',
  tex_GetData              name prefix + 'tex_GetData',
  tex_Filter               name prefix + 'tex_Filter',
  tex_SetAnisotropy        name prefix + 'tex_SetAnisotropy',

  // OpenGL
  Set2DMode                name prefix + 'Set2DMode',
  Set3DMode                name prefix + 'Set3DMode',

  // Z Buffer
  zbuffer_SetDepth         name prefix + 'zbuffer_SetDepth',
  zbuffer_Clear            name prefix + 'zbuffer_Clear',

  // Scissor
  scissor_Begin            name prefix + 'scissor_Begin',
  scissor_End              name prefix + 'scissor_End',

  // Render Targets
  rtarget_Add              name prefix + 'rtarget_Add',
  rtarget_Del              name prefix + 'rtarget_Del',
  rtarget_Set              name prefix + 'rtarget_Set',
  rtarget_DrawIn           name prefix + 'rtarget_DrawIn',

  // FX
  fx_SetBlendMode          name prefix + 'fx_SetBlendMode',
  fx_SetColorMode          name prefix + 'fx_SetColorMode',
  fx_SetColorMask          name prefix + 'fx_SetColorMask',
  // FX 2D
  fx2d_SetColor            name prefix + 'fx2d_SetColor',
  fx2d_SetVCA              name prefix + 'fx2d_SetVCA',
  fx2d_SetVertexes         name prefix + 'fx2d_SetVertexes',
  fx2d_SetScale            name prefix + 'fx2d_SetScale',
  fx2d_SetRotatingPivot    name prefix + 'fx2d_SetRotatingPivot',

  // Camera 2D
  cam2d_Init               name prefix + 'cam2d_Init',
  cam2d_Set                name prefix + 'cam2d_Set',
  cam2d_Get                name prefix + 'cam2d_Get',

  // Render 2D
  batch2d_Begin            name prefix + 'batch2d_Begin',
  batch2d_End              name prefix + 'batch2d_End',
  batch2d_Flush            name prefix + 'batch2d_Flush',

  // Primitives 2D
  pr2d_Pixel               name prefix + 'pr2d_Pixel',
  pr2d_Line                name prefix + 'pr2d_Line',
  pr2d_Rect                name prefix + 'pr2d_Rect',
  pr2d_Circle              name prefix + 'pr2d_Circle',
  pr2d_Ellipse             name prefix + 'pr2d_Ellipse',
  pr2d_TriList             name prefix + 'pr2d_TriList',

  // Sprite Engine 2D
  {$IFDEF USE_SENGINE}
  sengine2d_AddSprite      name prefix + 'sengine2d_AddSprite',
  sengine2d_AddCustom      name prefix + 'sengine2d_AddCustom',
  sengine2d_DelSprite      name prefix + 'sengine2d_DelSprite',
  sengine2d_ClearAll       name prefix + 'sengine2d_ClearAll',
  sengine2d_Set            name prefix + 'sengine2d_Set',
  sengine2d_Draw           name prefix + 'sengine2d_Draw',
  sengine2d_Proc           name prefix + 'sengine2d_Proc',
  {$ENDIF}

  // Particles Engine 2D
  {$IFDEF USE_PARTICLES}
  pengine2d_Set            name prefix + 'pengine2d_Set',
  pengine2d_Get            name prefix + 'pengine2d_Get',
  pengine2d_Draw           name prefix + 'pengine2d_Draw',
  pengine2d_Proc           name prefix + 'pengine2d_Proc',
  pengine2d_AddEmitter     name prefix + 'pengine2d_AddEmitter',
  pengine2d_DelEmitter     name prefix + 'pengine2d_DelEmitter',
  pengine2d_ClearAll       name prefix + 'pengine2d_ClearAll',
  emitter2d_Add            name prefix + 'emitter2d_Add',
  emitter2d_Del            name prefix + 'emitter2d_Del',
  emitter2d_LoadFromFile   name prefix + 'emitter2d_LoadFromFile',
  emitter2d_LoadFromMemory name prefix + 'emitter2d_LoadFromMemory',
  emitter2d_Init           name prefix + 'emitter2d_Init',
  emitter2d_Free           name prefix + 'emitter2d_Free',
  emitter2d_Draw           name prefix + 'emitter2d_Draw',
  emitter2d_Proc           name prefix + 'emitter2d_Proc',
  {$ENDIF}

  // Sprite 2D
  texture2d_Draw           name prefix + 'texture2d_Draw',
  ssprite2d_Draw           name prefix + 'ssprite2d_Draw',
  asprite2d_Draw           name prefix + 'asprite2d_Draw',
  csprite2d_Draw           name prefix + 'csprite2d_Draw',
  tiles2d_Draw             name prefix + 'tiles2d_Draw',
  sgrid2d_Draw             name prefix + 'sgrid2d_Draw',
  agrid2d_Draw             name prefix + 'agrid2d_Draw',
  cgrid2d_Draw             name prefix + 'cgrid2d_Draw',

  // Text
  font_Add                 name prefix + 'font_Add',
  font_Del                 name prefix + 'font_Del',
  font_LoadFromFile        name prefix + 'font_LoadFromFile',
  font_LoadFromMemory      name prefix + 'font_LoadFromMemory',
  text_Draw                name prefix + 'text_Draw',
  text_DrawEx              name prefix + 'text_DrawEx',
  text_DrawInRect          name prefix + 'text_DrawInRect',
  text_DrawInRectEx        name prefix + 'text_DrawInRectEx',
  text_GetWidth            name prefix + 'text_GetWidth',
  text_GetHeight           name prefix + 'text_GetHeight',
  textFx_SetLength         name prefix + 'textFx_SetLength',

  // Sound
  {$IFDEF USE_SOUND}
  snd_Init                 name prefix + 'snd_Init',
  snd_Free                 name prefix + 'snd_Free',
  snd_Add                  name prefix + 'snd_Add',
  snd_Del                  name prefix + 'snd_Del',
  snd_LoadFromFile         name prefix + 'snd_LoadFromFile',
  snd_LoadFromMemory       name prefix + 'snd_LoadFromMemory',
  snd_Play                 name prefix + 'snd_Play',
  snd_Stop                 name prefix + 'snd_Stop',
  snd_SetPos               name prefix + 'snd_SetPos',
  snd_SetVolume            name prefix + 'snd_SetVolume',
  snd_Get                  name prefix + 'snd_Get',
  snd_SetSpeed             name prefix + 'snd_SetSpeed',
  snd_PlayFile             name prefix + 'snd_PlayFile',
  snd_PlayMemory           name prefix + 'snd_PlayMemory',
  snd_PauseStream          name prefix + 'snd_PauseStream',
  snd_StopStream           name prefix + 'snd_StopStream',
  snd_ResumeStream         name prefix + 'snd_ResumeStream',
  snd_SeekStream           name prefix + 'snd_SeekStream',
  {$ENDIF}

  // Video
  {$IFDEF USE_VIDEO}
  video_Add                name prefix + 'video_Add',
  video_Del                name prefix + 'video_Del',
  video_OpenFile           name prefix + 'video_OpenFile',
  video_OpenMemory         name prefix + 'video_OpenMemory',
  video_Update             name prefix + 'video_Update',
  video_Seek               name prefix + 'video_Seek',
  {$ENDIF}

  // Math
  //
  m_Cos                    name prefix + 'm_Cos',
  m_Sin                    name prefix + 'm_Sin',
  m_Distance               name prefix + 'm_Distance',
  m_FDistance              name prefix + 'm_FDistance',
  m_Angle                  name prefix + 'm_Angle',
  m_Orientation            name prefix + 'm_Orientation',

  {$IFDEF USE_TRIANGULATION}
  tess_Triangulate         name prefix + 'tess_Triangulate',
  tess_AddHole             name prefix + 'tess_AddHole',
  tess_GetData             name prefix + 'tess_GetData',
  {$ENDIF}

  // Collision 2D
  col2d_PointInRect        name prefix + 'col2d_PointInRect',
  col2d_PointInTriangle    name prefix + 'col2d_PointInTriangle',
  col2d_PointInCircle      name prefix + 'col2d_PointInCircle',
  col2d_Line               name prefix + 'col2d_Line',
  col2d_LineVsRect         name prefix + 'col2d_LineVsRect',
  col2d_LineVsCircle       name prefix + 'col2d_LineVsCircle',
  col2d_Rect               name prefix + 'col2d_Rect',
  col2d_ClipRect           name prefix + 'col2d_ClipRect',
  col2d_RectInRect         name prefix + 'col2d_RectInRect',
  col2d_RectInCircle       name prefix + 'col2d_RectInCircle',
  col2d_RectVsCircle       name prefix + 'col2d_RectVsCircle',
  col2d_Circle             name prefix + 'col2d_Circle',
  col2d_CircleInCircle     name prefix + 'col2d_CircleInCircle',
  col2d_CircleInRect       name prefix + 'col2d_CircleInRect',

  // Utils
  file_Open                name prefix + 'file_Open',
  file_MakeDir             name prefix + 'file_MakeDir',
  file_Remove              name prefix + 'file_Remove',
  file_Exists              name prefix + 'file_Exists',
  file_Seek                name prefix + 'file_Seek',
  file_GetPos              name prefix + 'file_GetPos',
  file_Read                name prefix + 'file_Read',
  file_Write               name prefix + 'file_Write',
  file_GetSize             name prefix + 'file_GetSize',
  file_Flush               name prefix + 'file_Flush',
  file_Close               name prefix + 'file_Close',
  file_Find                name prefix + 'file_Find',
  _file_GetName            name prefix + 'file_GetName',
  _file_GetExtension       name prefix + 'file_GetExtension',
  _file_GetDirectory       name prefix + 'file_GetDirectory',
  file_SetPath             name prefix + 'file_SetPath',
  {$IFDEF USE_ZIP}
  file_OpenArchive         name prefix + 'file_OpenArchive',
  file_CloseArchive        name prefix + 'file_CloseArchive',
  {$ENDIF}

  mem_LoadFromFile         name prefix + 'mem_LoadFromFile',
  mem_SaveToFile           name prefix + 'mem_SaveToFile',
  mem_Seek                 name prefix + 'mem_Seek',
  mem_Read                 name prefix + 'mem_Read',
  mem_ReadSwap             name prefix + 'mem_ReadSwap',
  mem_Write                name prefix + 'mem_Write',
  mem_SetSize              name prefix + 'mem_SetSize',
  mem_Free                 name prefix + 'mem_Free',

  utf8_Length              name prefix + 'utf8_Length',
  utf8_GetShift            name prefix + 'utf8_GetShift',
  utf8_GetID               name prefix + 'utf8_GetID',
  u_SortList               name prefix + 'u_SortList',
  u_Hash                   name prefix + 'u_Hash',
  u_Sleep                  name prefix + 'u_Sleep'
  ;

{$R *.res}

begin
end.
