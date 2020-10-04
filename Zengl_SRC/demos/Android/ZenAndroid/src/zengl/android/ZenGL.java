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

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.egl.EGLSurface;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.app.Activity;
import android.content.Context;
import android.opengl.GLSurfaceView;
import android.os.Environment;
import android.text.InputType;
import android.view.*;
import android.view.inputmethod.BaseInputConnection;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.InputMethodManager;

public class ZenGL extends GLSurfaceView
{
	private native void Main();
	private native void zglNativeInit(String AppDirectory, String HomeDirectory);
	private native void zglNativeDestroy();
	private native void zglNativeSurfaceCreated();
	private native void zglNativeSurfaceChanged(int width, int height);
	private native void zglNativeDrawFrame();
	private native void zglNativeActivate(boolean Activate);
//	private native boolean zglNativeCloseQuery();
	private native void zglNativeTouch(int ID, float X, float Y, float Pressure);
	private native void zglNativeInputText(String Text);
	private native void zglNativeBackspace();
	
	// add function
	private native byte[] bArrPasToJava();
	private native void bArrJavaToPas(byte[] arr);

	private zglCRenderer Renderer;
	private String SourceDir;
	private String DataDir;
	private String SaveDir;					// дирректория для сохранения
	byte[] fBuffer;							// буффер для передачи данных
	private InputMethodManager InputManager;

	public ZenGL(Context context, String appSourceDir) {
		super(context);

		System.loadLibrary("zenjpeg");
		System.loadLibrary("openal");
		System.loadLibrary("ogg");
		System.loadLibrary("vorbis");
		System.loadLibrary("theoradec");
		System.loadLibrary("chipmunk");
		System.loadLibrary("GLU");
		System.loadLibrary("zenandroid");

		SourceDir = appSourceDir;
		DataDir = context.getFilesDir().getAbsolutePath();
		Renderer = new zglCRenderer();
		setRenderer(Renderer);

		InputManager = (InputMethodManager)context.getSystemService(Context.INPUT_METHOD_SERVICE);
		setFocusableInTouchMode(true);
		((Activity)context).getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);

		File fDir = null;
		// это не работает, надо искать способ сохранения данных на карту памяти, а это эмуляция
		if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED) == true) {
			fDir = Environment.getExternalStorageDirectory();
			fDir = new File(fDir.getPath() + "/zgldat");
			fDir.mkdirs();
		} 
		SaveDir = fDir.getPath();					// сработает это здесь? по идее должно
		
		zglNativeInit(SourceDir, DataDir);
		Main();										// запуск инициализации
	}

