/*
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
*/

#include "stdio.h"
#include <jconfig.h>
#include <jmorecfg.h>
#include <jpeglib.h>

typedef unsigned char* (*getmem_func)( int Size );

typedef struct{
    void* Memory;
    unsigned int MemSize;
    unsigned short Width;
    unsigned short Height;

    getmem_func GetMem;
} zglTJPGData;

void jpgturbo_Load( zglTJPGData *jpgData, unsigned char **Data )
{
  struct jpeg_decompress_struct cinfo;
  struct jpeg_error_mgr jerr;
  int scanline_width;
  JSAMPARRAY buffer;
  int i, j, iscan, grayscale;

  cinfo.err = jpeg_std_error( &jerr );
  jpeg_create_decompress( &cinfo );

  jpeg_mem_src( &cinfo, jpgData->Memory, jpgData->MemSize );

  jpeg_read_header( &cinfo, TRUE );
  jpeg_calc_output_dimensions( &cinfo );
  scanline_width = cinfo.output_width * cinfo.output_components;
  buffer = cinfo.mem->alloc_sarray( (j_common_ptr)&cinfo, JPOOL_IMAGE, scanline_width, 1 );

  jpeg_start_decompress( &cinfo );

  if ( cinfo.out_color_space == JCS_GRAYSCALE )
    grayscale = TRUE;
  else if ( cinfo.out_color_space == JCS_RGB )
  {
    if ( cinfo.quantize_colors )
      grayscale = TRUE;
    else
      grayscale = FALSE;
  } else return;

  jpgData->Width = cinfo.output_width;
  jpgData->Height = cinfo.output_height;
  (*Data) = jpgData->GetMem( cinfo.output_width * cinfo.output_height * 4 );

  if ( !grayscale )
  {
    while ( cinfo.output_scanline < cinfo.output_height )
    {
      iscan = ( cinfo.output_height - cinfo.output_scanline - 1 ) * cinfo.output_width * 4;
      jpeg_read_scanlines( &cinfo, buffer, 1 );
      for ( i = 0, j = 0; i < cinfo.output_width * 3; i += 3, j += 4 )
      {
        (*Data)[ j + 0 + iscan ] = (*buffer)[ i + 0 ];
        (*Data)[ j + 1 + iscan ] = (*buffer)[ i + 1 ];
        (*Data)[ j + 2 + iscan ] = (*buffer)[ i + 2 ];
        (*Data)[ j + 3 + iscan ] = 255;
      }
    }
  }
  else
  {
    while ( cinfo.output_scanline < cinfo.output_height )
    {
      iscan = ( cinfo.output_height - cinfo.output_scanline - 1 ) * cinfo.output_width * 4;
      jpeg_read_scanlines( &cinfo, buffer, 1 );
      for ( i = 0, j = 0; i < cinfo.output_width; i++, j += 4 )
      {
        (*Data)[ j + 0 + iscan ] = (*buffer)[ i ];
        (*Data)[ j + 1 + iscan ] = (*buffer)[ i ];
        (*Data)[ j + 2 + iscan ] = (*buffer)[ i ];
        (*Data)[ j + 3 + iscan ] = 255;
      }
    }
  }

  jpeg_finish_decompress( &cinfo );
  jpeg_destroy_decompress( &cinfo );
}
