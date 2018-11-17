using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProtagonistMovement : MonoBehaviour
{
    public Animator itsAnimator;
    public Vector2 playableAreaWidth;
    public Vector2 playableAreaDepth;
    private int walkingAnimationHash;
    Vector3 newPosition = new Vector3();
    [SerializeField]float speed = 3f;

    private void Awake()
    {
        walkingAnimationHash = Animator.StringToHash("Walking");
    }

    // Update is called once per frame
    void Update()
    {
        var smoothing = speed * Time.smoothDeltaTime;
        newPosition.x = (Input.GetAxis("Horizontal") * smoothing);
        newPosition.z = (Input.GetAxis("Vertical") * smoothing);

        transform.position += newPosition;
        var clampedPosition = transform.position;
        clampedPosition.x = Mathf.Clamp(clampedPosition.x, playableAreaWidth.x, playableAreaWidth.y);
        clampedPosition.z = Mathf.Clamp(clampedPosition.z, playableAreaDepth.x, playableAreaDepth.y);
        transform.position = clampedPosition;

        if (newPosition.x == 0 && newPosition.z == 0)
        {
            itsAnimator.SetBool(walkingAnimationHash, false);
        }
        else
        {
            itsAnimator.SetBool(walkingAnimationHash, true);
        }
    }
}
