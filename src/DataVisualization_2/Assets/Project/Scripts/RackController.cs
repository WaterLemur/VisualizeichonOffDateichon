using UnityEngine;

public class RackController : MonoBehaviour
{
    [Header("Doors")]
    [SerializeField] private Transform leftDoor;
    [SerializeField] private Transform rightDoor;

    [Header("Settings")]
    [SerializeField] private float openingAngle = 90f;
    [SerializeField] private float openingSpeed = 2f;

    private Quaternion leftClosedRotation;
    private Quaternion rightClosedRotation;

    private Quaternion leftOpenRotation;
    private Quaternion rightOpenRotation;

    private bool isOpen;
    private bool isMoving;

    [SerializeField] bool openOnStart = true;

    private void Awake()
    {
        leftClosedRotation = leftDoor.localRotation;
        rightClosedRotation = rightDoor.localRotation;

        leftOpenRotation = leftClosedRotation * Quaternion.Euler(0f, -openingAngle, 0f);
        rightOpenRotation = rightClosedRotation * Quaternion.Euler(0f, openingAngle, 0f);
    
        if(openOnStart) OpenDoors();
    }

    private void Update()
    {
        if (!isMoving)
            return;

        Quaternion leftTarget = isOpen
            ? leftOpenRotation
            : leftClosedRotation;

        Quaternion rightTarget = isOpen
            ? rightOpenRotation
            : rightClosedRotation;

        leftDoor.localRotation = Quaternion.RotateTowards(
            leftDoor.localRotation,
            leftTarget,
            openingSpeed * 90f * Time.deltaTime
        );

        rightDoor.localRotation = Quaternion.RotateTowards(
            rightDoor.localRotation,
            rightTarget,
            openingSpeed * 90f * Time.deltaTime
        );

        if (Quaternion.Angle(leftDoor.localRotation, leftTarget) < 0.1f &&
            Quaternion.Angle(rightDoor.localRotation, rightTarget) < 0.1f)
        {
            leftDoor.localRotation = leftTarget;
            rightDoor.localRotation = rightTarget;

            isMoving = false;
        }
    }

    public void OpenDoors()
    {
        isOpen = true;
        isMoving = true;
    }

    public void CloseDoors()
    {
        isOpen = false;
        isMoving = true;
    }
}