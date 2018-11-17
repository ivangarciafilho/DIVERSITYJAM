using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class FireEventOnTriggerEnter : MonoBehaviour
{
    public UnityEvent triggeredEvents;
    public bool fireOnce = true;
    private bool alreadyTriggered = false;

    private void OnEnable()
    {
        alreadyTriggered = false;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (alreadyTriggered && fireOnce) return;

        triggeredEvents.Invoke();
        alreadyTriggered = true;
    }
}
