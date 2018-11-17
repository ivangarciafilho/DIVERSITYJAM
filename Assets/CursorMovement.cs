using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CursorMovement:MonoBehaviour {
	public Vector2 position => tr.position;
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
		var delta = new Vector2(Input.GetAxisRaw("Mouse X"),Input.GetAxisRaw("Mouse Y"))*.2f;
		tr.localPosition = new Vector3(tr.localPosition.x+delta.x,tr.localPosition.y+delta.y,tr.localPosition.z);
		if (!complete && colliding) {
			float m = Mathf.Min(delta.magnitude,.18f*shakeMultiplier);
			if (!Mathf.Approximately(m,0)) {
				shakeProgress += Time.deltaTime*m*shakeMultiplier;
				if (shakeProgress > 1) shakeProgress = 1;
			}
		}
	}

	void OnTriggerEnter2D(Collider2D collision) => colliders.Add(collision);
	void OnTriggerStay2D(Collider2D collision) => colliders.Add(collision);
	void OnTriggerExit2D(Collider2D collision) => colliders.Remove(collision);
}
