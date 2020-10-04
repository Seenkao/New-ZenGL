package zengl.demo10;

import zengl.android.ZenGL;

import android.app.Activity;
import android.os.Bundle;
import android.view.Window;
import android.view.WindowManager;

import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Configuration;

public class Demo10Activity extends Activity
{
	private ZenGL zengl;

	public void onCreate( Bundle savedInstanceState )
	{
		super.onCreate( savedInstanceState );

		// RU: полноэкранный режим
		// EN: set fullscreen mode
		this.requestWindowFeature( Window.FEATURE_NO_TITLE );
		getWindow().setFlags( WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN );

		// RU: получаем путь к apk
		// EN: get path to apk
		String appSourceDir = "";
		try
		{
			appSourceDir = getPackageManager().getApplicationInfo( "zengl.demo10", 0 ).sourceDir;
		}
		catch ( NameNotFoundException e ) {}

		// RU: создаём zglCGLSurfaceView, делаем его текущим и передаём имя pascal-библиотеки
		// EN: create new zglCGLSurfaceView, make it as a current view and pass name of pascal library
		zengl = new ZenGL( this, "demo10", appSourceDir );
		setContentView( zengl );
	}

	@Override
	public void onPause()
	{
		if ( zengl != null )
			zengl.onPause();
		super.onPause();
	}

	@Override
	public void onResume()
	{
		if ( zengl != null )
			zengl.onResume();
		super.onResume();
	}

	@Override
	public void onBackPressed()
	{
		if ( zengl.onBackPressed() )
			super.onBackPressed();
	}

	@Override
	public void onConfigurationChanged( Configuration newConfig )
	{
		super.onConfigurationChanged( newConfig );
	}
}