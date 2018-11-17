using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PsScene:MonoBehaviour {
	public CursorMovement cursor;
	public Renderer content;
	public Texture2D[] contents;
	
	void Start() {
		content.material.mainTexture = contents[Mathf.Clamp((int)(Random.value*contents.Length),0,contents.Length-1)];
	}
	
	void Update() {
		content.material.SetFloat("_Cutoff",1-cursor.shakeProgress);
	}
}
