using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShowerScene:MonoBehaviour {
	public CursorMovement cursor;
	public Transform arm;
	public Transform progress;
	public Renderer water;
	public Texture2D[] waterTex;
	
	Vector2 origin;
	float progressWidth;
	
	void Start() {
		origin = arm.localPosition;
		progressWidth = progress.localScale.x;
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
		progress.localScale = new Vector3(progressWidth*cursor.shakeProgress,progress.localScale.y,progress.localScale.z);
		progress.localPosition = new Vector3(-progressWidth*.5f*(1-cursor.shakeProgress),progress.localPosition.y,progress.localPosition.z);
		water.material.mainTexture = waterTex[Mathf.Clamp((int)(Time.time*6)%waterTex.Length,0,waterTex.Length-1)];
	}
}
