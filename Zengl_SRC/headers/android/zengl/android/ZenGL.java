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
package zengl.android;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.egl.EGLSurface;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.app.Activity;
import android.content.Context;
import android.opengl.GLSurfaceView;
import android.text.InputType;
import android.view.*;
import android.view.inputmethod.BaseInputConnection;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.InputMethodManager;

public class ZenGL extends GLSurfaceView
{
	private native void Main();
	private native void zglNativeInit( String AppDirectory, String HomeDirectory );
	private native void zglNativeDestroy();
	private native void zglNativeSurfaceCreated();
	private native void zglNativeSurfaceChanged( int width, int height );
	private native void zglNativeDrawFrame();
	private native void zglNativeActivate( boolean Activate );
	private native boolean zglNativeCloseQuery();
	private native void zglNativeTouch( int ID, float X, float Y, float Pressure );
	private native void zglNativeInputText( String Text );
	private native void zglNativeBackspace();

	private zglCRenderer Renderer;
	private String SourceDir;
	private String DataDir;
	private InputMethodManager InputManager;

	public ZenGL( Context context, String appName, String appSourceDir )
	{
		super( context );

		System.loadLibrary( "zenjpeg" );
		System.loadLibrary( "openal" );
		System.loadLibrary( "ogg" );
		System.loadLibrary( "vorbis" );
		System.loadLibrary( "theoradec" );
		System.loadLibrary( "chipmunk" );
		System.loadLibrary( "GLU" );
		System.loadLibrary( appName );

		SourceDir = appSourceDir;
		DataDir = context.getFilesDir().getAbsolutePath();
		Renderer = new zglCRenderer();
		setRenderer( Renderer );

		InputManager = (InputMethodManager)context.getSystemService( Context.INPUT_METHOD_SERVICE );
		setFocusableInTouchMode( true );
		((Activity)context).getWindow().setSoftInputMode( WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN );

		zglNativeInit( SourceDir, DataDir );
		Main();
	}

	public Boolean onCloseQuery()
	{
		return zglNativeCloseQuery();
	}

	@Override
	public void onPause()
	{
		if ( InputManager.isAcceptingText() )
			HideKeyboard();

		super.onPause();
		zglNativeActivate( false );
	}

	@Override
	public void onResume()
	{
		super.onResume();
		zglNativeActivate( true );
	}

	@Override
	public boolean onTouchEvent( MotionEvent event )
	{
		int action = event.getAction();
		int actionType = action & MotionEvent.ACTION_MASK;

		switch ( actionType )
		{
			case MotionEvent.ACTION_DOWN:
			{
				int count = event.getPointerCount();
				for ( int i = 0; i < count; i++ )
				{
					int pointerID = event.getPointerId( i );
					zglNativeTouch( pointerID, event.getX( i ), event.getY( i ), event.getPressure( i ) );
				}
				break;
			}

			case MotionEvent.ACTION_UP:
			{
				int count = event.getPointerCount();
				for ( int i = 0; i < count; i++ )
				{
					int pointerID = event.getPointerId( i );
					zglNativeTouch( pointerID, event.getX( i ), event.getY( i ), 0 );
				}
				break;
			}

			case MotionEvent.ACTION_MOVE:
			{
				int count = event.getPointerCount();
				for ( int i = 0; i < count; i++ )
				{
					int pointerID = event.getPointerId( i );
					zglNativeTouch( pointerID, event.getX( i ), event.getY( i ), event.getPressure( i ) );
				}
				break;
			}

			case MotionEvent.ACTION_POINTER_DOWN:
			{
				int pointerID = ( action & MotionEvent.ACTION_POINTER_ID_MASK ) >> MotionEvent.ACTION_POINTER_ID_SHIFT;
				int pointerIndex = event.getPointerId( pointerID );
				if ( pointerID >= 0 && pointerID < event.getPointerCount() )
					zglNativeTouch( pointerIndex, event.getX( pointerID ), event.getY( pointerID ), event.getPressure( pointerID ) );
				break;
			}

			case MotionEvent.ACTION_POINTER_UP:
			{
				int pointerID = ( action & MotionEvent.ACTION_POINTER_ID_MASK ) >> MotionEvent.ACTION_POINTER_ID_SHIFT;
				int pointerIndex = event.getPointerId( pointerID );
				if ( pointerID >= 0 && pointerID < event.getPointerCount() )
					zglNativeTouch( pointerIndex, event.getX( pointerID ), event.getY( pointerID ), 0 );
				break;
			}
		}

		return true;
	}

	public void Finish()
	{
		zglNativeDestroy();
		((Activity)getContext()).finish();
		System.exit( 0 );
	}

	public void SwapBuffers()
	{
	    try {
	    	EGL10 currEGL = (EGL10)EGLContext.getEGL();

	    	EGLDisplay currDisplay = currEGL.eglGetCurrentDisplay();
	    	if ( currDisplay == EGL10.EGL_NO_DISPLAY ) return;    

	    	EGLSurface currSurface = currEGL.eglGetCurrentSurface( EGL10.EGL_DRAW );
	    	if ( currSurface == EGL10.EGL_NO_SURFACE ) return;

	    	currEGL.eglSwapBuffers( currDisplay, currSurface);
	    } catch ( Exception e ) { }
	}

	public void ShowKeyboard()
	{
		InputManager.toggleSoftInput( InputMethodManager.SHOW_FORCED, InputMethodManager.HIDE_NOT_ALWAYS );
	}

	public void HideKeyboard()
	{
		InputManager.hideSoftInputFromWindow( this.getWindowToken(), 0 );
	}

	@Override
	public InputConnection onCreateInputConnection( EditorInfo outAttrs )
	{
	    outAttrs.actionLabel = "";
	    outAttrs.hintText = "";
	    outAttrs.initialCapsMode = 0;
	    outAttrs.initialSelEnd = outAttrs.initialSelStart = -1;
	    outAttrs.label = "";
	    outAttrs.imeOptions = EditorInfo.IME_ACTION_DONE | EditorInfo.IME_FLAG_NO_EXTRACT_UI;
	    outAttrs.inputType = InputType.TYPE_NULL;

		return new zglInputConnection( this, false );
	}

	@Override
	public boolean onCheckIsTextEditor()
	{
		return true;
	}

	@Override
	public boolean onKeyDown( int keyCode, KeyEvent event )
	{
		if ( keyCode == KeyEvent.KEYCODE_ENTER )
			HideKeyboard();
		else if ( keyCode == KeyEvent.KEYCODE_DEL )
			zglNativeBackspace();
		else if ( keyCode >= KeyEvent.KEYCODE_0 && keyCode <= KeyEvent.KEYCODE_9 )
			zglNativeInputText( ((Integer)(keyCode - 7)).toString() );

		return super.onKeyDown( keyCode, event );
	}

	public boolean onBackPressed()
	{
		return zglNativeCloseQuery();
	}

	class zglCRenderer implements Renderer
	{
		public void onSurfaceCreated( GL10 gl, EGLConfig config )
		{
			zglNativeSurfaceCreated();
		}

		public void onSurfaceChanged( GL10 gl, int width, int height )
		{
			zglNativeSurfaceChanged( width, height );
		}

		public void onDrawFrame( GL10 gl )
		{
			zglNativeDrawFrame();
		}
	}

	class zglInputConnection extends BaseInputConnection
	{
		public zglInputConnection( View targetView, boolean fullEditor )
		{
			super( targetView, fullEditor );
		}

		@Override
		public boolean commitText( CharSequence text, int newCursorPosition )
		{
			zglNativeInputText( (String)text );

			return true;
		}
	}
}