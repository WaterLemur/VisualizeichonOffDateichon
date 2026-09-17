using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class DataBubble : MonoBehaviour
{
    [Header("Bubble")]
    [SerializeField] private float size = 1.0f;
    [SerializeField] private Color color = Color.magenta;
    [SerializeField] private Image sprite;
    [SerializeField] private TextMeshProUGUI text;

    [Header("Size")]
    [SerializeField] private float minSize = 20f;
    [SerializeField] private float maxSize = 100f;

    private RectTransform rectTransform;

    private void Awake()
    {
        rectTransform = GetComponent<RectTransform>();
    }

    private void Start()
    {
        sprite.color = color;
        text.color = color;
    }

    public void SetColor(Color newColor)
    {
        color = newColor;

        sprite.color = color;
        text.color = color;
    }

    public void SetCoordinates(float latitude, float longitude)
    {
        text.text =
            $"LAT: {latitude:F4}\nLON: {longitude:F4}";
    }

    public void SetValue(float normalizedValue)
    {
        normalizedValue = Mathf.Clamp01(normalizedValue);

        float bubbleSize = Mathf.Lerp(
            minSize,
            maxSize,
            normalizedValue
        );

        rectTransform.sizeDelta = new Vector2(
            bubbleSize,
            bubbleSize
        );
    }

    public void SetText(string value)
    {
        text.text = value;
    }
}