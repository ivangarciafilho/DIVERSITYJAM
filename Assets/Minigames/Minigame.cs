using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Minigame:MonoBehaviour {
	public abstract int cash { get; }
	public abstract int energy { get; }

	bool won;

	protected virtual void Enable() { }
	protected virtual void Disable() { }

	void OnEnable() {
		transform.position = Vector3.zero;
		won = false;
		if (GameManager.cash+cash < 0 || GameManager.energy+energy < 0) {
			gameObject.SetActive(false);
		} else {
			Enable();
		}
	}

	void OnDisable() {
		if (won) {
			GameManager.cash += cash;
			GameManager.energy += energy;
		}
		Disable();
	}

	protected void WinMinigame(bool close = true) {
		won = true;
		if (close) gameObject.SetActive(false);
	}
}