//	public Boolean onCloseQuery() {			удалил, есть функция выхода
//		return zglNativeCloseQuery();
//	}

	@Override
	public void onPause() {
		if (InputManager.isAcceptingText())
			HideKeyboard();

		super.onPause();
		zglNativeActivate(false);
	}

	@Override
	public void onResume() {
		super.onResume();
		zglNativeActivate(true);
	}

	@Override
	public boolean onTouchEvent(MotionEvent event) {
		int action = event.getAction();
		int actionType = action & MotionEvent.ACTION_MASK;

		switch (actionType) {
			case MotionEvent.ACTION_DOWN: {
				int count = event.getPointerCount();
				for (int i = 0; i < count; i++) {
					int pointerID = event.getPointerId(i);
					zglNativeTouch(pointerID, event.getX(i), event.getY(i), event.getPressure(i));
				}
				break;
			}

			case MotionEvent.ACTION_UP: {
				int count = event.getPointerCount();
				for (int i = 0; i < count; i++) {
					int pointerID = event.getPointerId(i);
					zglNativeTouch(pointerID, event.getX(i), event.getY(i), 0);
				}
				break;
			}

			case MotionEvent.ACTION_MOVE: {
				int count = event.getPointerCount();
				for (int i = 0; i < count; i++) {
					int pointerID = event.getPointerId(i);
					zglNativeTouch(pointerID, event.getX(i), event.getY(i), event.getPressure(i));
				}
				break;
			}

			case MotionEvent.ACTION_POINTER_DOWN: {
				int pointerID = (action & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;
				int pointerIndex = event.getPointerId(pointerID);
				if (pointerID >= 0 && pointerID < event.getPointerCount())
					zglNativeTouch(pointerIndex, event.getX(pointerID), event.getY(pointerID), event.getPressure(pointerID));
				break;
			}

			case MotionEvent.ACTION_POINTER_UP: {
				int pointerID = (action & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;
				int pointerIndex = event.getPointerId(pointerID);
				if (pointerID >= 0 && pointerID < event.getPointerCount())
					zglNativeTouch(pointerIndex, event.getX(pointerID), event.getY(pointerID), 0);
				break;
			}
		}

		return true;
	}

	public void Finish() {
		zglNativeDestroy();
		((Activity)getContext()).finish();
		System.exit(0);
	}

	// интересный факт, это для EGL!!! Поэтому он работает один раз, при активации
	public void SwapBuffers() {
	    try {
	    	EGL10 currEGL = (EGL10)EGLContext.getEGL();

	    	EGLDisplay currDisplay = currEGL.eglGetCurrentDisplay();
	    	if (currDisplay == EGL10.EGL_NO_DISPLAY) return;    

	    	EGLSurface currSurface = currEGL.eglGetCurrentSurface(EGL10.EGL_DRAW);
	    	if (currSurface == EGL10.EGL_NO_SURFACE) return;

	    	currEGL.eglSwapBuffers(currDisplay, currSurface);
	    } catch (Exception e) { }
	}

	// эти процедуры тоже убрать надо будет, вся клавиатура будет работать внутри
	public void ShowKeyboard() {
		InputManager.toggleSoftInput(InputMethodManager.SHOW_FORCED, InputMethodManager.HIDE_NOT_ALWAYS);
	}

	public void HideKeyboard() {
		InputManager.hideSoftInputFromWindow(this.getWindowToken(), 0);
	}

	// работа с клавиатурой
	@Override
	public InputConnection onCreateInputConnection(EditorInfo outAttrs) {
	    outAttrs.actionLabel = "";
	    outAttrs.hintText = "";
	    outAttrs.initialCapsMode = 0;
	    outAttrs.initialSelEnd = outAttrs.initialSelStart = -1;
	    outAttrs.label = "";
	    outAttrs.imeOptions = EditorInfo.IME_ACTION_DONE | EditorInfo.IME_FLAG_NO_EXTRACT_UI;
	    outAttrs.inputType = InputType.TYPE_NULL;

		return new zglInputConnection(this, false);
	}

	// это вообще что?
	@Override
	public boolean onCheckIsTextEditor() {
		return true;
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if (keyCode == KeyEvent.KEYCODE_ENTER)
			HideKeyboard();
		else if (keyCode == KeyEvent.KEYCODE_DEL)
			zglNativeBackspace();
		else if (keyCode >= KeyEvent.KEYCODE_0 && keyCode <= KeyEvent.KEYCODE_9)
			zglNativeInputText(((Integer)(keyCode - 7)).toString());

		return super.onKeyDown(keyCode, event);
	}

	// переработать
	public boolean onBackPressed() {
		//return zglNativeCloseQuery();	// изначально не верная функция, ни чего не уничтожалось...
		zglNativeDestroy();
		return true;					// какая фигня... кто вообще так делает? Как называется такое программирование?
	}

	// а это OpenGL!!!
	class zglCRenderer implements Renderer {
		public void onSurfaceCreated(GL10 gl, EGLConfig config) {
			zglNativeSurfaceCreated();
		}

		public void onSurfaceChanged(GL10 gl, int width, int height) {
			zglNativeSurfaceChanged(width, height);
		}

		public void onDrawFrame(GL10 gl) {
			zglNativeDrawFrame();
		}
	}

	class zglInputConnection extends BaseInputConnection {
		public zglInputConnection(View targetView, boolean fullEditor) {
			super(targetView, fullEditor);
		}

		@Override
		public boolean commitText(CharSequence text, int newCursorPosition) {
			zglNativeInputText((String)text);
			return true;
		}
	}
	
	// запись файла, данные уже должны быть в массиве буффера
		public boolean saveFile(String name) throws IOException {
			FileOutputStream fos = null;		// записываемые данные
			String path = SaveDir + "/" + name;
			try {
				fos = new FileOutputStream(path);
				fos.write(fBuffer);
				return true;
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			} finally {
				if (fos != null) {
					try {
						fos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		// чтение файла, записываем данные в массив буффера
		public boolean loadFile(String name) {
			FileInputStream fis = null;
			String path = SaveDir + "/" + name;
			try {
				File file = new File(path);
				fBuffer = new byte[(int) file.length()];
				fis = new FileInputStream(file);
				fis.read(fBuffer);
				return true;
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			} finally {
				if (fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
}