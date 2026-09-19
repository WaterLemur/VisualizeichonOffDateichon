using UnityEngine;
using UnityEngine.InputSystem.EnhancedTouch;
using Touch = UnityEngine.InputSystem.EnhancedTouch.Touch;
using TouchPhase = UnityEngine.InputSystem.TouchPhase; // Fixes the ambiguous reference error

[RequireComponent(typeof(Camera))]
public class CameraController : MonoBehaviour
{
    [Header("Panning Settings")]
    [Tooltip("Speed multiplier for camera panning.")]
    public float panSpeed = 0.5f;
    
    [Header("Zoom Settings")]
    [Tooltip("Speed multiplier for pinch-to-zoom.")]
    public float zoomSpeed = 0.05f;
    
    [Tooltip("Minimum allowable size / Field of View.")]
    public float minZoom = 2f;
    
    [Tooltip("Maximum allowable size / Field of View.")]
    public float maxZoom = 20f;

    private Camera cam;

    void Awake()
    {
        cam = GetComponent<Camera>();
    }

    void OnEnable()
    {
        // EnhancedTouch must be explicitly enabled to track high-performance touch history
        EnhancedTouchSupport.Enable();
    }

    void OnDisable()
    {
        EnhancedTouchSupport.Disable();
    }

    void Update()
    {
        var activeTouches = Touch.activeTouches;

        // Handle 1-Finger Panning
        if (activeTouches.Count == 1)
        {
            Touch touch = activeTouches[0];

            if (touch.phase == TouchPhase.Moved)
            {
                // Invert delta to match natural drag direction (drag finger left -> camera moves right)
                Vector2 touchDelta = -touch.delta;
                
                // Scale panning speed based on how far zoomed out the camera currently is
                float currentMod = cam.orthographic ? cam.orthographicSize : cam.fieldOfView;
                Vector3 move = new Vector3(touchDelta.x, touchDelta.y, 0) * panSpeed * (currentMod / 100f) * Time.deltaTime;
                
                // Translate relative to the camera's local orientation
                transform.Translate(move, Space.Self);
            }
        }
        // Handle 2-Finger Pinch Zooming
        else if (activeTouches.Count == 2)
        {
            Touch touchZero = activeTouches[0];
            Touch touchOne = activeTouches[1];

            // Get current and previous frame touch locations
            Vector2 touchZeroCurrentPos = touchZero.screenPosition;
            Vector2 touchOneCurrentPos = touchOne.screenPosition;
            
            Vector2 touchZeroPrevPos = touchZeroCurrentPos - touchZero.delta;
            Vector2 touchOnePrevPos = touchOneCurrentPos - touchOne.delta;

            // Calculate change in distance between fingers
            float prevTouchDeltaMag = (touchZeroPrevPos - touchOnePrevPos).magnitude;
            float touchDeltaMag = (touchZeroCurrentPos - touchOneCurrentPos).magnitude;
            
            float deltaMagnitudeDiff = prevTouchDeltaMag - touchDeltaMag;

            // Apply zoom limits depending on projection type
            if (cam.orthographic)
            {
                cam.orthographicSize += deltaMagnitudeDiff * zoomSpeed;
                cam.orthographicSize = Mathf.Clamp(cam.orthographicSize, minZoom, maxZoom);
            }
            else
            {
                cam.fieldOfView += deltaMagnitudeDiff * zoomSpeed;
                cam.fieldOfView = Mathf.Clamp(cam.fieldOfView, minZoom, maxZoom);
            }
        }
    }
}
