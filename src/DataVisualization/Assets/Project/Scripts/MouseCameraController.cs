using UnityEngine;

[RequireComponent(typeof(Camera))]
public class MouseCameraController : MonoBehaviour
{
    [Header("Edge Panning")]
    [SerializeField] private bool enableEdgePanning = true;
    [SerializeField] private float edgeSize = 30f;
    [SerializeField] private float edgePanSpeed = 10f;

    [Header("Middle Mouse Panning")]
    [SerializeField] private bool enableMiddleMousePan = true;
    [SerializeField] private float middleMousePanSpeed = 1f;

    [Header("Zoom")]
    [SerializeField] private bool enableScrollZoom = true;
    [SerializeField] private float zoomSpeed = 2f;
    [SerializeField] private float minZoom = 2f;
    [SerializeField] private float maxZoom = 20f;

    [Header("Right Click Camera Position")]
    [SerializeField] private bool enableRightClickPosition = true;
    [SerializeField] private Transform rightClickPosition;

    private Camera cam;

    private void Awake()
    {
        cam = GetComponent<Camera>();
    }

    private void Update()
    {
        HandleEdgePanning();
        HandleMiddleMousePanning();
        HandleScrollZoom();
        HandleRightClick();
    }

    private void HandleEdgePanning()
    {
        if (!enableEdgePanning)
            return;

        Vector3 move = Vector3.zero;
        Vector3 mousePosition = Input.mousePosition;

        if (mousePosition.x <= edgeSize)
            move += Vector3.left;

        if (mousePosition.x >= Screen.width - edgeSize)
            move += Vector3.right;

        if (mousePosition.y <= edgeSize)
            move += Vector3.down;

        if (mousePosition.y >= Screen.height - edgeSize)
            move += Vector3.up;

        if (move.sqrMagnitude > 0f)
        {
            transform.Translate(
                move.normalized * edgePanSpeed * Time.deltaTime,
                Space.World
            );
        }
    }

    private void HandleMiddleMousePanning()
    {
        if (!enableMiddleMousePan)
            return;

        if (!Input.GetMouseButton(2))
            return;

        float horizontal = -Input.GetAxis("Mouse X");
        float vertical = -Input.GetAxis("Mouse Y");

        Vector3 move = new Vector3(
            horizontal,
            vertical,
            0f
        );

        // Reduce pan speed when zoomed in.
        float zoomMultiplier = cam.orthographic
            ? cam.orthographicSize / maxZoom
            : cam.fieldOfView / maxZoom;

        zoomMultiplier = Mathf.Clamp01(zoomMultiplier);

        transform.Translate(
            move * middleMousePanSpeed * zoomMultiplier,
            Space.World
        );
    }

    private void HandleScrollZoom()
    {
        if (!enableScrollZoom)
            return;

        float scroll = Input.mouseScrollDelta.y;

        if (Mathf.Approximately(scroll, 0f))
            return;

        if (cam.orthographic)
        {
            cam.orthographicSize -= scroll * zoomSpeed;

            cam.orthographicSize = Mathf.Clamp(
                cam.orthographicSize,
                minZoom,
                maxZoom
            );
        }
        else
        {
            cam.fieldOfView -= scroll * zoomSpeed;

            cam.fieldOfView = Mathf.Clamp(
                cam.fieldOfView,
                minZoom,
                maxZoom
            );
        }
    }

    private void HandleRightClick()
    {
        if (!enableRightClickPosition)
            return;

        if (rightClickPosition == null)
            return;

        if (Input.GetMouseButtonDown(1))
        {
            transform.position = rightClickPosition.position;
            transform.rotation = rightClickPosition.rotation;
        }
    }
}