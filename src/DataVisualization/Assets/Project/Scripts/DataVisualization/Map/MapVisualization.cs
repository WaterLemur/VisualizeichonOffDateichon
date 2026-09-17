using System.Collections.Generic;
using UnityEngine;

public class MapVisualization : MonoBehaviour, IDataVisualizer
{
    [Header("Data")]
    [SerializeField] private GoogleSheetsDataSource dataSource;

    [Header("Bubble")]
    [SerializeField] private GameObject bubblePrefab;
    [SerializeField] private Transform bubbleParent;

    [Header("Map")]
    [SerializeField] private RectTransform mapRect;
    [SerializeField] private MapCoordinateConverter coordinateConverter;

    [Header("City Colors")]
    [SerializeField] private Color akkadColor = Color.red;
    [SerializeField] private Color urColor = Color.blue;
    [SerializeField] private Color urukColor = Color.green;

    [Header("Value Range")]
    [SerializeField] private float minValue = 0f;
    [SerializeField] private float maxValue = 50000f;

    private readonly Dictionary<string, DataBubble> bubbles = new();

    private void OnEnable()
    {
        if (dataSource != null)
            dataSource.DataLoaded += OnDataLoaded;
    }

    private void OnDisable()
    {
        if (dataSource != null)
            dataSource.DataLoaded -= OnDataLoaded;
    }

    private void OnDataLoaded()
    {
        CreateCityBubbles(dataSource.CityPositions);
    }

    public void CreateCityBubbles(IReadOnlyList<CityPosition> cities)
    {
        ClearBubbles();

        foreach (CityPosition city in cities)
        {
            GameObject bubbleObject =
                Instantiate(bubblePrefab, bubbleParent);

            DataBubble bubble =
                bubbleObject.GetComponent<DataBubble>();

            if (bubble == null)
            {
                Debug.LogError(
                    "DataBubble prefab does not have a DataBubble component!"
                );

                Destroy(bubbleObject);
                continue;
            }

            Vector3 position =
                coordinateConverter.Convert(
                    city.latitude,
                    city.longitude
                );

            bubbleObject.transform.localPosition = position;

            bubble.SetCoordinates(
                city.latitude,
                city.longitude
            );

            bubble.SetColor(
                GetCityColor(city.city)
            );

            bubbles[city.city] = bubble;

            Debug.Log(
                $"Map: Created bubble for {city.city} at {position}"
            );
        }
    }

    public void RenderData(List<DataRecord> data)
    {
        foreach (DataRecord record in data)
        {
            if (!bubbles.TryGetValue(
                    record.city,
                    out DataBubble bubble))
            {
                continue;
            }

            if (!record.values.TryGetValue(
                    "CEBADA (GUR)",
                    out float value))
            {
                continue;
            }

            float normalizedValue =
                Mathf.InverseLerp(
                    minValue,
                    maxValue,
                    value
                );

            bubble.SetValue(normalizedValue);

            bubble.SetText(
                $"{record.city}\n{value:N0}"
            );
        }
    }

    private Color GetCityColor(string city)
    {
        switch (city.ToLower())
        {
            case "akkad":
                return akkadColor;

            case "ur":
                return urColor;

            case "uruk":
                return urukColor;

            default:
                return Color.white;
        }
    }

    private void ClearBubbles()
    {
        foreach (DataBubble bubble in bubbles.Values)
        {
            if (bubble != null)
                Destroy(bubble.gameObject);
        }

        bubbles.Clear();
    }
}