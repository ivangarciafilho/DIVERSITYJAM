using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShowerScene:MonoBehaviour {
	public Transform soap;
	public Transform arm;
	public Transform progress;
	public Renderer water;
	public Texture2D[] waterTex;

	Vector2 cursor;
	Vector2 origin;

	float t;
	float progressWidth;
	bool complete;
	
	void Start() {
		cursor = soap.localPosition;
		origin = arm.localPosition;
		t = 0;
		progressWidth = progress.localScale.x;
		complete = false;
	}

	void Update() {
		var cursorDelta = new Vector2(Input.GetAxisRaw("Mouse X"),Input.GetAxisRaw("Mouse Y"))*.2f;
		cursor += cursorDelta;
		if (!complete) {
			if (cursor.x > -.7f && cursor.x < .7f && cursor.y > -3.5f && cursor.y < .5f) {
				float m = Mathf.Min(cursorDelta.magnitude,.18f);
				if (!Mathf.Approximately(m,0)) {
					t += Time.deltaTime*m;
					if (t >= 1 || Mathf.Approximately(t,1)) {
						t = 1;
						complete = true;
					}
				}
			}
		}
		var vector = cursor-origin;
		var magnitude = vector.magnitude;
		arm.localPosition = new Vector3((cursor.x+origin.x)*.5f,(cursor.y+origin.y)*.5f,arm.localPosition.z);
		arm.localScale = new Vector3(magnitude,arm.localScale.y,arm.localScale.z);
		if (!Mathf.Approximately(magnitude,0)) {
			arm.localEulerAngles = new Vector3(0,0,Mathf.Rad2Deg*Mathf.Atan2(vector.y,vector.x));
		}
		soap.localPosition = new Vector3(cursor.x,cursor.y,soap.localPosition.z);
		progress.localScale = new Vector3(progressWidth*t,progress.localScale.y,progress.localScale.z);
		progress.localPosition = new Vector3(-progressWidth*.5f*(1-t),progress.localPosition.y,progress.localPosition.z);
		water.material.mainTexture = waterTex[Mathf.Clamp((int)(Time.time*6)%waterTex.Length,0,waterTex.Length-1)];
	}
}
