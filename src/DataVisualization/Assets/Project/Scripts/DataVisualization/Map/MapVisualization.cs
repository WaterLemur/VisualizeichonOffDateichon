using System.Collections.Generic;
using UnityEngine;

public class MapVisualization : MonoBehaviour, IDataVisualizer
{
    [Header("Data")]
    [SerializeField] private GoogleSheetsDataSource dataSource;

    [Header("Bubble")]
    [SerializeField] private GameObject bubblePrefab;
    [SerializeField] private Transform bubbleParent;
    [SerializeField] private float bubbleSize = 60f;

    [Header("Map")]
    [SerializeField] private RectTransform mapRect;
    [SerializeField] private MapCoordinateConverter coordinateConverter;

    [Header("City Colors")]
    [SerializeField] private Color akkadColor = Color.red;
    [SerializeField] private Color urColor = Color.blue;
    [SerializeField] private Color urukColor = Color.green;

    private readonly Dictionary<string, DataBubble> bubbles = new();

    private void OnEnable()
    {
        if (dataSource == null)
            return;

        dataSource.DataLoaded += OnDataLoaded;

        if (dataSource.IsLoaded)
            OnDataLoaded();
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

        if (bubblePrefab == null)
        {
            Debug.LogError(
                "MapVisualization: Bubble Prefab is not assigned."
            );

            return;
        }

        if (bubbleParent == null)
        {
            Debug.LogError(
                "MapVisualization: Bubble Parent is not assigned."
            );

            return;
        }

        if (coordinateConverter == null)
        {
            Debug.LogError(
                "MapVisualization: Coordinate Converter is not assigned."
            );

            return;
        }

        foreach (CityPosition city in cities)
        {
            GameObject bubbleObject = Instantiate(
                bubblePrefab,
                bubbleParent
            );

            DataBubble bubble =
                bubbleObject.GetComponent<DataBubble>();

            if (bubble == null)
            {
                Debug.LogError(
                    "MapVisualization: Bubble prefab does not have a DataBubble component!"
                );

                Destroy(bubbleObject);
                continue;
            }

            Vector2 position = coordinateConverter.Convert(
                city.latitude,
                city.longitude
            );

            RectTransform bubbleRect =
                bubbleObject.GetComponent<RectTransform>();

            if (bubbleRect != null)
            {
                bubbleRect.anchoredPosition = position;
            }

            bubble.SetSize(bubbleSize);

            bubble.SetCoordinates(
                city.latitude,
                city.longitude
            );

            bubble.SetColor(
                GetCityColor(city.city)
            );

            bubbles[city.city] = bubble;
            bubbleObject.SetActive(false);
        }
    }

    public void RenderData(List<DataRecord> data)
    {
        if (data == null)
            return;

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

            bubble.SetSize(bubbleSize);

            bubble.SetText(
                $"{record.city}\n{value:N0}"
            );
        }
    }

    private Color GetCityColor(string city)
    {
        if (string.IsNullOrEmpty(city))
            return Color.white;

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




    public void ToggleCity(string city)
    {
        if (!bubbles.TryGetValue(city, out DataBubble bubble))
            return;

        bubble.gameObject.SetActive(!bubble.gameObject.activeSelf);
    }

    public void SetCityActive(string city, bool active)
    {
        if (!bubbles.TryGetValue(city, out DataBubble bubble))
            return;

        bubble.gameObject.SetActive(active);
    }

    public void ToggleAkkad()
    {
        ToggleCity("Akkad");
    }

    public void ToggleUr()
    {
        ToggleCity("Ur");
    }

    public void ToggleUruk()
    {
        ToggleCity("Uruk");
    }
}