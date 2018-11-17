﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CursorMovement:MonoBehaviour {
	public Camera cam;
	public Vector2 position {
		get => tr.localPosition;
		set => tr.localPosition = new Vector3(value.x,value.y,tr.localPosition.z);
	}
	public bool complete => Mathf.Approximately(shakeProgress,1);
	public float shakeProgress = 0;
	public float shakeMultiplier = 1;
	
	Transform tr;
	HashSet<Collider2D> colliders;
	bool colliding => colliders.Count > 0;

	void Start() {
		tr = transform;
		shakeProgress = 0;
		shakeMultiplier = 1;
		colliders = new HashSet<Collider2D>();
	}

	void Update() {
		Vector2 newPos = cam.ScreenToWorldPoint(Input.mousePosition);
		var delta = newPos-position;
		if (delta != Vector2.zero) {
			position = newPos;
			if (!complete && colliding) {
				float m = Mathf.Min(delta.magnitude,.18f*shakeMultiplier);
				shakeProgress += Time.deltaTime*m*shakeMultiplier;
				if (shakeProgress > 1) shakeProgress = 1;
			}
		}
	}

	void OnTriggerEnter2D(Collider2D collision) => colliders.Add(collision);
	void OnTriggerStay2D(Collider2D collision) => colliders.Add(collision);
	void OnTriggerExit2D(Collider2D collision) => colliders.Remove(collision);
}
