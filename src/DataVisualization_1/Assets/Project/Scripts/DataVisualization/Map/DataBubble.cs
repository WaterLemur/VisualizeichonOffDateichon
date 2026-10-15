using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class DataBubble : MonoBehaviour
{
    [Header("Bubble")]
    [SerializeField] private float size = 1f;
    [SerializeField] private Color color = Color.magenta;
    [SerializeField] private Image sprite;
    [SerializeField] private TextMeshProUGUI text;

    private void Awake()
    {
        ApplySize();
    }

    private void Start()
    {
        SetColor(color);
    }

    public void SetSize(float newSize)
    {
        size = newSize;
        ApplySize();
    }

    private void ApplySize()
    {
        if (sprite == null)
            return;

        sprite.transform.localScale =
            Vector3.one * size;
    }

    public void SetColor(Color newColor)
    {
        color = newColor;

        if (sprite != null)
            sprite.color = color;

        if (text != null)
            text.color = color;
    }

    public void SetCoordinates(
        float latitude,
        float longitude)
    {
        if (text == null)
            return;

        text.text =
            $"LAT: {latitude:F4}\nLON: {longitude:F4}";
    }

    public void SetText(string value)
    {
        if (text != null)
            text.text = value;
    }
}