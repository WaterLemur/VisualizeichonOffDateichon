using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Background : MonoBehaviour
{
    [SerializeField] float speed = 1.0f;
    [SerializeField] float distance = 5.0f;
    
    private Vector3 startPosition;
    private float timeTracker;

    float speedMultiplier  = 0.1f;



    void Start()
    {
        // Store the initial position as the baseline anchor
        startPosition = transform.position;
    }

    void Update()
    {
        ParallaxMovement();
    }

    public void ParallaxMovement()
    {
        // 1. Increment time linearly based on speed
        timeTracker += Time.deltaTime * speed * speedMultiplier;

        // 2. PingPong creates a value that bounces smoothly between 0 and 1
        float linearValue = Mathf.PingPong(timeTracker, 1.0f);

        // 3. SmoothStep applies an ease-in/ease-out curve to eliminate harsh stops
        float smoothValue = Mathf.SmoothStep(0.0f, 1.0f, linearValue);

        // 4. Interpolate between the far left and far right bounds
        float targetX = Mathf.Lerp(startPosition.x - distance, startPosition.x + distance, smoothValue);

        // 5. Apply the smooth position
        transform.position = new Vector3(targetX, transform.position.y, transform.position.z);
    }
}
