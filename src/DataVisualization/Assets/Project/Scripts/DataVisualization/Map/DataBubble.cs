using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class DataBubble : MonoBehaviour
{
    [SerializeField] float size = 1.0f;
    [SerializeField] Color color = Color.magenta;
    [SerializeField] Image sprite;
    [SerializeField] TextMeshProUGUI text;


    [SerializeField] private float minSize = 20f;
    [SerializeField] private float maxSize = 100f;


    // Start is called before the first frame update
    void Start()
    {
        sprite.color = color;
        text.color = color;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void SetCoordinates(float latitude, float longitude)
    {
        text.text =
            $"LAT: {latitude:F4}\nLON: {longitude:F4}";
    }

    public void SetValue(float normalizedValue)
    {
        float size = Mathf.Lerp(
            minSize,
            maxSize,
            normalizedValue
        );

        transform.localScale = Vector3.one * size;
    }

    public void SetText(string value)
    {
        text.text = value;
    }
}
