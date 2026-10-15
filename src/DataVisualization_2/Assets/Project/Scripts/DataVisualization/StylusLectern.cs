using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StylusLectern : MonoBehaviour
{
    [Header("References")]
    [SerializeField] private Transform glass;
    [SerializeField] private Transform openPosition;
    [SerializeField] private Transform closedPosition;

    [Header("Movement")]
    [SerializeField] private float speed = 2f;

    [SerializeField] bool isOpen = false;

    void Start()
    {
        if (isOpen) Open();
        else Close();
    }

    void OnMouseDown()
    {
        isOpen = !isOpen;

        if (isOpen) Open();
        else Close();
    }

    public void Open()
    {
        StopAllCoroutines();
        StartCoroutine(MoveTo(openPosition));
    }

    public void Close()
    {
        StopAllCoroutines();
        StartCoroutine(MoveTo(closedPosition));
    }

    private System.Collections.IEnumerator MoveTo(Transform destination)
    {
        while (Vector3.Distance(glass.position, destination.position) > 0.01f)
        {
            glass.position = Vector3.MoveTowards(
                glass.position,
                destination.position,
                speed * Time.deltaTime
            );

            yield return null;
        }

        glass.position = destination.position;
    }
}
