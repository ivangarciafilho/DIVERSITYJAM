using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices.WindowsRuntime;
using UnityEngine;
using UnityEngine.Events;

public class FireEventOnKeyDown : MonoBehaviour
{
    public KeyCode triggeringKey = KeyCode.Space;
    public UnityEvent triggeredEvents;
    public bool fireOnce = true;
    private bool alreadyTriggered = false;

    private void OnEnable()
    {
        alreadyTriggered = false;
    }

    private void Update()
    {
        if (fireOnce && alreadyTriggered) return;

        if (Input.GetKeyDown(triggeringKey))
        {
            triggeredEvents.Invoke();
            alreadyTriggered = true;
        }

    }
}
