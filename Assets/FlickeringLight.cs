using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlickeringLight : MonoBehaviour
{
    private Light itsLight;
    private float defaultIntensity;
    private float defaultAngle;
    private Vector3 defaultPosition;

    private void Awake()
    {
        itsLight = GetComponent<Light>();
        defaultIntensity = itsLight.intensity;
        defaultAngle = itsLight.spotAngle;
        defaultPosition = transform.position;
    }

    private void OnEnable()
    {
        StopAllCoroutines();
        StartCoroutine(FlickIntensity());
        StartCoroutine(FlickAngle());
        StartCoroutine(FlickPosition());
    }

    private IEnumerator FlickIntensity()
    {
        while (true)
        {
            itsLight.intensity = Random.Range(defaultIntensity*0.75f, defaultIntensity*1.25f);

            yield return new WaitForSeconds(Random.Range(0.05f,0.5f));
        }
    }


    private IEnumerator FlickAngle()
    {
        while (true)
        {
            itsLight.spotAngle = Random.Range(defaultAngle * 0.75f, defaultAngle * 1.25f);

            yield return new WaitForSeconds(Random.Range(0.05f, 0.5f));
        }
    }

    private IEnumerator FlickPosition()
    {
        while (true)
        {
            itsLight.transform.position = defaultPosition+(Random.onUnitSphere*(Random.Range(0.01f,0.03f)));

            yield return new WaitForSeconds(Random.Range(0.05f, 0.5f));
        }
    }
}
