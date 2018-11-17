using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HomeOfficeMinigame:MonoBehaviour {
	static HomeOfficeMinigame me;

	public CursorMovement cursor;
	public Renderer content;
	public Texture2D[] contents;

	float endTempo;
	float endPulse;

	void Awake() {
		me = this;
		Restart();
	}

	void Restart() {
		content.material.mainTexture = contents[Mathf.Clamp((int)(Random.value*contents.Length),0,contents.Length-1)];
		endTempo = 2;
		endPulse = 1;
	}
	
	void Update() {
		content.material.SetFloat("_Cutoff",1-cursor.shakeProgress);
		if (cursor.complete) {
			endPulse = Mathf.Lerp(endPulse,0,Time.deltaTime*10);
			content.transform.localScale = Vector3.one*(1+.05f*endPulse);
			cursor.tr.localScale = Vector3.Lerp(cursor.tr.localScale,Vector3.zero,Time.deltaTime*10);
			endTempo -= Time.deltaTime;
			if (endTempo <= 0) DisableMinigame();
		}
	}
	
	public static void EnableMinigame() {
		me.gameObject.SetActive(true);
		me.Restart();
	}

	public static void DisableMinigame() {
		me.gameObject.SetActive(false);
	}
}
