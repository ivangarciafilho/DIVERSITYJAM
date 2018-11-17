using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShowerMinigame:MonoBehaviour {
	static ShowerMinigame me;

	public CursorMovement cursor;
	public Transform arm;
	public Transform progress;
	public Renderer water;
	public Texture2D[] waterTex;
	
	float endTempo;

	Vector2 origin;
	Vector3 progressSize;

	void Awake() {
		me = this;
		origin = arm.localPosition;
		progressSize = progress.localScale;
	}

	void OnEnable() {
		endTempo = 2;
		progress.localScale = new Vector3(0,progressSize.y,progressSize.z);
	}

	void Update() {
		var c = cursor.position;
		var vector = c-origin;
		var magnitude = vector.magnitude;
		arm.localPosition = new Vector3((c.x+origin.x)*.5f,(c.y+origin.y)*.5f,arm.localPosition.z);
		arm.localScale = new Vector3(magnitude,arm.localScale.y,arm.localScale.z);
		if (!Mathf.Approximately(magnitude,0)) {
			arm.localEulerAngles = new Vector3(0,0,Mathf.Rad2Deg*Mathf.Atan2(vector.y,vector.x));
		}
		progress.localScale = new Vector3(progressSize.x*cursor.shakeProgress,progress.localScale.y,progress.localScale.z);
		progress.localPosition = new Vector3(-progressSize.x*.5f*(1-cursor.shakeProgress),progress.localPosition.y,progress.localPosition.z);
		water.material.mainTexture = waterTex[Mathf.Clamp((int)(Time.time*6)%waterTex.Length,0,waterTex.Length-1)];
		if (cursor.shakeComplete) {
			float y = Mathf.Lerp(progress.localScale.y,0,Time.deltaTime*10);
			progress.localScale = new Vector3(progress.localScale.x,y,progress.localScale.z);
			endTempo -= Time.deltaTime;
			if (endTempo <= 0) DisableMinigame();
		}
	}

	public static void EnableMinigame() {
		me.gameObject.SetActive(true);
	}

	public static void DisableMinigame() {
		me.gameObject.SetActive(false);
	}
}
