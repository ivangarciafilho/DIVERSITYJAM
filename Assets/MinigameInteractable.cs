using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MinigameInteractable:MonoBehaviour {
	public Minigame minigame;
	public Text energy, cash;
	
	void Start() {
		SetText(energy,minigame.energy);
		SetText(cash,minigame.cash);
	}
	
	void SetText(Text text,int value) {
		text.text = value.ToString();
		if (value > 0) {
			text.color = Color.green;
		} else if (value < 0) {
			text.color = Color.red;
		} else {
			text.color = Color.white;
		}
	}
}
