using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProtagonistMovement : MonoBehaviour
{
    public Rigidbody itsRigidbody;
    public Vector2 playableAreaWidth;
    public Vector2 playableAreaDepth;
    private int walkingAnimationHash;
    Vector3 newPosition = new Vector3();
    [SerializeField]float speed = 3f;

    //private void Awake()
    //{
    //    walkingAnimationHash = Animator.StringToHash("Walking");
    //}

    // Update is called once per frame
    private Vector3 leftMirror = new Vector3(-1,1f,1f);
    private Vector3 rightMirror = new Vector3(1,1f,1f);
    void FixedUpdate()
    {
        var smoothing = speed * Time.smoothDeltaTime;
        newPosition.x = (Input.GetAxis("Horizontal") * smoothing);
        newPosition.z = (Input.GetAxis("Vertical") * smoothing);
        if (newPosition.x !=  0)
        {
            if (newPosition.x < 0 )
            {
                transform.localScale = leftMirror;
            }
            else
            {
                transform.localScale = rightMirror;
            }
        }

        itsRigidbody.MovePosition (transform.position + newPosition);
        //var clampedPosition = transform.position;
        //clampedPosition.x = Mathf.Clamp(clampedPosition.x, playableAreaWidth.x, playableAreaWidth.y);
        //clampedPosition.z = Mathf.Clamp(clampedPosition.z, playableAreaDepth.x, playableAreaDepth.y);
        //transform.position = clampedPosition;

        //if (newPosition.x == 0 && newPosition.z == 0)
        //{
        //    itsAnimator.SetBool(walkingAnimationHash, false);
        //}
        //else
        //{
        //    itsAnimator.SetBool(walkingAnimationHash, true);
        //}
    }
}
