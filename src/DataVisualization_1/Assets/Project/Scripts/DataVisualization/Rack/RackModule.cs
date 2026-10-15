using System.Collections.Generic;
using UnityEngine;

public class RackModule : MonoBehaviour
{
    [Header("Subdivision")]
    [SerializeField] private ModuleDirection direction = ModuleDirection.Horizontal;

    [Min(1)]
    [SerializeField] private int divisions = 1;

    [Header("Post")]
    [SerializeField] private float postThickness = 0.25f;
    [SerializeField] private float postDepth = 0.25f;

    private Transform background;
    private Transform posts;

    private readonly List<GameObject> generatedPosts = new();

    private void Awake()
    {
        BuildModule();
    }

    private void OnValidate()
    {
        BuildModule();
    }

    private void FindParts()
    {
        background = transform.Find("Background");
        posts = transform.Find("Posts");
    }

    private void BuildModule()
    {
        FindParts();

        if (background == null || posts == null)
            return;

        ClearPosts();
        GeneratePosts();
    }

    private void ClearPosts()
    {
        for (int i = generatedPosts.Count - 1; i >= 0; i--)
        {
            GameObject post = generatedPosts[i];

            if (post == null)
                continue;

            if (Application.isPlaying)
                Destroy(post);
            else
                DestroyImmediate(post);
        }

        generatedPosts.Clear();
    }

    private void GeneratePosts()
    {
        if (divisions <= 1)
            return;

        Vector3 size = background.localScale;

        if (direction == ModuleDirection.Horizontal)
        {
            GenerateHorizontalPosts(size);
        }
        else
        {
            GenerateVerticalPosts(size);
        }
    }

    private void GenerateHorizontalPosts(Vector3 size)
    {
        float spacing = size.y / divisions;

        for (int i = 1; i < divisions; i++)
        {
            GameObject post = CreatePost();

            float y = -size.y * 0.5f + spacing * i;

            post.transform.localPosition = new Vector3(
                0f,
                y,
                -size.z * 0.5f
            );

            post.transform.localScale = new Vector3(
                size.x,
                postThickness,
                postDepth
            );
        }
    }

    private void GenerateVerticalPosts(Vector3 size)
    {
        float spacing = size.x / divisions;

        for (int i = 1; i < divisions; i++)
        {
            GameObject post = CreatePost();

            float x = -size.x * 0.5f + spacing * i;

            post.transform.localPosition = new Vector3(
                x,
                0f,
                -size.z * 0.5f
            );

            post.transform.localScale = new Vector3(
                postThickness,
                size.y,
                postDepth
            );
        }
    }

    private GameObject CreatePost()
    {
        GameObject post = GameObject.CreatePrimitive(
            PrimitiveType.Cube
        );

        post.name = "Post";
        post.transform.SetParent(posts, false);

        generatedPosts.Add(post);

        return post;
    }

    public Vector3 GetModuleSize()
    {
        if (background == null)
            return Vector3.zero;

        return background.localScale;
    }

    public float GetWidth()
    {
        return GetModuleSize().x;
    }

    public float GetHeight()
    {
        return GetModuleSize().y;
    }

    public float GetDepth()
    {
        return GetModuleSize().z;
    }

    public ModuleDirection GetDirection()
    {
        return direction;
    }

    public int GetDivisions()
    {
        return divisions;
    }
}