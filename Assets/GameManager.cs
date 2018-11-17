using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameManager:MonoBehaviour {
	static GameManager me;
	static int m_energy;
	public static int energy {
		get => m_energy;
		set {
			m_energy = Mathf.Clamp(value,0,100);
			me.energyRect.sizeDelta = new Vector2(value,100);
			me.energyText.text = value.ToString();
		}
	}
	static int m_cash;
	public static int cash {
		get => m_cash;
		set {
			m_cash = Mathf.Max(value,0);
			me.cashText.text = value.ToString();
		}
	}

	public Text energyText, cashText;
	public RectTransform energyRect;

	void Awake() {
		me = this;
	}

	void Start() {
		energy = 50;
		cash = 50;
	}
}
