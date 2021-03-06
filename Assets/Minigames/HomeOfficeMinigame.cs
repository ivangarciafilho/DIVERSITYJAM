﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HomeOfficeMinigame:Minigame {
	public override int cash => 20;
	public override int energy => -10;

	public CursorMovement cursor;
	public Renderer content;
	public Texture2D[] contents;

	Vector3 size;
	
	float endTempo;
	float endPulse;

	void Awake() {
		size = content.transform.localScale;
	}
	
	protected override void Enable() {
		content.material.mainTexture = contents[Mathf.Clamp((int)(Random.value*contents.Length),0,contents.Length-1)];
		endTempo = 2;
		endPulse = 1;
		content.material.SetFloat("_Cutoff",1);
		content.transform.localScale = size;
	}

	void Update() {
		content.material.SetFloat("_Cutoff",1-cursor.shakeProgress);
		if (cursor.shakeComplete) {
			endPulse = Mathf.Lerp(endPulse,0,Time.deltaTime*10);
			content.transform.localScale = size*(1+.05f*endPulse);
			endTempo -= Time.deltaTime;
			if (endTempo <= 0) WinMinigame();
		}
	}
}
