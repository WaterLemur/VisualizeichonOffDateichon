using UnityEngine;

public class Rack : MonoBehaviour
{
    [Header("Rack Dimensions")]
    [SerializeField] private float width = 10f;
    [SerializeField] private float height = 6f;
    [SerializeField] private float depth = 0.5f;

    [Header("Part Thickness")]
    [SerializeField] private float postWidth = 0.5f;
    [SerializeField] private float railHeight = 0.5f;

    private Transform leftPost;
    private Transform rightPost;
    private Transform top;
    private Transform bottom;

    private void Awake()
    {
        FindParts();
        BuildRack();
    }

    private void OnValidate()
    {
        FindParts();
        BuildRack();
    }

    private void FindParts()
    {
        leftPost = transform.Find("LeftPost");
        rightPost = transform.Find("RightPost");
        top = transform.Find("Top");
        bottom = transform.Find("Bottom");
    }

    private void BuildRack()
    {
        if (leftPost == null ||
            rightPost == null ||
            top == null ||
            bottom == null)
        {
            return;
        }

        float halfWidth = width * 0.5f;
        float halfHeight = height * 0.5f;

        // LEFT POST
        leftPost.localPosition = new Vector3(
            -halfWidth + postWidth * 0.5f,
            0f,
            0f
        );

        leftPost.localScale = new Vector3(
            postWidth,
            height,
            depth
        );

        // RIGHT POST
        rightPost.localPosition = new Vector3(
            halfWidth - postWidth * 0.5f,
            0f,
            0f
        );

        rightPost.localScale = new Vector3(
            postWidth,
            height,
            depth
        );

        // TOP
        top.localPosition = new Vector3(
            0f,
            halfHeight - railHeight * 0.5f,
            0f
        );

        top.localScale = new Vector3(
            width,
            railHeight,
            depth
        );

        // BOTTOM
        bottom.localPosition = new Vector3(
            0f,
            -halfHeight + railHeight * 0.5f,
            0f
        );

        bottom.localScale = new Vector3(
            width,
            railHeight,
            depth
        );
    }
}